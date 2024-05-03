import 'package:get_it/get_it.dart';
import 'package:show_time/features/home/data/data_sources/api_service.dart';
import 'package:show_time/features/home/data/data_sources/cache_services.dart';
import 'package:show_time/features/home/data/repository/movie_repository_impl.dart';
import 'package:show_time/features/home/domain/repository/movie_repository.dart';
import 'package:show_time/features/home/domain/usecase/get_cached_now_playing.dart';
import 'package:show_time/features/home/domain/usecase/get_cached_top_rated.dart';
import 'package:show_time/features/home/domain/usecase/get_now_playing.dart';
import 'package:show_time/features/home/domain/usecase/get_top_rated.dart';
import 'package:show_time/features/home/presentation/blocs/movies_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initializeDependencies() async {
  serviceLocator.registerSingleton<ApiService>(ApiService());
  serviceLocator.registerSingleton<CacheService>(CacheService());

  serviceLocator.registerSingleton<MovieRepository>(MovieRepositoryImplementation(
      apiService: serviceLocator(), cacheService: serviceLocator()));

  serviceLocator.registerSingleton<GetNowPlayingUseCase>(
      GetNowPlayingUseCase(serviceLocator()));
  serviceLocator
      .registerSingleton<GetTopRatedUseCase>(GetTopRatedUseCase(serviceLocator()));
  serviceLocator.registerSingleton<GetCachedNowPlayingUseCase>(
      GetCachedNowPlayingUseCase(serviceLocator()));
  serviceLocator.registerSingleton<GetCachedTopRatedUseCase>(
      GetCachedTopRatedUseCase(serviceLocator()));

  serviceLocator.registerSingleton<MoviesBloc>(
      MoviesBloc(serviceLocator(), serviceLocator(), serviceLocator(), serviceLocator()));
}
