import 'package:aplle_shop_pj/constants/color.dart';
import 'package:aplle_shop_pj/data/bloc/carItem.dart/cardItem_bloc.dart';
import 'package:aplle_shop_pj/data/bloc/product/product_bloc.dart';
import 'package:aplle_shop_pj/data/bloc/product/product_event.dart';
import 'package:aplle_shop_pj/data/model/products.dart';
import 'package:aplle_shop_pj/di/di.dart';
import 'package:aplle_shop_pj/screens/product_details_screen.dart';
import 'package:aplle_shop_pj/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aplle_shop_pj/util/extentions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

productItem(Products products, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BlocProvider<CardItemBloc>.value(
                value: locator.get<CardItemBloc>(),
                child: BlocProvider(
                  create: (context) {
                    var bloc = ProductBloc();
                    bloc.add(ProductInitializedEvent(
                        products.id, products.categoryId));
                    return bloc;
                  },
                  child: ProductDetailsScreen(
                    product: products,
                  ),
                ),
              )));
    },
    child: Container(
      width: 150.w,
      height: 200.h,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        children: [
          SizedBox(
            height: 15.h,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(),
              SizedBox(
                //applewach flow image
                height: 77.h,
                width: 85.w,
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: CachedImage(
                    urlImage: products.thumbnail,
                    fontSize: 3,
                  ),
                ),
              ),
              Positioned(
                top: 0.h,
                right: 0.w,
                child: SizedBox(
                    width: 24.w,
                    child: Image.asset('assets/images/active_fav_product.png')),
              ),
              Positioned(
                top: 65.w,
                left: 8.h,
                child: SizedBox(
                    width: 24.w,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '${products.persent!.round()}%',
                          style: const TextStyle(
                              fontFamily: 'sm',
                              fontSize: 12,
                              color: Colors.white),
                        ),
                      ),
                    )),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 5.w),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    maxLines: 1,
                    products.name,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontFamily: 'SM',
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Container(
                height: 40.h,
                width: 140.w,
                decoration: const BoxDecoration(
                  color: CustomColor.blue,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 25,
                        offset: Offset(0, 16),
                        spreadRadius: -18,
                        color: CustomColor.blue)
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Text(
                        'تومان',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'sm',
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            products.price.toString().toPriceWithCommas(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'sm',
                                fontSize: 14,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.red,
                                //     decorationStyle: TextDecorationStyle.double,
                                decorationThickness: 4),
                          ),
                          Text(
                            products.realPrice.toString().toPriceWithCommas(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'sm',
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 18.w,
                        child: Image.asset(
                          'assets/images/icon_right_arrow_cricle.png',
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
