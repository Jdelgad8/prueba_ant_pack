import 'package:dio/dio.dart';
import 'package:prueba_ant_pack/constants/global_constants.dart';
import 'package:prueba_ant_pack/models/models.dart';

class UserProvider {
  final String url = GlobalConstant.URL_API;
  final String getUsersRoute = 'users';

  Dio dio = Dio();
  Future<List<UserModel>> getUsers() async {
    try {
      // print('url: $url/$getUsersRoute');
      Response response = await dio.get('$url$getUsersRoute');
      // print('UserModel response: $response');
      // Get response from Json and convert it to a List of UserModel
      if (response.data != null) {
        return (response.data as List)
            .map((x) => UserModel.fromJson(x))
            .toList();
      } else {
        return new List.empty();
      }
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
        return new List.empty();
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
        return new List.empty();
      }
    }
  }
}
