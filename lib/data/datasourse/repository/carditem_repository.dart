import 'package:aplle_shop_pj/data/datasourse/datasource/caritem_datasource.dart';
import 'package:aplle_shop_pj/data/model/card_item.dart';
import 'package:aplle_shop_pj/di/di.dart';
import 'package:dartz/dartz.dart';

abstract class ICardItemRepository {
  Future<Either<String, String>> addProductToCard(CardItem cardItem);
  Future<Either<String, List<CardItem>>> getAllCardItem();
  Future<int> getCardItemFinalPrice();
  Future<void> removeItem(int index);
  Future<void> removeAllItem();
}

class CarditemRepository extends ICardItemRepository {
  final ICardItemDatasource datasource = locator.get();

  @override
  Future<Either<String, String>> addProductToCard(CardItem cardItem) async {
    try {
      datasource.addProduct(cardItem);
      return right('succses addProduct');
    } catch (e) {
      return left('error!!! addProduct');
    }
  }

  @override
  Future<Either<String, List<CardItem>>> getAllCardItem() async {
    try {
      var cardItemList = await datasource.getAllCardItem();
      return right(cardItemList);
    } catch (e) {
      return left('error!!!');
    }
  }

  @override
  Future<int> getCardItemFinalPrice() async {
    return datasource.getCardItemFinalPrice();
  }

  @override
  Future<void> removeItem(int index) async {
    datasource.removeItem(index);
  }

  @override
  Future<void> removeAllItem() async {
    datasource.removeAllItem();
  }
}
