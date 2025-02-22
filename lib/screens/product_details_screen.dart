import 'dart:ui';

import 'package:aplle_shop_pj/constants/color.dart';
import 'package:aplle_shop_pj/data/bloc/carItem.dart/cardItem_bloc.dart';
import 'package:aplle_shop_pj/data/bloc/carItem.dart/cardItem_event.dart';
import 'package:aplle_shop_pj/data/bloc/comment/comment_bloc.dart';
import 'package:aplle_shop_pj/data/bloc/product/product_bloc.dart';
import 'package:aplle_shop_pj/data/bloc/product/product_event.dart';
import 'package:aplle_shop_pj/data/bloc/product/product_state.dart';
import 'package:aplle_shop_pj/data/model/product_image.dart';
import 'package:aplle_shop_pj/data/model/product_perperty.dart';
import 'package:aplle_shop_pj/data/model/product_variant.dart';
import 'package:aplle_shop_pj/data/model/products.dart';
import 'package:aplle_shop_pj/data/model/variant.dart';
import 'package:aplle_shop_pj/data/model/variants_model.dart';
import 'package:aplle_shop_pj/di/di.dart';
import 'package:aplle_shop_pj/screens/error_page/connection_error_screen.dart';
import 'package:aplle_shop_pj/util/extentions.dart';
import 'package:aplle_shop_pj/util/loading_animation.dart';
import 'package:aplle_shop_pj/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsScreen extends StatefulWidget {
  Products product;

  ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  // void initState() {
  //   BlocProvider.of<ProductBloc>(context).add(
  //       ProductInitializedEvent(widget.product.id, widget.product.categoryId));
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return detailScreenContent(widget);
    //have parentWidget
  }

  detailScreenContent(ProductDetailsScreen parentWidget) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundScreen,
      body: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
        if (state is ProductDetailLoadingState) {
          return const LoadingAnimation();
        }
        if (state is ProductDetailResponseState) {
          return SafeArea(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
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
                            Image.asset('assets/images/icon_apple_blue.png'),
                            //Expanded
                            Expanded(
                                child: state.productCategory.fold(
                              (l) {
                                return const Text('دسته بندی',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: CustomColor.blue,
                                        fontFamily: 'sb',
                                        fontSize: 18));
                              },
                              (productCategory) {
                                return Text(productCategory.title ?? 'null',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: CustomColor.blue,
                                        fontFamily: 'sb',
                                        fontSize: 18));
                              },
                            )),
                            Image.asset('assets/images/icon_back.png'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 5.h),
                    child: Center(
                        child: Text(
                      widget.product.name,
                      style: const TextStyle(fontFamily: 'sb', fontSize: 18),
                    )),
                  ),
                ),
                state.getProductImage.fold(
                  (l) {
                    return SliverToBoxAdapter(
                      child: Text(l),
                    );
                  },
                  (productImageList) {
                    return GalleryWidget(
                        defaultProducThumnail: widget.product.thumbnail,
                        productImageList: productImageList);
                  },
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 5.h,
                  ),
                ),
                state.productVariant.fold(
                  (l) {
                    return SliverToBoxAdapter(child: Text(l));
                  },
                  (productVariantList) {
                    return VariantContainerGenerator(
                        productVariantList: productVariantList);
                  },
                ),
                state.productProperties.fold(
                  (l) {
                    return SliverToBoxAdapter(child: Text(l));
                  },
                  (preoperties) {
                    return ProductProperties(productProperties: preoperties);
                  },
                ),
                SliverToBoxAdapter(
                    child: SizedBox(
                  height: 10.h,
                )),
                ProductDescription(
                  productDescription: widget.product.description,
                ),
                SliverToBoxAdapter(
                    child: SizedBox(
                  height: 10.h,
                )),
                SliverToBoxAdapter(
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        isDismissible: true,
                        useSafeArea: true,
                        showDragHandle: true,
                        context: context,
                        builder: (context) {
                          return BlocProvider(
                            create: (context) {
                              final bloc = CommentBloc(locator.get());
                              bloc.add(CommentInitEvent(widget.product.id));
                              return bloc;
                            },
                            child: SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.5.h,
                              child: CommentButtonSheet(
                                productId: widget.product.id,
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: Container(
                        width: 300.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 1, color: CustomColor.grey),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                  'assets/images/icon_left_categroy.png'),
                              SizedBox(
                                width: 10.w,
                              ),
                              const Text(
                                'مشاهده',
                                style: TextStyle(
                                    color: CustomColor.blue,
                                    fontFamily: 'sb',
                                    fontSize: 16),
                              ),
                              const Spacer(),
                              const Text(
                                ':نظرات کاربران',
                                style:
                                    TextStyle(fontFamily: 'sb', fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                    child: SizedBox(
                  height: 10.h,
                )),
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        EdgeInsets.only(right: 28.w, left: 28.w, bottom: 20.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        priceButton(),
                        addBasKetButton(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          return const NoConnectionPage();
          // const Center(
          //   child: Text('خطا در برقراری اطلاعات'),
          // );
        }
      }),
    );
  }

  priceButton() {
    return GestureDetector(
      onTap: () {
        context.read<CardItemBloc>().add(CarItemInitPaymentEvent(49000000));
        context.read<CardItemBloc>().add(CarItemPaymentRequestEvent());
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: 140.w,
            height: 55.h,
            decoration: const BoxDecoration(
                color: CustomColor.green,
                borderRadius: BorderRadius.all(Radius.circular(15))),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                width: 140.w,
                height: 45.h,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
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
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '49000000',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'sm',
                                fontSize: 12,
                                decoration: TextDecoration.lineThrough),
                          ),
                          Text(
                            '48000000',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'sm',
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      SizedBox(
                          width: 25.w,
                          height: 15.h,
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
                          ))
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  addBasKetButton() {
    return GestureDetector(
      onTap: () {
        //in
        context
            .read<ProductBloc>()
            .add(ProductAddToCardItemEvent(widget.product));
        context.read<CardItemBloc>().add(CarItemFetchFromHiveEvent());
        var snackBar = const SnackBar(
          content: Text(
            'به سبد خرید اضافه شد',
            textAlign: TextAlign.right,
            style: TextStyle(fontFamily: 'dana', fontSize: 14),
          ),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.black,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: 140.w,
            height: 55.h,
            decoration: const BoxDecoration(
                color: CustomColor.blue,
                borderRadius: BorderRadius.all(Radius.circular(15))),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                width: 140.w,
                height: 45.h,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: const Center(
                    child: Text(
                  'افزودن سبد خرید',
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'sb', fontSize: 16),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CommentButtonSheet extends StatefulWidget {
  const CommentButtonSheet({super.key, required this.productId});

  final String productId;

  @override
  State<CommentButtonSheet> createState() => _CommentButtonSheetState();
}

class _CommentButtonSheetState extends State<CommentButtonSheet> {
  final TextEditingController editingController = TextEditingController();

  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        return Column(children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                if (state is CommentLoading) ...{
                  const SliverToBoxAdapter(
                    child: LoadingAnimation(),
                  )
                },
                if (state is CommentResponseState) ...{
                  state.response.fold((l) {
                    return SliverToBoxAdapter(
                      child: Text('is loading : $l'),
                    );
                  }, (commentList) {
                    if (commentList.isEmpty) {
                      const SliverToBoxAdapter(
                        child:
                            Center(child: Text('نظری برای این محصول ثبت نشده')),
                      );
                    }
                    return SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 10.h),
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 10.w),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                // mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                      (commentList[index].username.isEmpty)
                                          ? 'کاربر'
                                          : commentList[index].username,
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 5.h),
                                  Text(
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    commentList[index].text,
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                              SizedBox(width: 5.w),
                              SizedBox(
                                  height: 40.h,
                                  width: 40.w,
                                  child: (commentList[index].avatar.isNotEmpty)
                                      ? CachedImage(
                                          urlImage: commentList[index]
                                              .userThumnailUrl)
                                      : Image.asset(
                                          'assets/images/avatar_comment.png')),
                            ]),
                      );
                    }, childCount: commentList.length));
                  })
                }
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  child: SizedBox(
                    height: 40.h,
                    child: TextField(
                      controller: editingController,
                      decoration: const InputDecoration(
                          labelStyle: TextStyle(
                            fontFamily: 'sm',
                            fontSize: 18,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide:
                                BorderSide(color: CustomColor.blue, width: 3),
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5.h),
                  child: Visibility(
                    visible: true,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(150.w, 38.h),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            backgroundColor: Colors.blue[300]),
                        onPressed: () {
                          // if (editingController.text.isNotEmpty) {
                          //   setState(() {
                          //     visible = true;
                          //   });
                          // } else {
                          //   setState(() {
                          //     visible = false;
                          //   });
                          // }
                          context.read<CommentBloc>().add(CommentPostEvent(
                              widget.productId, editingController.text));
                          editingController.clear();
                        },
                        child: const Text(
                          'ثبت نظر',
                          style: TextStyle(
                              fontFamily: 'sb',
                              color: Colors.white,
                              fontSize: 18),
                        )),
                  ),
                )
              ],
            ),
          )
        ]);
      },
    );
  }
}

