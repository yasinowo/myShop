import 'package:aplle_shop_pj/data/model/banner.dart';
import 'package:aplle_shop_pj/data/model/category.dart';
import 'package:aplle_shop_pj/data/model/products.dart';
import 'package:dartz/dartz.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeResponseState extends HomeState {
  Either<String, List<Banner>> bannerList;
  Either<String, List<Categorys>> categorListy;
  Either<String, List<Products>> productsList;
  Either<String, List<Products>> bestSellertList;
  Either<String, List<Products>> HotestList;
  HomeResponseState(
    this.bannerList,
    this.categorListy,
    this.productsList,
    this.HotestList,
    this.bestSellertList,
  );
}

class HomeErrorState extends HomeState {
  final String errorMessage;

  HomeErrorState(this.errorMessage);
}
