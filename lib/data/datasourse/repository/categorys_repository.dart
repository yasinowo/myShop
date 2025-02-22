import 'package:aplle_shop_pj/data/datasourse/category_datasource.dart';
import 'package:aplle_shop_pj/data/model/category.dart';
import 'package:aplle_shop_pj/di/di.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class ICategorysRepository {
  Future<Either<String, List<Categorys>>> getCategory();
}

class CategorysRepository extends ICategorysRepository {
  final ICategoryDatasource datasource = locator.get();
  @override
  Future<Either<String, List<Categorys>>> getCategory() async {
    try {
      var response = await datasource.getCategory();
      return right(response);
    } on DioException catch (e) {
      return Left(e.message ?? 'null error');
    }
  }
}
