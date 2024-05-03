import 'package:show_time/features/home/domain/entity/now_playing_entity.dart';
import 'package:show_time/features/home/domain/entity/top_rated_entity.dart';

abstract class MovieRepository {
  Future<NowPlayingMoviesEntity> getNowPlayingMovies(String pageNumber);

  Future<NowPlayingMoviesEntity?> getCachedNowPlayingMovies(String pageNumber);

  Future<TopRatedMoviesEntity> getTopRatedMovies(String pageNumber);

  Future<TopRatedMoviesEntity?> getCachedTopRatedMovies(String pageNumber);
}
