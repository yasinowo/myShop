class ProductPerperties {
  String? title;
  String? value;

  ProductPerperties(this.title, this.value);

  factory ProductPerperties.fromJson(Map<String, dynamic> jsonObject) {
    return ProductPerperties(
      jsonObject['title'],
      jsonObject['value'],
    );
  }
}
