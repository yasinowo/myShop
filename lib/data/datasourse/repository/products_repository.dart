import 'package:aplle_shop_pj/data/datasourse/datasource/products_datasource.dart';
import 'package:aplle_shop_pj/data/model/products.dart';
import 'package:aplle_shop_pj/di/di.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class IProductsRepository {
  Future<Either<String, List<Products>>> getProducts();
  Future<Either<String, List<Products>>> getHotestProducts();
  Future<Either<String, List<Products>>> getBestSellerProducts();
}

class ProductsRepository extends IProductsRepository {
  final IProductsDatasource datasource = locator.get();
  @override
  Future<Either<String, List<Products>>> getProducts() async {
    try {
      var response = await datasource.getProducts();
      return right(response);
    } on DioException catch (e) {
      return Left(e.message ?? 'null error');
    } catch (e) {
      return const Left('xxxاتصال به سرور برقرار نشد'); // خطای شبکه
    }
  }

  @override
  Future<Either<String, List<Products>>> getBestSellerProducts() async {
    try {
      var response = await datasource.getBestSellerProducts();
      return right(response);
    } on DioException catch (e) {
      return Left(e.message ?? 'null error');
    } catch (e) {
      return const Left('اتصال به سرور برقرار نشد'); // خطای شبکه
    }
  }

  @override
  Future<Either<String, List<Products>>> getHotestProducts() async {
    try {
      var response = await datasource.getHotestProducts();
      return right(response);
    } on DioException catch (e) {
      return Left(e.message ?? 'null error');
    } catch (e) {
      return const Left('اتصال به سرور برقرار نشد'); // خطای شبکه
    }
  }
}
