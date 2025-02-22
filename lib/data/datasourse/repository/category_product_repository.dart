import 'package:aplle_shop_pj/data/datasourse/datasource/category_product_datasource.dart';
import 'package:aplle_shop_pj/data/model/products.dart';
import 'package:aplle_shop_pj/di/di.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class ICategoryProductRepository {
  Future<Either<String, List<Products>>> getProductByCategoryId(
      String categoryId);
}

class CategoryProductRepository extends ICategoryProductRepository {
  @override
  Future<Either<String, List<Products>>> getProductByCategoryId(
      String categoryId) async {
    final ICategoryProductDatasource datasource = locator.get();
    try {
      var response = await datasource.getProductCategoryById(categoryId);
      return right(response);
    } on DioException catch (e) {
      return Left(e.message ?? 'null error');
    }
  }
}
