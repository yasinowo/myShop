import 'package:aplle_shop_pj/util/auth_manager.dart';
import 'package:dio/dio.dart';

class DioProvider {
  static Dio crateDio() {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: 'https://startflutter.ir/api/',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AuthManager.readAuth()}'
        },
      ),
    );
    return dio;
  }

  // ignore: non_constant_identifier_names
  static Dio DioWithoutHeaders() {
    Dio dio = Dio(BaseOptions(baseUrl: 'https://startflutter.ir/api/'));
    return dio;
  }
}
