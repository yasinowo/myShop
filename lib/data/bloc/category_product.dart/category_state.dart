import 'package:aplle_shop_pj/data/model/products.dart';
import 'package:dartz/dartz.dart';

abstract class CategoryProductState {}

class CategoryProductLoadingState extends CategoryProductState {}

class CategoryProductResponseState extends CategoryProductState {
  Either<String, List<Products>> productListByCategory;
  CategoryProductResponseState(this.productListByCategory);
}
