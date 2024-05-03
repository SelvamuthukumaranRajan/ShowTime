part of 'movies_bloc.dart';

sealed class MoviesEvent extends Equatable {
  const MoviesEvent();
}

class FetchMovies extends MoviesEvent {
  const FetchMovies();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class RefreshMovies extends MoviesEvent {
  const RefreshMovies();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class SearchMovies extends MoviesEvent {
  final String query;
  final NowPlayingMoviesEntity nowPlayingMoviesEntity;
  final TopRatedMoviesEntity topRatedMoviesEntity;

  const SearchMovies(
      this.query, this.nowPlayingMoviesEntity, this.topRatedMoviesEntity);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoadMoreNowPlayingMovies extends MoviesEvent {
  final double pageNumber;
  final NowPlayingMoviesEntity nowPlayingMoviesEntity;
  final TopRatedMoviesEntity topRatedMoviesEntity;

  const LoadMoreNowPlayingMovies(
      this.pageNumber, this.nowPlayingMoviesEntity, this.topRatedMoviesEntity);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoadMoreTopRatedMovies extends MoviesEvent {
  final double pageNumber;
  final NowPlayingMoviesEntity nowPlayingMoviesEntity;
  final TopRatedMoviesEntity topRatedMoviesEntity;

  const LoadMoreTopRatedMovies(
      this.pageNumber, this.nowPlayingMoviesEntity, this.topRatedMoviesEntity);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
