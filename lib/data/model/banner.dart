class Banner {
  String? collectionId;
  String? id;
  String? thumbnail;
  String? categoryId;
  Banner(this.collectionId, this.id, this.thumbnail, this.categoryId);
  factory Banner.fromMapJson(Map<String, dynamic> jsonObject) {
    return Banner(
        jsonObject['collectionId'],
        jsonObject['id'],
        'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}',
        jsonObject['categoryId']);
  }
}
