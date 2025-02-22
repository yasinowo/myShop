import 'package:aplle_shop_pj/data/bloc/category_product.dart/category_event.dart';
import 'package:aplle_shop_pj/data/bloc/category_product.dart/category_state.dart';
import 'package:aplle_shop_pj/data/datasourse/repository/category_product_repository.dart';
import 'package:aplle_shop_pj/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryProductBloc
    extends Bloc<CategoryProductEvent, CategoryProductState> {
  final ICategoryProductRepository repository = locator.get();
  CategoryProductBloc() : super(CategoryProductLoadingState()) {
    on<CategoryProductInitializeEvent>(
      (event, emit) async {
        var response =
            await repository.getProductByCategoryId(event.categoryId);
        emit(CategoryProductResponseState(response));
      },
    );
  }
}

//  CategoryProductBloc() : super(CategoryLoadingState()) {
//      final ICategoryProductRepository = locator.get();
//     on<CategoryRequestList>(
//       (event, emit) async {
//         var response =
//             await repository.;
//         emit(CategoryResponseState(response));
//       },
//     );
//   }
