import 'package:aplle_shop_pj/data/datasourse/datasource/product_details_datasours.dart';
import 'package:aplle_shop_pj/data/model/category.dart';
import 'package:aplle_shop_pj/data/model/product_image.dart';
import 'package:aplle_shop_pj/data/model/product_perperty.dart';
import 'package:aplle_shop_pj/data/model/product_variant.dart';
import 'package:aplle_shop_pj/data/model/variants_model.dart';
import 'package:aplle_shop_pj/di/di.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class IDetailProductRepository {
  Future<Either<String, List<ProductImage>>> getProductImage(String productId);
  Future<Either<String, List<VariantType>>> getVariantType();
  Future<Either<String, List<ProductVariant>>> getProductVariants(
      String productId);
  Future<Either<String, Categorys>> getProductCategory(String categoryId);
  Future<Either<String, List<ProductPerperties>>> getProductProperties(
      String productId);
}

class DetailProductRepository extends IDetailProductRepository {
  final IDetailProductDataSource datasource = locator.get();
  @override
  Future<Either<String, List<ProductImage>>> getProductImage(
      String productId) async {
    try {
      var response = await datasource.getGallery(productId);
      return right(response);
    } on DioException catch (e) {
      return Left(e.message ?? 'null error');
    }
  }

  @override
  Future<Either<String, List<VariantType>>> getVariantType() async {
    try {
      var response = await datasource.getVariantType();
      return right(response);
    } on DioException catch (e) {
      return Left(e.message ?? 'null error');
    }
  }

  @override
  Future<Either<String, List<ProductVariant>>> getProductVariants(
      String productId) async {
    try {
      var response = await datasource.getProductVariants(productId);
      return right(response);
    } on DioException catch (e) {
      return Left(e.message ?? 'null error');
    }
  }

  @override
  Future<Either<String, Categorys>> getProductCategory(
      String categoryId) async {
    try {
      var response = await datasource.getProductCategory(categoryId);
      return right(response);
    } on DioException catch (e) {
      return Left(e.message ?? 'null error');
    }
  }

  @override
  Future<Either<String, List<ProductPerperties>>> getProductProperties(
      String productId) async {
    try {
      var response = await datasource.getProductPropertis(productId);
      return right(response);
    } on DioException catch (e) {
      return Left(e.message ?? 'null error');
    }
  }
}
