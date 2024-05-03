import 'package:show_time/features/home/domain/entity/now_playing_entity.dart';
import 'package:show_time/features/home/domain/repository/movie_repository.dart';

import '../../../../core/usecase/usecase.dart';

class GetNowPlayingUseCase implements UseCase<NowPlayingMoviesEntity, String> {
  final MovieRepository movieRepository;

  GetNowPlayingUseCase(this.movieRepository);

  @override
  Future<NowPlayingMoviesEntity> call({String? params}) async {
    final pageNumber = params ?? "1";
    return await movieRepository.getNowPlayingMovies(pageNumber);
  }
}