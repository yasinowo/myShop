import 'package:aplle_shop_pj/data/datasourse/banner_datasource.dart';
import 'package:aplle_shop_pj/data/model/banner.dart';
import 'package:aplle_shop_pj/di/di.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class IBannerRepository {
  Future<Either<String, List<Banner>>> getBanner();
}

class BannerRepository extends IBannerRepository {
  final IBannerDatasource datasource = locator.get();
  @override
  Future<Either<String, List<Banner>>> getBanner() async {
    try {
      var response = await datasource.getBanner();
      return right(response);
    } on DioException catch (e) {
      return Left(e.message ?? 'null error');
    }
  }
}
