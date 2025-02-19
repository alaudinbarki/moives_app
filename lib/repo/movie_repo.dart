import 'package:dio/dio.dart';
import 'package:movies_app/constants/app_constants.dart';

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
}
