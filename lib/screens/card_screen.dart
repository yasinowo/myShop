import 'package:aplle_shop_pj/constants/color.dart';
import 'package:aplle_shop_pj/data/bloc/carItem.dart/cardItem_bloc.dart';
import 'package:aplle_shop_pj/data/bloc/carItem.dart/cardItem_event.dart';
import 'package:aplle_shop_pj/data/bloc/carItem.dart/cardItem_state.dart';
import 'package:aplle_shop_pj/data/bloc/product/product_bloc.dart';
import 'package:aplle_shop_pj/data/bloc/product/product_event.dart';
import 'package:aplle_shop_pj/data/model/card_item.dart';
import 'package:aplle_shop_pj/data/model/products.dart';
import 'package:aplle_shop_pj/di/di.dart';
import 'package:aplle_shop_pj/screens/product_details_screen.dart';
import 'package:aplle_shop_pj/util/extentions.dart';
import 'package:aplle_shop_pj/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({
    super.key,
  });

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColor.backgroundScreen,
        body: SafeArea(
          child: BlocConsumer<CardItemBloc, CarditemState>(
            listener: (context, state) {
              if (state is CardItemSuccessPaymentState) {
                var snackBar = const SnackBar(
                  content: Text(
                    'خرید با موفقیت انجام شد',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'dana', fontSize: 14),
                  ),
                  duration: Duration(seconds: 3),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.black,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else if (state is CardItemFaildPaymentState) {
                var snackBar = const SnackBar(
                  content: Text(
                    'خرید ناموفق بود',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'dana', fontSize: 14),
                  ),
                  duration: Duration(seconds: 3),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.black,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            builder: (context, state) {
              return Stack(
                children: [
                  CustomScrollView(
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40.w, vertical: 20.h),
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
                                  Image.asset(
                                      'assets/images/icon_apple_blue.png'),
                                  const Expanded(
                                    child: Text('سبد خرید',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: CustomColor.blue,
                                            fontFamily: 'sb',
                                            fontSize: 20)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (state is CardItemfetchedState) ...{
                        state.cardItem.fold(
                          (l) {
                            return SliverToBoxAdapter(
                              child: Text(l),
                            );
                          },
                          (cardItemList) {
                            return SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 20.h),
                                    child: cardItem(cardItemList[index], index),
                                  );
                                },
                                childCount: cardItemList.length,
                              ),
                            );
                          },
                        )
                      } else if (state is CardItemFaildPaymentState) ...{
                        state.cardItem.fold(
                          (l) {
                            return SliverToBoxAdapter(
                              child: Text(l),
                            );
                          },
                          (cardItemList) {
                            return SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 20.h),
                                    child: cardItem(cardItemList[index], index),
                                  );
                                },
                                childCount: cardItemList.length,
                              ),
                            );
                          },
                        )
                      },
                      SliverPadding(padding: EdgeInsets.only(bottom: 70.h))
                    ],
                  ),
                  if (state is CardItemfetchedState) ...{
                    Positioned(
                        bottom: 15.h,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 50.h,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  backgroundColor: CustomColor.green,
                                  foregroundColor: Colors.white),
                              onPressed: () {
                                context.read<CardItemBloc>().add(
                                    CarItemInitPaymentEvent(
                                        state.cardItemFinalPrice));
                                context
                                    .read<CardItemBloc>()
                                    .add(CarItemPaymentRequestEvent());
                              },
                              child: Text(
                                  (state.cardItemFinalPrice == 0)
                                      ? 'xسبد خرید شما خالی است'
                                      : 'پرداخت مبلغ : ${state.cardItemFinalPrice.toString().toPriceWithCommas()} تومان',
                                  style: const TextStyle(
                                      fontFamily: 'sm',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ))
                  } else if (state is CardItemSuccessPaymentState) ...{
                    Positioned(
                        bottom: 15.h,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 50.h,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  backgroundColor: CustomColor.green,
                                  foregroundColor: Colors.white),
                              onPressed: () {
                                var snackBar = const SnackBar(
                                  content: Text(
                                    'سبد خرید خالی است',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontFamily: 'dana', fontSize: 14),
                                  ),
                                  duration: Duration(seconds: 2),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.black,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                              child: const Text('سبد خرید شما خالی است',
                                  style: TextStyle(
                                      fontFamily: 'sm',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ))
                  } else if (state is CardItemFaildPaymentState) ...{
                    Positioned(
                        bottom: 15.h,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 50.h,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  backgroundColor: CustomColor.green,
                                  foregroundColor: Colors.white),
                              onPressed: () {
                                context.read<CardItemBloc>().add(
                                    CarItemInitPaymentEvent(
                                        state.cardItemFinalPrice));
                                context
                                    .read<CardItemBloc>()
                                    .add(CarItemPaymentRequestEvent());
                              },
                              child: Text(
                                  (state.cardItemFinalPrice == 0)
                                      ? 'xسبد خرید شما خالی است'
                                      : 'پرداخت مبلغ : ${state.cardItemFinalPrice.toString().toPriceWithCommas()} تومان',
                                  style: const TextStyle(
                                      fontFamily: 'sm',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ))
                  }
                ],
              );
            },
          ),
        ));
  }

  cardItem(CardItem cardItem, int index) {
    return GestureDetector(
      onTap: () {
        Products products = Products(
            cardItem.id,
            cardItem.collectionId,
            cardItem.thumbnail,
            'description',
            cardItem.discountPrice,
            cardItem.price,
            'popularity',
            cardItem.name,
            10,
            cardItem.categoryId);

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => BlocProvider<CardItemBloc>.value(
                  value: locator.get<CardItemBloc>(),
                  child: BlocProvider(
                    create: (context) {
                      var bloc = ProductBloc();
                      bloc.add(ProductInitializedEvent(
                          cardItem.id, cardItem.categoryId));
                      return bloc;
                    },
                    child: ProductDetailsScreen(
                      product: products,
                    ),
                  ),
                )));
      },
      child: Container(
        height: 200.h,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        margin: EdgeInsets.symmetric(horizontal: 30.w),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
          //mainRow
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          cardItem.name,
                          style:
                              const TextStyle(fontFamily: 'sb', fontSize: 18),
                        ),
                        const Text('گارانتی 18 ماه مدیا پردازش',
                            style: TextStyle(
                                fontFamily: 'sm',
                                fontSize: 12,
                                color: CustomColor.grey)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                                width: 25.w,
                                height: 12.h,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      '%12',
                                      style: TextStyle(
                                          fontFamily: 'sm',
                                          fontSize: 12,
                                          color: Colors.white),
                                    ),
                                  ),
                                )),
                            const Text('  تومان',
                                style: TextStyle(
                                  fontFamily: 'sb',
                                  fontSize: 12,
                                )),
                            const Text(' 80,000,000',
                                style: TextStyle(
                                  fontFamily: 'sm',
                                  fontSize: 14,
                                )),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Padding(
                            padding: EdgeInsets.only(right: 5.w),
                            child: Wrap(children: [
                              GestureDetector(
                                onTap: () {
                                  context
                                      .read<CardItemBloc>()
                                      .add(CardItemRemoveEvent(index));
                                  var snackBar = const SnackBar(
                                    content: Text(
                                      'حذف شد',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontFamily: 'dana', fontSize: 14),
                                    ),
                                    duration: Duration(seconds: 2),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.black,
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 10.w),
                                  width: 60.w,
                                  height: 20.h,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: CustomColor.grey),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      color: Colors.white),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text('حذف',
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                              fontFamily: 'sm',
                                              fontSize: 14,
                                              color: CustomColor.red,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                          height: 20.h,
                                          width: 20.w,
                                          child: Image.asset(
                                              'assets/images/icon_trash.png'))
                                    ],
                                  ),
                                ),
                              ),
                              chip('8024a7', 'آبی')
                            ])),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 10.w),
                    child: SizedBox(
                      height: 100.h,
                      width: 80.w,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: CachedImage(
                          urlImage: cardItem.thumbnail,
                          radios: 10,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 5.h),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    const Text('-------------------------',
                        style: TextStyle(
                            fontFamily: 'sb',
                            fontSize: 30,
                            color: Color.fromARGB(255, 207, 204, 204))),
                    Text(
                        '${cardItem.realPrice.toString().toPriceWithCommas()} تومان',
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(fontFamily: 'sb', fontSize: 18))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container chip(String? color, String title) {
    return Container(
      width: 60.w,
      height: 20.h,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: CustomColor.grey),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Colors.white),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (color != null) ...{
            Container(
              width: 12.w,
              height: 12.h,
              margin: EdgeInsets.only(right: 5.w),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: color.parseColorM()),
            )
          },
          Text(title,
              textDirection: TextDirection.rtl,
              style: const TextStyle(
                fontFamily: 'sm',
                fontSize: 14,
              ))
        ],
      ),
    );
  }
}
