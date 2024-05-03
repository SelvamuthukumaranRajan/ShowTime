import 'package:show_time/features/home/data/data_sources/api_service.dart';
import 'package:show_time/features/home/data/models/now_playing_model.dart';
import 'package:show_time/features/home/data/models/top_rated_model.dart';
import 'package:show_time/features/home/domain/repository/movie_repository.dart';
import '../data_sources/cache_services.dart';

class MovieRepositoryImplementation implements MovieRepository {
  final ApiService _apiService;
  final CacheService _cacheService;

  MovieRepositoryImplementation(
      {required ApiService apiService, required CacheService cacheService})
      : _apiService = apiService,
        _cacheService = cacheService;

  @override
  Future<NowPlayingMovies?> getCachedNowPlayingMovies(String pageNumber) async {
    try {
      return await _cacheService.getNowPlayingMovies(pageNumber);
    } catch (e) {
      throw Exception('Failed to load now playing movies: $e');
    }
  }

  @override
  Future<NowPlayingMovies> getNowPlayingMovies(String pageNumber) async {
    try {
      var cachedData = await _cacheService.getNowPlayingMovies(pageNumber);
      var latestData = await _apiService.getNowPlayingMovies(pageNumber);

      if (cachedData != null && cachedData == latestData) {
        return cachedData;
      }

      await _cacheService.cacheNowPlayingMovies(latestData, pageNumber);
      return latestData;
    } catch (e) {
      throw Exception('Failed to load now playing movies: $e');
    }
  }

  @override
  Future<TopRatedMovies?> getCachedTopRatedMovies(String pageNumber) async {
    try {
      return await _cacheService.getTopRatedMovies(pageNumber);
    } catch (e) {
      throw Exception('Failed to load now playing movies: $e');
    }
  }

  @override
  Future<TopRatedMovies> getTopRatedMovies(String pageNumber) async {
    try {
      var cachedData = await _cacheService.getTopRatedMovies(pageNumber);
      var latestData = await _apiService.getTopRatedMovies(pageNumber);

      if (cachedData != null && cachedData == latestData) {
        return cachedData;
      }

      await _cacheService.cacheTopRatedMovies(latestData, pageNumber);
      return latestData;
    } catch (e) {
      throw Exception('Failed to load now playing movies: $e');
    }
  }
}
