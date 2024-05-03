import 'package:show_time/features/home/domain/entity/top_rated_entity.dart';
import 'package:show_time/features/home/domain/repository/movie_repository.dart';

import '../../../../core/usecase/usecase.dart';

class GetTopRatedUseCase implements UseCase<TopRatedMoviesEntity, String> {
  final MovieRepository movieRepository;

  GetTopRatedUseCase(this.movieRepository);

  @override
  Future<TopRatedMoviesEntity> call({String? params}) async {
    final pageNumber = params ?? "1";
    return movieRepository.getTopRatedMovies(pageNumber);
  }
}
