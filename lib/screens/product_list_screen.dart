import 'package:aplle_shop_pj/constants/color.dart';
import 'package:aplle_shop_pj/data/bloc/category_product.dart/category_bloc.dart';
import 'package:aplle_shop_pj/data/bloc/category_product.dart/category_event.dart';
import 'package:aplle_shop_pj/data/bloc/category_product.dart/category_state.dart';
import 'package:aplle_shop_pj/data/model/category.dart';
import 'package:aplle_shop_pj/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductListScreen extends StatefulWidget {
  Categorys category;
  ProductListScreen({super.key, required this.category});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    BlocProvider.of<CategoryProductBloc>(context)
        .add(CategoryProductInitializeEvent(widget.category.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryProductBloc, CategoryProductState>(
        builder: (context, state) {
      return Scaffold(
        backgroundColor: CustomColor.backgroundScreen,
        body: SafeArea(
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
                          Expanded(
                            child: Text(widget.category.title ?? 'null',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: CustomColor.blue,
                                    fontFamily: 'sb',
                                    fontSize: 18)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (state is CategoryProductLoadingState) ...{
                SliverToBoxAdapter(
                  child: Center(
                    child: SizedBox(
                      height: 24.h,
                      width: 24.w,
                      child: const CircularProgressIndicator(),
                    ),
                  ),
                )
              },
              if (state is CategoryProductResponseState) ...{
                state.productListByCategory.fold(
                  (l) {
                    return SliverToBoxAdapter(child: Text(l));
                  },
                  (productList) {
                    return SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      sliver: SliverGrid(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return productItem(productList[index], context);
                        }, childCount: productList.length),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 20.h,
                            crossAxisSpacing: 25.w,
                            childAspectRatio: 2 / 2.7),
                      ),
                    );
                  },
                )
              }
            ],
          ),
        ),
      );
    });
  }
}
