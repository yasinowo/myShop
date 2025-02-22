import 'package:aplle_shop_pj/constants/color.dart';
import 'package:aplle_shop_pj/data/bloc/category_product.dart/category_bloc.dart';
import 'package:aplle_shop_pj/data/bloc/home/home_bloc.dart';
import 'package:aplle_shop_pj/data/bloc/home/home_event.dart';
import 'package:aplle_shop_pj/data/bloc/home/home_state.dart';
import 'package:aplle_shop_pj/data/model/category.dart';
import 'package:aplle_shop_pj/data/model/products.dart';
import 'package:aplle_shop_pj/screens/error_page/connection_error_screen.dart';
import 'package:aplle_shop_pj/screens/product_list_screen.dart';
import 'package:aplle_shop_pj/util/extentions.dart';
import 'package:aplle_shop_pj/util/loading_animation.dart';
import 'package:aplle_shop_pj/widgets/banner_slider.dart';
import 'package:aplle_shop_pj/widgets/cached_image.dart';
import 'package:aplle_shop_pj/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: library_prefixes
import 'package:aplle_shop_pj/data/model/banner.dart' as myBanner;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundScreen,
      body: SafeArea(child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return getHomeScreenContent(state);
        },
      )),
    );
  }

  Widget getHomeScreenContent(HomeState state) {
    if (state is HomeLoadingState) {
      print('loading state on');
      return const Center(
        child: LoadingAnimation(),
      );
    } else if (state is HomeResponseState) {
      return RefreshIndicator(
        onRefresh: () async {
          context.read<HomeBloc>().add(HomeGetInitializeData());
        },
        child: CustomScrollView(
          slivers: <Widget>[
            getSearchBox(),
            state.bannerList.fold(
              (exceptionMessage) {
                return SliverToBoxAdapter(
                  child: Text(exceptionMessage),
                );
              },
              (r) {
                return getBanner(r);
              },
            ),
            SliverToBoxAdapter(
                child: SizedBox(
              height: 10.h,
            )),
            getCategoryListTitle(),
            state.categorListy.fold((exceptionMessage) {
              return SliverToBoxAdapter(child: Text(exceptionMessage));
            }, (categoryList) {
              return getCategoryList(categoryList);
            }),
            SliverToBoxAdapter(
                child: SizedBox(
              height: 10.h,
            )),
            getBestSellerTitle(),
            state.bestSellertList.fold((exceptionMessage) {
              return SliverToBoxAdapter(child: Text(exceptionMessage));
            }, (bestSellertList) {
              return getBestSellerProduct(bestSellertList);
            }),
            SliverToBoxAdapter(
                child: SizedBox(
              height: 15.h,
            )),
            getMostViewTitle(),
            state.HotestList.fold(
              (exceptionMessage) {
                return SliverToBoxAdapter(child: Text(exceptionMessage));
              },
              (productsList) {
                return getMostViewProduct(productsList);
              },
            ),
          ],
        ),
      );
    } else if (state is HomeErrorState) {
      print('home state error');
      return const NoConnectionPage();
      // return Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Text(state.errorMessage),
      //       ElevatedButton(
      //         onPressed: () {
      //           context.read<HomeBloc>().add(HomeGetInitializeData());
      //         },
      //         child: const Text('تلاش دوباره'),
      //       ),
      //     ],
      //   ),
      // );
    } else {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('خطای نامشخص'),
            Text('اتصال اینترنت را چک کنید'),
          ],
        ),
      );
    }
  }

  getBanner(List<myBanner.Banner> banner) {
    return SliverToBoxAdapter(
      child: BannerSlider(
        bannerList: banner,
      ),
    );
  }

  SliverToBoxAdapter getMostViewProduct(List<Products> productsList) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 160.h,
        child: ListView.builder(
          itemCount: productsList.length,
          padding: EdgeInsets.only(right: 20.w),
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(left: 15.w),
              child: productItem(productsList[index], context),
              //,
            );
          },
        ),
      ),
    );
  }

  SliverToBoxAdapter getMostViewTitle() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(right: 20.w, left: 10.w, bottom: 5.h),
        child: Row(
          children: [
            const Text(
              'پربازدید ترین ها',
              style: TextStyle(
                  color: CustomColor.grey, fontFamily: 'sb', fontSize: 14),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 2.w),
              child: const Text(
                'مشاهده همه',
                style: TextStyle(
                    color: CustomColor.blue, fontFamily: 'sb', fontSize: 14),
              ),
            ),
            SizedBox(
              height: 15.h,
              child: Image.asset('assets/images/icon_left_categroy.png'),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter getBestSellerProduct(List<Products> productsList) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 160.h,
        child: ListView.builder(
          itemCount: productsList.length,
          padding: EdgeInsets.only(right: 20.w),
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(left: 15.w),
              child: productItem(productsList[index], context),
            );
          },
        ),
      ),
    );
  }

  SliverToBoxAdapter getBestSellerTitle() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(right: 20.w, left: 10.w, bottom: 5.h),
        child: Row(
          children: [
            const Text(
              'پرفروش ترین ها',
              style: TextStyle(
                  color: CustomColor.grey, fontFamily: 'sb', fontSize: 14),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: const Text(
                'مشاهده همه',
                style: TextStyle(
                    color: CustomColor.blue, fontFamily: 'sb', fontSize: 14),
              ),
            ),
            SizedBox(
              height: 15.h,
              child: Image.asset('assets/images/icon_left_categroy.png'),
            ),
          ],
        ),
      ),
    );
  }

  getCategoryList(List<Categorys> categoryList) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(right: 20.w),
        child: SizedBox(
          height: 60.h,
          child: Center(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: categoryList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(left: 13.5.w), // فاصله بین آیتم‌ها
                  child: horizontalyList(categoryList[index]),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter getCategoryListTitle() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(right: 20.w),
        child: const Text(
          'دسته بندی',
          textAlign: TextAlign.start,
          style: TextStyle(
              color: CustomColor.grey, fontFamily: 'sb', fontSize: 13),
        ),
      ),
    );
  }

  SliverToBoxAdapter getSearchBox() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
        child: Container(
          width: 300.w,
          height: 40.h,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              children: [
                Image.asset('assets/images/icon_search.png'),
                SizedBox(width: 5.w),
                const Expanded(
                  child: Text('جستجوی محصولات',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: CustomColor.grey,
                          fontFamily: 'sb',
                          fontSize: 16)),
                ),
                Image.asset('assets/images/icon_apple_blue.png'),
              ],
            ),
          ),
        ),
      ),
    );
  }

// Padding(
//categoryItemChip =
  horizontalyList(Categorys category) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => CategoryProductBloc(),
                child: ProductListScreen(
                  category: category,
                ),
              ),
            ));
      },
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 45.w,
                height: 42.h,
                decoration: ShapeDecoration(
                  color: category.color.parseColorM(),
                  shadows: [
                    BoxShadow(
                        color: category.color.parseColorM(),
                        blurRadius: 25,
                        offset: const Offset(0, 15),
                        spreadRadius: -15)
                  ],
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                ),
              ),
              SizedBox(
                width: 27.w,
                height: 27.h,
                child: Center(
                  child: CachedImage(
                    radios: 0,
                    urlImage: category.icon,
                    fontSize: 10,
                    height: 30.h,
                    width: 30.w,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          Text(
            category.title ?? 'محصول',
            style: const TextStyle(fontFamily: 'SB', fontSize: 12),
          ),
        ],
      ),
    );
  }
}
