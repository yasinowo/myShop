import 'package:aplle_shop_pj/constants/color.dart';
import 'package:aplle_shop_pj/data/bloc/category/categort_state.dart';
import 'package:aplle_shop_pj/data/bloc/category/category_bloc.dart';
import 'package:aplle_shop_pj/data/bloc/category/category_event.dart';
import 'package:aplle_shop_pj/data/bloc/category_product.dart/category_bloc.dart';
import 'package:aplle_shop_pj/data/model/category.dart';
import 'package:aplle_shop_pj/screens/product_list_screen.dart';
import 'package:aplle_shop_pj/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    BlocProvider.of<CategoryBloc>(context).add(CategoryRequestList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundScreen,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
              sliver: SliverToBoxAdapter(
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
                        const Expanded(
                          child: Text('دسته بندی',
                              textAlign: TextAlign.center,
                              style: TextStyle(
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
            BlocBuilder<CategoryBloc, CategortState>(
              builder: (context, state) {
                if (state is CategoryLoadingState) {
                  return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (state is CategoryResponseState) {
                  return state.response.fold((l) {
                    return SliverToBoxAdapter(
                      child: Center(child: Text(l)),
                    );
                  }, (r) {
                    return ListCategory(categoryList: r);
                  });
                }
                return const SliverToBoxAdapter(
                  child: Text('error'),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class ListCategory extends StatelessWidget {
  List<Categorys>? categoryList;
  ListCategory({super.key, required this.categoryList});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate((context, index) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => CategoryProductBloc(),
                        child: ProductListScreen(
                          category: categoryList![index],
                        ),
                      ),
                    ));
              },
              child: CachedImage(
                urlImage: categoryList?[index].thumbnail,
                fontSize: 30,
              ));
        }, childCount: categoryList?.length ?? 0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 18.h,
          crossAxisSpacing: 15.w,
        ),
      ),
    );
  }
}
