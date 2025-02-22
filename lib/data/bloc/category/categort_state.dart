import 'package:aplle_shop_pj/data/model/category.dart';
import 'package:dartz/dartz.dart';

abstract class CategortState {}

class CategoryInitState extends CategortState {}

class CategoryResponseState extends CategortState {
  Either<String, List<Categorys>> response;
  CategoryResponseState(this.response);
}

class CategoryLoadingState extends CategortState {}
