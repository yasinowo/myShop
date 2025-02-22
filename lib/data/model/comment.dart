class Comment {
  String id;
  String text;
  String productId;
  String userId;
  String userThumnailUrl;
  String username;
  String avatar;

  Comment(this.id, this.text, this.productId, this.userId, this.userThumnailUrl,
      this.username, this.avatar);

  factory Comment.fromJsom(Map<String, dynamic> jsonObject) {
    return Comment(
      jsonObject['id'],
      jsonObject['text'],
      jsonObject['product_id'],
      jsonObject['user_id'],
      // 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
      'https://startflutter.ir/api/files/${jsonObject['expand']['user_id']['collectionName']}/${jsonObject['expand']['user_id']['id']}/${jsonObject['expand']['user_id']['avatar']}',
      jsonObject['expand']['user_id']['username'],
      jsonObject['expand']['user_id']['avatar'],
    );
  }
}
