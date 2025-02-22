import 'package:aplle_shop_pj/data/bloc/product/product_event.dart';
import 'package:aplle_shop_pj/data/bloc/product/product_state.dart';
import 'package:aplle_shop_pj/data/datasourse/repository/carditem_repository.dart';
import 'package:aplle_shop_pj/data/datasourse/repository/product_detail_repository.dart';
import 'package:aplle_shop_pj/data/model/card_item.dart';
import 'package:aplle_shop_pj/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IDetailProductRepository productRepository = locator.get();
  final ICardItemRepository cardItemRepository = locator.get();
  ProductBloc() : super(ProductInitState()) {
    on<ProductInitializedEvent>(
      (event, emit) async {
        emit(ProductDetailLoadingState());
        var productImage =
            await productRepository.getProductImage(event.productId);
        var productVariant =
            await productRepository.getProductVariants(event.productId);
        var productCategory =
            await productRepository.getProductCategory(event.categoryId);
        var productProperties =
            await productRepository.getProductProperties(event.productId);
        emit(ProductDetailResponseState(
            productImage, productVariant, productCategory, productProperties));
      },
    );
    on<ProductAddToCardItemEvent>(
      (event, emit) {
        var cardItem = CardItem(
            event.product.id,
            event.product.collectionId,
            event.product.thumbnail,
            event.product.discountPrice,
            event.product.price,
            event.product.name,
            event.product.categoryId);
        cardItemRepository.addProductToCard(cardItem);
      },
    );
  }
}
