import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:show_time/features/home/domain/entity/now_playing_entity.dart';
import 'package:show_time/features/home/domain/entity/top_rated_entity.dart';
import 'package:show_time/features/home/domain/usecase/get_cached_now_playing.dart';
import 'package:show_time/features/home/domain/usecase/get_cached_top_rated.dart';
import 'package:show_time/features/home/domain/usecase/get_top_rated.dart';

import '../../domain/usecase/get_now_playing.dart';

part 'movies_event.dart';

part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetNowPlayingUseCase getNowPlayingUseCase;
  final GetTopRatedUseCase getTopRatedUseCase;
  final GetCachedNowPlayingUseCase getCachedNowPlayingUseCase;
  final GetCachedTopRatedUseCase getCachedTopRatedUseCase;

  MoviesBloc(this.getNowPlayingUseCase, this.getTopRatedUseCase,
      this.getCachedNowPlayingUseCase, this.getCachedTopRatedUseCase)
      : super(const MoviesLoading(null, null)) {
    on<FetchMovies>(onGetMovies);
    on<RefreshMovies>(onRefreshMovies);
    on<SearchMovies>(onSearchMovies);
    on<LoadMoreNowPlayingMovies>(onLoadMoreNowPlayingMovies);
    on<LoadMoreTopRatedMovies>(onLoadMoreTopRatedMovies);
  }

  void onGetMovies(FetchMovies event, Emitter<MoviesState> emit) async {
    NowPlayingMoviesEntity? cachedNowPlayingData;
    TopRatedMoviesEntity? cachedTopRatedData;

    try {
      cachedNowPlayingData = await getCachedNowPlayingUseCase();
      cachedTopRatedData = await getCachedTopRatedUseCase();

      if (cachedNowPlayingData?.results?.isNotEmpty == true &&
          cachedTopRatedData?.results?.isNotEmpty == true) {
        emit(MoviesSuccess(cachedNowPlayingData!, cachedTopRatedData!));
      }

      final nowPlayingData = await getNowPlayingUseCase();
      final topRatedData = await getTopRatedUseCase();
      if (nowPlayingData.results!.isNotEmpty &&
          topRatedData.results!.isNotEmpty) {
        emit(MoviesSuccess(nowPlayingData, topRatedData));
      } else {
        if (cachedNowPlayingData == null && cachedTopRatedData == null) {
          emit(const MoviesFailure(null, null));
        }
      }
    } catch (e) {
      if (cachedNowPlayingData == null && cachedTopRatedData == null) {
        emit(const MoviesFailure(null, null));
      }
    }
  }

  void onRefreshMovies(RefreshMovies event, Emitter<MoviesState> emit) async {
    try {
      final nowPlayingData = await getNowPlayingUseCase();
      final topRatedData = await getTopRatedUseCase();

      if (nowPlayingData.results!.isNotEmpty &&
          topRatedData.results!.isNotEmpty) {
        emit(MoviesSuccess(nowPlayingData, topRatedData));
      } else {
        var cachedNowPlayingData = await getCachedNowPlayingUseCase();
        var cachedTopRatedData = await getCachedTopRatedUseCase();
        emit(MoviesRefreshFailure(cachedNowPlayingData, cachedTopRatedData));
      }
    } catch (e) {
      var cachedNowPlayingData = await getCachedNowPlayingUseCase();
      var cachedTopRatedData = await getCachedTopRatedUseCase();
      emit(MoviesRefreshFailure(cachedNowPlayingData, cachedTopRatedData));
    }
  }

  void onSearchMovies(SearchMovies event, Emitter<MoviesState> emit) async {
    final String query = event.query.trim();
    NowPlayingMoviesEntity nowPlayingMovies = event.nowPlayingMoviesEntity;
    TopRatedMoviesEntity topRatedMovies = event.topRatedMoviesEntity;
    try {
      if (query.isEmpty) {
        final cachedNowPlayingData = await getCachedNowPlayingUseCase();
        final cachedTopRatedData = await getCachedTopRatedUseCase();

        if (cachedNowPlayingData?.results?.isNotEmpty == true &&
            cachedTopRatedData?.results?.isNotEmpty == true) {
          emit(MoviesSuccess(cachedNowPlayingData!, cachedTopRatedData!));
          return;
        }
      }

      final filteredNowPlayingData = NowPlayingMoviesEntity(
        results: nowPlayingMovies.results!
            .where((movie) => movie.originalTitle!
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList(),
      );
      final filteredTopRatedData = TopRatedMoviesEntity(
        results: topRatedMovies.results!
            .where((movie) => movie.originalTitle!
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList(),
      );

      emit(MoviesSearch(filteredNowPlayingData, filteredTopRatedData));
    } catch (e) {
      emit(const MoviesFailure(null, null));
    }
  }

  void onLoadMoreNowPlayingMovies(
      LoadMoreNowPlayingMovies event, Emitter<MoviesState> emit) async {
    String pageNumber = event.pageNumber.toString();
    NowPlayingMoviesEntity nowPlayingMovies = event.nowPlayingMoviesEntity;
    TopRatedMoviesEntity topRatedMovies = event.topRatedMoviesEntity;
    emit(MoviesLoadMoreNowPLayingLoading(nowPlayingMovies, topRatedMovies));
    try {
      final nowPlayingData = await getNowPlayingUseCase(params: pageNumber);
      nowPlayingMovies.results!.addAll(nowPlayingData.results!);

      if (nowPlayingData.results!.isNotEmpty) {
        emit(MoviesSuccess(nowPlayingMovies, topRatedMovies));
      } else {
        emit(MoviesLoadMoreNowPLayingFailure(nowPlayingMovies, topRatedMovies));
      }
    } catch (e) {
      emit(MoviesLoadMoreNowPLayingFailure(nowPlayingMovies, topRatedMovies));
    }
  }

  void onLoadMoreTopRatedMovies(
      LoadMoreTopRatedMovies event, Emitter<MoviesState> emit) async {
    String pageNumber = event.pageNumber.toString();
    NowPlayingMoviesEntity nowPlayingMovies = event.nowPlayingMoviesEntity;
    TopRatedMoviesEntity topRatedMovies = event.topRatedMoviesEntity;
    emit(MoviesLoadMoreTopRatedLoading(nowPlayingMovies, topRatedMovies));
    try {
      final topRatedData = await getTopRatedUseCase(params: pageNumber);
      topRatedMovies.results!.addAll(topRatedData.results!);
      if (topRatedMovies.results!.isNotEmpty) {
        emit(MoviesSuccess(nowPlayingMovies, topRatedMovies));
      } else {
        emit(MoviesLoadMoreTopRatedFailure(nowPlayingMovies, topRatedMovies));
      }
    } catch (e) {
      emit(MoviesLoadMoreTopRatedFailure(nowPlayingMovies, topRatedMovies));
    }
  }
}
