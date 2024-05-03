import 'dart:convert';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../models/now_playing_model.dart';
import '../models/top_rated_model.dart';

class CacheService {
  final DefaultCacheManager _cacheManager;

  CacheService() : _cacheManager = DefaultCacheManager();

  Future<NowPlayingMovies?> getNowPlayingMovies(String pageNumber) async {
    try {
      var file = await _cacheManager
          .getFileFromCache('now_playing_movies_$pageNumber');
      if (file != null) {
        var json = await file.file.readAsString();
        return NowPlayingMovies.fromJson(jsonDecode(json));
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> cacheNowPlayingMovies(
      NowPlayingMovies movies, String pageNumber) async {
    try {
      var json = jsonEncode(movies.toJson());
      await _cacheManager.putFile(
          'now_playing_movies_$pageNumber', utf8.encode(json));
    } catch (e) {
      rethrow;
    }
  }

  Future<TopRatedMovies?> getTopRatedMovies(String pageNumber) async {
    try {
      var file =
          await _cacheManager.getFileFromCache('top_rated_movies_$pageNumber');
      if (file != null) {
        var json = await file.file.readAsString();
        return TopRatedMovies.fromJson(jsonDecode(json));
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> cacheTopRatedMovies(
      TopRatedMovies movies, String pageNumber) async {
    try {
      var json = jsonEncode(movies.toJson());
      await _cacheManager.putFile(
          'top_rated_movies_$pageNumber', utf8.encode(json));
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getCachedMainAddress() async {
    try {
      var file = await _cacheManager.getFileFromCache('mainAddress');
      if (file != null) {
        var address = await file.file.readAsString();
        return address;
      }
      return "";
    } catch (e) {
      rethrow;
    }
  }

  Future<void> cacheMainAddress(String address) async {
    try {
      await _cacheManager.putFile('mainAddress', utf8.encode(address));
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getCachedSecondaryAddress() async {
    try {
      var file = await _cacheManager.getFileFromCache('secondaryAddress');
      if (file != null) {
        var address = await file.file.readAsString();
        return address;
      }
      return "";
    } catch (e) {
      rethrow;
    }
  }

  Future<void> cacheSecondaryAddress(String address) async {
    try {
      await _cacheManager.putFile('secondaryAddress', utf8.encode(address));
    } catch (e) {
      rethrow;
    }
  }
}
