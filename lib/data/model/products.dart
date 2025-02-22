class Products {
  String id;
  String collectionId;
  String thumbnail;
  String description;
  int discountPrice;
  int price;
  String popularity;
  String name;
  int quantity;
  String categoryId;
  int? realPrice;
  num? persent;
  Products(
      this.id,
      this.collectionId,
      this.thumbnail,
      this.description,
      this.discountPrice,
      this.price,
      this.popularity,
      this.name,
      this.quantity,
      this.categoryId) {
    realPrice = price - discountPrice;
    persent = ((price - realPrice!) / price) * 100;
  }

  factory Products.fromJson(Map<String, dynamic> jsonObject) {
    return Products(
        jsonObject['id'],
        jsonObject['collectionId'],
        'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}',
        jsonObject['description'],
        jsonObject['discount_price'],
        jsonObject['price'],
        jsonObject['popularity'],
        jsonObject['name'],
        jsonObject['quantity'],
        jsonObject['category']);
  }
}
