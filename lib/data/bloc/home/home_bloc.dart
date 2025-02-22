import 'package:aplle_shop_pj/data/bloc/home/home_event.dart';
import 'package:aplle_shop_pj/data/bloc/home/home_state.dart';
import 'package:aplle_shop_pj/data/datasourse/repository/banner_repository.dart';
import 'package:aplle_shop_pj/data/datasourse/repository/categorys_repository.dart';
import 'package:aplle_shop_pj/data/datasourse/repository/products_repository.dart';
import 'package:aplle_shop_pj/di/di.dart';
import 'package:bloc/bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitState()) {
    final IBannerRepository bannerRepository = locator.get();
    final ICategorysRepository categorysRepository = locator.get();
    final IProductsRepository productsRepository = locator.get();
    on<HomeGetInitializeData>(
      (event, emit) async {
        emit(HomeLoadingState());
        // await Future.delayed(const Duration(seconds: 2));
        try {
          var bannerList = await bannerRepository.getBanner().timeout(
              const Duration(seconds: 5),
              onTimeout: () =>
                  throw Exception('مدت زمان درخواست به پایان رسید'));

          var categoryList = await categorysRepository.getCategory().timeout(
              const Duration(seconds: 5),
              onTimeout: () =>
                  throw Exception('مدت زمان درخواست به پایان رسید'));

          var productsList = await productsRepository.getProducts().timeout(
              const Duration(seconds: 5),
              onTimeout: () =>
                  throw Exception('مدت زمان درخواست به پایان رسید'));

          var bestsellerProductList = await productsRepository
              .getBestSellerProducts()
              .timeout(const Duration(seconds: 5),
                  onTimeout: () =>
                      throw Exception('مدت زمان درخواست به پایان رسید'));

          var hotestProductList = await productsRepository
              .getHotestProducts()
              .timeout(const Duration(seconds: 5),
                  onTimeout: () =>
                      throw Exception('مدت زمان درخواست به پایان رسید'));
          emit(HomeResponseState(
            bannerList,
            categoryList,
            productsList,
            hotestProductList,
            bestsellerProductList,
          ));
        } catch (errorMessage) {
          print('catch error teue');
          emit(HomeErrorState('خطا در برقراری ارتباط +'));
        }
      },
    );
  }
}