class ProductProperties extends StatefulWidget {
  List<ProductPerperties> productProperties;
  bool isVisble = false;
  ProductProperties({super.key, required this.productProperties});

  @override
  State<ProductProperties> createState() => _ProductPropertiesState();
}

class _ProductPropertiesState extends State<ProductProperties> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              widget.isVisble = !widget.isVisble;
            });
          },
          child: Padding(
            padding: EdgeInsets.only(right: 30.w, left: 30.w, top: 5.h),
            child: Container(
              width: 300.w,
              height: 50.w,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1, color: CustomColor.grey),
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/images/icon_left_categroy.png'),
                    SizedBox(
                      width: 10.w,
                    ),
                    const Text(
                      'مشاهده',
                      style: TextStyle(
                          color: CustomColor.blue,
                          fontFamily: 'sb',
                          fontSize: 16),
                    ),
                    const Spacer(),
                    const Text(
                      ':مشخصات فنی',
                      style: TextStyle(fontFamily: 'sb', fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: widget.isVisble,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Container(
              margin: EdgeInsets.only(top: 20.h),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1, color: CustomColor.grey),
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: ListView.builder(
                  itemCount: widget.productProperties.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    var property = widget.productProperties[index];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        (widget.productProperties.isEmpty)
                            ? const Text('محصول محصول محصول محصول محصول ',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontFamily: 'sb',
                                    fontSize: 16,
                                    height: 1.4,
                                    wordSpacing: 0))
                            : Text('${property.value} : ${property.title}',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontFamily: 'sb',
                                    fontSize: 16,
                                    height: 1.4.h,
                                    wordSpacing: 0))
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}

// ignore: must_be_immutable
class ProductDescription extends StatefulWidget {
  String productDescription;
  bool isVisible = false;
  ProductDescription({super.key, required this.productDescription});

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              widget.isVisible = !widget.isVisible;
            });
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Container(
              width: 300.w,
              height: 50.w,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1, color: CustomColor.grey),
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/images/icon_left_categroy.png'),
                    SizedBox(
                      width: 10.w,
                    ),
                    const Text(
                      'مشاهده',
                      style: TextStyle(
                          color: CustomColor.blue,
                          fontFamily: 'sb',
                          fontSize: 16),
                    ),
                    const Spacer(),
                    const Text(
                      ':توضیحات محصول',
                      style: TextStyle(fontFamily: 'sb', fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: widget.isVisible,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Container(
              margin: EdgeInsets.only(top: 10.h),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1, color: CustomColor.grey),
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(widget.productDescription,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontFamily: 'sb',
                          fontSize: 16,
                          height: 1.1.h,
                          wordSpacing: 0))),
            ),
          ),
        ),
      ],
    ));
  }
}

