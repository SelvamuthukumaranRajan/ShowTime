import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/now_playing_model.dart';
import '../models/top_rated_model.dart';

class ApiService {
  static const String baseUrl = 'https://api.themoviedb.org/3/movie';
  static const Duration timeoutDuration = Duration(seconds: 20);

  Future<NowPlayingMovies> getNowPlayingMovies(String pageNumber) async {
    final Uri uri =
        Uri.parse('$baseUrl/now_playing?language=en-US&page=$pageNumber');

    try {
      final response = await _retry(() => http.get(
            uri,
            headers: _defaultHeaders(),
          ));
      if (response.statusCode == 200) {
        final decodedJson = json.decode(response.body);
        return NowPlayingMovies.fromJson(decodedJson);
      } else {
        throw Exception(
            'Error ${response.statusCode}: Failed to load now playing movies');
      }
    } catch (e) {
      throw Exception('Failed to load now playing movies: $e');
    }
  }

  Future<TopRatedMovies> getTopRatedMovies(String pageNumber) async {
    final Uri uri =
        Uri.parse('$baseUrl/top_rated?language=en-US&page=$pageNumber');

    try {
      final response = await _retry(() => http.get(
            uri,
            headers: _defaultHeaders(),
          ));
      if (response.statusCode == 200) {
        final decodedJson = json.decode(response.body);
        return TopRatedMovies.fromJson(decodedJson);
      } else {
        throw Exception(
            'Error ${response.statusCode}: Failed to load top rated movies');
      }
    } catch (e) {
      throw Exception('Failed to load top rated movies: $e');
    }
  }

  Future<http.Response> _retry(Future<http.Response> Function() request,
      {int retries = 5, Duration delay = const Duration(seconds: 5)}) async {
    for (var attempt = 0; attempt < retries; attempt++) {
      try {
        return await request().timeout(timeoutDuration);
      } catch (e) {
        if (attempt < retries - 1) {
          await Future.delayed(delay);
        }
      }
    }
    throw Exception('Retry limit exceeded');
  }

  Map<String, String> _defaultHeaders() {
    return {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2YTg3ZTY4MDMyODIwMTIzZmQ0Yzg0YjQzNDhjYjc3ZCIsInN1YiI6IjY2Mjg5NDExOTFmMGVhMDE0YjAwOWU1ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.6zIM73Giwg5M4wP6MX8KDCpee7IMnpnLTZUyMpETb08',
      'Accept': 'application/json',
    };
  }
}
