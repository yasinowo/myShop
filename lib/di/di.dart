import 'package:aplle_shop_pj/data/bloc/carItem.dart/cardItem_bloc.dart';
import 'package:aplle_shop_pj/data/datasourse/authentication_datasourse.dart';
import 'package:aplle_shop_pj/data/datasourse/banner_datasource.dart';
import 'package:aplle_shop_pj/data/datasourse/category_datasource.dart';
import 'package:aplle_shop_pj/data/datasourse/datasource/caritem_datasource.dart';
import 'package:aplle_shop_pj/data/datasourse/datasource/category_product_datasource.dart';
import 'package:aplle_shop_pj/data/datasourse/datasource/comment_datasource.dart';
import 'package:aplle_shop_pj/data/datasourse/datasource/product_details_datasours.dart';
import 'package:aplle_shop_pj/data/datasourse/repository/authentication_repasitory.dart';
import 'package:aplle_shop_pj/data/datasourse/repository/banner_repository.dart';
import 'package:aplle_shop_pj/data/datasourse/repository/carditem_repository.dart';
import 'package:aplle_shop_pj/data/datasourse/repository/category_product_repository.dart';
import 'package:aplle_shop_pj/data/datasourse/repository/categorys_repository.dart';
import 'package:aplle_shop_pj/data/datasourse/datasource/products_datasource.dart';
import 'package:aplle_shop_pj/data/datasourse/repository/comment_repository.dart';
import 'package:aplle_shop_pj/data/datasourse/repository/product_detail_repository.dart';
import 'package:aplle_shop_pj/data/datasourse/repository/products_repository.dart';
import 'package:aplle_shop_pj/util/dio_provider.dart';
import 'package:aplle_shop_pj/util/paymnet/paymebt_handler.dart';
import 'package:aplle_shop_pj/util/url_handler.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

var locator = GetIt.instance;

Future<void> getItInit() async {
//util and components
  await initComponents();

  //datasource
  initDatasource();
  //Repositoies
  initRepository();

  //bloc
//**** true constractor indection*/
  // locator.registerSingleton<PaymentHandler>(
  //     ZarinpalPayment(locator.get(), locator.get()));
  locator.registerSingleton<PaymentHandler>(
      ZarinpalPayment(locator.get(), locator.get()));

  locator.registerSingleton<CardItemBloc>(
      CardItemBloc(locator.get(), locator.get()));
}

initDatasource() {
  locator
      .registerFactory<IAuthenticationDataSource>(() => AuthenticationRemote());
  locator.registerFactory<IBannerDatasource>(() => BannerRemotDatasource());

  locator
      .registerFactory<ICategoryDatasource>(() => CategoryRemoteDataSource());
  locator.registerFactory<IProductsDatasource>(() => ProductsRemotDatasource());
  locator.registerFactory<IDetailProductDataSource>(
      () => DetailsProductRemotDataSource());
  locator.registerFactory<ICategoryProductDatasource>(
      () => CategoryProductRemoteDatasource());
  locator.registerFactory<ICardItemDatasource>(() => CarditemRemotDatasource());
  locator.registerFactory<ICommentDataSource>(
    () => CommentRemoteDataSource(),
  );
}

initRepository() {
  locator.registerFactory<IAuthRepasitory>(() => AuthenticationRepasitory());
  locator.registerFactory<ICategorysRepository>(() => CategorysRepository());
  locator.registerFactory<IBannerRepository>(() => BannerRepository());
  locator.registerFactory<IProductsRepository>(() => ProductsRepository());
  locator.registerFactory<IDetailProductRepository>(
      () => DetailProductRepository());
  locator.registerFactory<ICategoryProductRepository>(
      () => CategoryProductRepository());
  locator.registerFactory<ICardItemRepository>(() => CarditemRepository());
  // locator.registerSingleton<ICardItemRepository>(CarditemRepository());

  locator.registerFactory<ICommentRepository>(
    () => CommentRepository(),
  );
}

Future<void> initComponents() async {
  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
  locator.registerSingleton<Dio>(DioProvider.crateDio());

  locator.registerSingleton<UrlHandler>(UrlLuncher());
}