// ignore: must_be_immutable
class ColorVariantList extends StatefulWidget {
  List<Variant> variantList;
  ColorVariantList({super.key, required this.variantList});

  @override
  State<ColorVariantList> createState() => _ColorVariantListState();
}

//
// ignore: must_be_immutable
class StorageVariantList extends StatefulWidget {
  List<Variant> storageVariant = [];
  StorageVariantList({super.key, required this.storageVariant});

  @override
  State<StorageVariantList> createState() => _StorageVariantListState();
}

class _StorageVariantListState extends State<StorageVariantList> {
  List<Widget> storegWidgetList = [];

  int selectedIndex = 0;
  @override
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 25.h,
        child: ListView.builder(
          itemCount: widget.storageVariant.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Container(
                width: 55.w,
                height: 20.h,
                margin: EdgeInsets.only(left: 10.w),
                decoration: BoxDecoration(
                    border: (selectedIndex == index)
                        ? Border.all(
                            width: 3,
                            color: CustomColor.blue,
                            // strokeAlign: BorderSide.strokeAlignOutside
                          )
                        : Border.all(
                            width: 2,
                            color: Colors.grey,
                          ),
                    borderRadius: const BorderRadius.all(Radius.circular(7)),
                    color: Colors.white),
                child: Center(
                  child: Text(
                    widget.storageVariant[index].value!,
                    style:
                        const TextStyle(color: Colors.black, fontFamily: 'sb'),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ColorVariantListState extends State<ColorVariantList> {
  List<Widget> colorWidget = [];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 25.h,
        child: ListView.builder(
          itemCount: widget.variantList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Container(
                width: (selectedIndex == index) ? 30.w : 25.w,
                height: (selectedIndex == index) ? 30.h : 25.h,
                margin: EdgeInsets.only(left: 10.w),
                decoration: BoxDecoration(
                    border: (selectedIndex == index)
                        ? Border.all(
                            width: 3.w,
                            color: Colors.white,
                            // strokeAlign: BorderSide.strokeAlignOutside
                          )
                        : Border.all(
                            width: 1.w,
                            color: Colors.white,
                          ),
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    )),
                child: Container(
                  width: 26.w,
                  height: 26.h,
                  decoration: BoxDecoration(
                      color: widget.variantList[index].value.parseColorM(),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(7),
                      )),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class VariantContainerGenerator extends StatelessWidget {
  List<ProductVariant> productVariantList;
  VariantContainerGenerator({super.key, required this.productVariantList});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Padding(
      padding: EdgeInsets.only(right: 40.w),
      child: Column(
        children: [
          for (var productVariant in productVariantList) ...{
            if (productVariant.variantList.isNotEmpty) ...{
              VariantGeneratorChild(productVariant: productVariant)
            }
          }
        ],
      ),
    ));
  }
}
//

// ignore: must_be_immutable
class VariantGeneratorChild extends StatelessWidget {
  ProductVariant productVariant;
  VariantGeneratorChild({super.key, required this.productVariant});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          productVariant.variantType.title!,
          style: const TextStyle(fontFamily: 'sb', fontSize: 16),
        ),
        if (productVariant.variantType.type == VariantTypeEnum.COLOR) ...{
          ColorVariantList(variantList: productVariant.variantList)
        },
        if (productVariant.variantType.type == VariantTypeEnum.STOREG) ...{
          StorageVariantList(storageVariant: productVariant.variantList)
        },

        // Padding(
        //     padding: const EdgeInsets.only(right: 40.0),
        //     child:
        //     //    StorageVariantList(storageVariant: productVariant.variantList)
        //     //   ColorVariantList(variantList: productVariantList[0].variantList),
        //     ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class GalleryWidget extends StatefulWidget {
  List<ProductImage> productImageList;
  int selectedItem = 0;
  String? defaultProducThumnail;
  GalleryWidget(
      {super.key,
      required this.productImageList,
      required this.defaultProducThumnail});

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1, color: Colors.white),
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          height: 280.h,
          width: 280.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              //Expanded need
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 8.h, left: 5.w, right: 5.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/icon_star.png'),
                      const Text(
                        '4.6',
                        style: TextStyle(fontFamily: 'sb', fontSize: 14),
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: SizedBox(
                          //size
                          height: 200.h, width: 200.w,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: CachedImage(
                              radios: 5,
                              urlImage: (widget.productImageList.isEmpty)
                                  ? widget.defaultProducThumnail
                                  : widget.productImageList[widget.selectedItem]
                                      .imageUrl,
                              height: 20.h,
                              width: 30.w,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Image.asset('assets/images/icon_favorite_deactive.png')
                    ],
                  ),
                ),
              ),
              if (widget.productImageList.isNotEmpty) ...{
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: SizedBox(
                    height: 65.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.productImageList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(right: 15.w),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.selectedItem = index;
                              });
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15))),
                                height: 60.h,
                                width: 65.w,
                                padding: const EdgeInsets.all(1),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 1.w, vertical: 3.h),
                                    child: CachedImage(
                                      radios: 10,
                                      urlImage: widget
                                          .productImageList[index].imageUrl,
                                      width: 30.w,
                                      height: 30.h,
                                    ),
                                  ),
                                )),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // ignore: equal_elements_in_set
                SizedBox(
                  height: 10.h,
                ),
              },
            ],
          ),
        ),
      ),
    );
  }
}
