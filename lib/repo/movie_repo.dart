import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:movies_app/constants/app_constants.dart';
import 'package:movies_app/models/genre_model.dart';

import '../models/movie_data_model.dart';

class MovieRepository {
  Future<List<MoiveData>> getUpcomingMovies() async {
    try {
      var headers = {'Authorization': 'Bearer ${AppConst.token}'};
      var dio = Dio();
      var response = await dio.request(
        '${AppConst.baseUrl}/upcoming?api_key=${AppConst.apiKey}',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        // print(json.encode(response.data));
        MovieDataModel model = MovieDataModel.fromJson(response.data);
        return model.results;
      } else {
        print(response.statusMessage);
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<String> fetchGenrePoster(int genreId) async {
    final dio = Dio();

    // Discover movies for the given genre.
    final discoverUrl =
        'https://api.themoviedb.org/3/discover/movie?api_key=${AppConst.apiKey}&with_genres=$genreId&sort_by=popularity.desc';
    var headers = {'Authorization': 'Bearer ${AppConst.token}'};

    final discoverResponse = await dio.request(discoverUrl,
        options: Options(method: 'GET', headers: headers));
    if (discoverResponse.statusCode != 200) {
      throw Exception("Failed to load movies for genre");
    }
    final discoverData = discoverResponse.data;
    if ((discoverData['results'] as List).isEmpty) {
      throw Exception("No movies found for this genre");
    }
    final posterPath = discoverData['results'][0]['poster_path'];

    final configUrl =
        'https://api.themoviedb.org/3/configuration?api_key=${AppConst.apiKey}';
    final configResponse = await dio.request(configUrl,
        options: Options(method: 'GET', headers: headers));
    if (configResponse.statusCode != 200) {
      throw Exception("Failed to load configuration");
    }
    final configData = configResponse.data;
    final baseUrl = configData['images']['secure_base_url'];
    final List<dynamic> posterSizes = configData['images']['poster_sizes'];
    final selectedSize = posterSizes.contains("w342") ? "w342" : posterSizes[0];

    return "$baseUrl$selectedSize$posterPath";
  }

  Future<List<GenreModel>> fetchGenre() async {
    List<GenreModel> genres = [];
    var headers = {'Authorization': 'Bearer ${AppConst.token}'};
    var dio = Dio();
    var response = await dio.request(
      'https://api.themoviedb.org/3/genre/movie/list?api_key=${AppConst.apiKey}',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      for (var item in response.data['genres']) {
        String image = await fetchGenrePoster(item['id']);
        GenreModel model = GenreModel(name: item['name'], image: image);
        genres.add(model);
      }
    } else {
      print(response.statusMessage);
    }
    return genres;
  }
}
