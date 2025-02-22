import 'package:aplle_shop_pj/data/datasourse/authentication_datasourse.dart';
import 'package:aplle_shop_pj/di/di.dart';
import 'package:aplle_shop_pj/util/api_exception.dart';
import 'package:aplle_shop_pj/util/auth_manager.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IAuthRepasitory {
  Future<Either<String, String>> register(
      String username, String password, String passwordConfirm);
  Future<Either<String, String>> login(String username, String password);
}

class AuthenticationRepasitory extends IAuthRepasitory {
  final IAuthenticationDataSource datasource = locator.get();
  final SharedPreferences sharedPreferences = locator.get();

  @override
  Future<Either<String, String>> register(
      String username, String password, String passwordConfirm) async {
    try {
      await datasource.register(username, password, passwordConfirm);
      return right('ثبت نام با موفقیت انجام شد');
    } on ApiException catch (e) {
      return left(e.message ?? 'null error');
    }
  }

  @override
  Future<Either<String, String>> login(String username, String password) async {
    try {
      String token = await datasource.login(username, password);
      if (token.isNotEmpty) {
        AuthManager.saveToken(token);
        print(token);
        return right('با موفقیت وارد شدید');
      } else {
        return left('خطا در ورود');
      }
    } on ApiException catch (e) {
      return left(e.message ?? 'null error');
    }
  }
}
