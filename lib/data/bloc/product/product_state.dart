import 'package:aplle_shop_pj/data/model/category.dart';
import 'package:aplle_shop_pj/data/model/product_image.dart';
import 'package:aplle_shop_pj/data/model/product_perperty.dart';
import 'package:aplle_shop_pj/data/model/product_variant.dart';
import 'package:dartz/dartz.dart';

abstract class ProductState {}

class ProductInitState extends ProductState {}

class ProductDetailLoadingState extends ProductState {}

class ProductDetailResponseState extends ProductState {
  Either<String, List<ProductImage>> getProductImage;
  Either<String, List<ProductVariant>> productVariant;
  Either<String, Categorys> productCategory;
  Either<String, List<ProductPerperties>> productProperties;

  ProductDetailResponseState(this.getProductImage, this.productVariant,
      this.productCategory, this.productProperties);
}
