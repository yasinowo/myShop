import 'package:aplle_shop_pj/data/bloc/category/categort_state.dart';
import 'package:aplle_shop_pj/data/bloc/category/category_event.dart';
import 'package:aplle_shop_pj/data/datasourse/repository/categorys_repository.dart';
import 'package:aplle_shop_pj/di/di.dart';
import 'package:bloc/bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategortState> {
  final ICategorysRepository repository = locator.get();
  CategoryBloc() : super(MassageInitialS()) {
    on<CategoryRequestList>(
      (event, emit) async {
        emit(CategoryLoadingState());
        var response = await repository.getCategory();
        emit(CategoryResponseState(response));
      },
    );
  }
}
