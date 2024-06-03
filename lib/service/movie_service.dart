import 'package:the_movie_db/model/movie_model.dart';
import 'package:the_movie_db/repository/movie_repository.dart';

class MovieDBService {
  final MovieRepository repository;

  MovieDBService(this.repository);

  Future<List<MovieModel>> getMovies(String title) async {
    if (title.isEmpty) {
      return repository.getUpComming();
    }

    return repository.findMovies(title);
  }
}
