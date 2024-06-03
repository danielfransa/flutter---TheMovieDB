import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:the_movie_db/model/movie_model.dart';

class MovieRepository {
  static String apiKey = 'b417edac46940a89ab9ef14637cb826e';

  Future getData(String url) async {
    final response = await get(Uri.parse(url));

    if (response.statusCode == HttpStatus.ok) {
      return response.body;
    }

    throw Exception('Falha getDate(). URL: $url. Message: ${response.body}');
  }

  Future<List<MovieModel>> getUpComming() async {
    final String urlGetUpComming =
        'https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey&language=pt-BR&page=1';

    var json = await getData(urlGetUpComming);
    var movieMap = jsonDecode(json);
    var movieList = movieMap['results'];

    List<MovieModel> movies =
        movieList.map<MovieModel>((json) => MovieModel.fromJson(json)).toList();

    return movies;
  }

  Future<List<MovieModel>> findMovies(String query) async {
    final urlSearch =
        'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&language=pt-BR&page=1&include_adult=false&query=$query';

    var json = await getData(urlSearch);
    var response = jsonDecode(json);
    var movieList = response['results'];

    List<MovieModel> movies =
        movieList.map<MovieModel>((json) => MovieModel.fromJson(json)).toList();

    return movies;
  }
}
