import 'package:hive/hive.dart';
part 'card_item.g.dart';

//BaketItem == CardItem
@HiveType(typeId: 0)
class CardItem {
  @HiveField(0)
  String id;
  @HiveField(1)
  String collectionId;
  @HiveField(2)
  String thumbnail;
  @HiveField(3)
  int discountPrice;
  @HiveField(4)
  int price;
  @HiveField(5)
  String name;
  @HiveField(6)
  String categoryId;
  @HiveField(7)
  int? realPrice;
  @HiveField(8)
  num? persent;

  CardItem(this.id, this.collectionId, this.thumbnail, this.discountPrice,
      this.price, this.name, this.categoryId) {
    realPrice = price - discountPrice;
    persent = ((price - realPrice!) / price) * 100;
    //this.tumnail ='http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}',
  }
}
