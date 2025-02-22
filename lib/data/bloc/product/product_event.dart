import 'package:aplle_shop_pj/data/model/products.dart';

abstract class ProductEvent {}

class ProductInitializedEvent extends ProductEvent {
  String productId;
  String categoryId;
  ProductInitializedEvent(this.productId, this.categoryId);
}

class ProductAddToCardItemEvent extends ProductEvent {
  Products product;
  ProductAddToCardItemEvent(this.product);
}
