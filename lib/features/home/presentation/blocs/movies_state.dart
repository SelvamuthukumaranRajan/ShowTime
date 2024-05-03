part of 'movies_bloc.dart';

sealed class MoviesState extends Equatable {
  final NowPlayingMoviesEntity? nowPlayingMoviesEntity;
  final TopRatedMoviesEntity? topRatedMoviesEntity;

  const MoviesState(this.nowPlayingMoviesEntity, this.topRatedMoviesEntity);
}

final class MoviesLoading extends MoviesState {
  const MoviesLoading(super.nowPlayingMoviesEntity, super.topRatedMoviesEntity);

  @override
  List<Object> get props => [];
}

final class MoviesFailure extends MoviesState {
  const MoviesFailure(super.nowPlayingMoviesEntity, super.topRatedMoviesEntity);

  @override
  List<Object> get props => [];
}

final class MoviesSuccess extends MoviesState {
  final NowPlayingMoviesEntity nowPlayingMovies;
  final TopRatedMoviesEntity topRatedMovies;

  const MoviesSuccess(this.nowPlayingMovies, this.topRatedMovies)
      : super(nowPlayingMovies, topRatedMovies);

  @override
  List<Object> get props => [];
}

final class MoviesRefreshFailure extends MoviesState {
  const MoviesRefreshFailure(
      super.nowPlayingMoviesEntity, super.topRatedMoviesEntity);

  @override
  List<Object> get props => [];
}

final class MoviesSearch extends MoviesState {
  const MoviesSearch(super.nowPlayingMoviesEntity, super.topRatedMoviesEntity);

  @override
  List<Object> get props => [];
}

final class MoviesLoadMoreNowPLayingLoading extends MoviesState {
  const MoviesLoadMoreNowPLayingLoading(
      super.nowPlayingMoviesEntity, super.topRatedMoviesEntity);

  @override
  List<Object> get props => [];
}

final class MoviesLoadMoreNowPLayingFailure extends MoviesState {
  const MoviesLoadMoreNowPLayingFailure(
      super.nowPlayingMoviesEntity, super.topRatedMoviesEntity);

  @override
  List<Object> get props => [];
}

final class MoviesLoadMoreTopRatedLoading extends MoviesState {
  const MoviesLoadMoreTopRatedLoading(
      super.nowPlayingMoviesEntity, super.topRatedMoviesEntity);

  @override
  List<Object> get props => [];
}

final class MoviesLoadMoreTopRatedFailure extends MoviesState {
  const MoviesLoadMoreTopRatedFailure(
      super.nowPlayingMoviesEntity, super.topRatedMoviesEntity);

  @override
  List<Object> get props => [];
}
