import 'package:show_time/features/home/domain/entity/top_rated_entity.dart';
import 'package:show_time/features/home/domain/repository/movie_repository.dart';

import '../../../../core/usecase/usecase.dart';

class GetCachedTopRatedUseCase
    implements UseCase<TopRatedMoviesEntity?, String> {
  final MovieRepository movieRepository;

  GetCachedTopRatedUseCase(this.movieRepository);

  @override
  Future<TopRatedMoviesEntity?> call({String? params}) async {
    final pageNumber = params ?? "1";
    return movieRepository.getCachedTopRatedMovies(pageNumber);
  }
}
