import 'package:aplle_shop_pj/util/api_exception.dart';
import 'package:aplle_shop_pj/util/auth_manager.dart';
import 'package:aplle_shop_pj/util/dio_provider.dart';
import 'package:dio/dio.dart';

abstract class IAuthenticationDataSource {
  Future<void> register(
      String username, String password, String passwordConfirm);
  Future<String> login(String username, String password);
}

class AuthenticationRemote implements IAuthenticationDataSource {
  final Dio dio = DioProvider.DioWithoutHeaders();

  @override
  Future<void> register(
      String username, String password, String passwordConfirm) async {
    try {
      var response = await dio.post('collections/users/records',
          options: Options(
            followRedirects: false,
            // validateStatus: (s) => s! < 500,
            //  method: 'POST',
            headers: {
              // 'username': 'yasin',
              // 'password': '12345678',
              // 'passwordConfirm': '12345678',
              'Content-Type': 'application/json',
              // 'Accept-Encoding': 'gzip, deflate, br',
              // 'Connection': 'keep-alive'
            },
          ),
          data: {
            'username': username,
            'password': password,
            'passwordConfirm': passwordConfirm,
            'name': username
          });
      if (response.statusCode == 200) {
        login(username, password);
      }
      //   print('${response.statusCode}');
    } on DioException catch (e) {
      // print(e.response?.statusCode);
      // print(e.response?.data['message']);

      throw ApiException(
        e.response?.statusCode,
        e.response?.data['message'],
        response: e.response,
      );
    }
  }

  @override
  Future<String> login(String username, String password) async {
    try {
      var response = await dio.post('collections/users/auth-with-password',
          data: {'identity': username, 'password': password});
      await AuthManager.saveId(response.data?['record']['id']);
      await AuthManager.saveToken(response.data?['token']);
      return response.data?['token'];
    } on DioException catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    }
  }
}
