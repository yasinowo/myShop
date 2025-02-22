import 'package:aplle_shop_pj/data/model/card_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class ICardItemDatasource {
  Future<void> addProduct(CardItem cardItem);
  Future<List<CardItem>> getAllCardItem();
  Future<int> getCardItemFinalPrice();
  Future<void> removeItem(int index);
  Future<void> removeAllItem();
}

class CarditemRemotDatasource extends ICardItemDatasource {
  var box = Hive.box<CardItem>('CardBox');
  @override
  Future<void> addProduct(CardItem cardItem) async {
    box.add(cardItem);
  }

  @override
  Future<List<CardItem>> getAllCardItem() async {
    return box.values.toList();
  }

  @override
  Future<int> getCardItemFinalPrice() async {
    var productList = box.values.toList();
    var finalPrice = productList.fold(
        0, (accmulator, element) => accmulator + element.realPrice!);
    return finalPrice;
  }

  @override
  Future<void> removeItem(int index) async {
    final key = box.keyAt(index); // گرفتن کلید آیتم مورد نظر
    if (key != null) {
      await box.delete(key); // حذف بر اساس کلید
    }
  }

  @override
  Future<void> removeAllItem() async {
    box.deleteAll(box.keys);
  }
}
