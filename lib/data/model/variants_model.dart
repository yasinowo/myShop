class VariantType {
  String? id;
  String? name;
  String? title;
  VariantTypeEnum? type;

  VariantType(this.id, this.name, this.title, this.type);

  factory VariantType.fromObject(Map<String, dynamic> jsonObject) {
    return VariantType(
      jsonObject['id'],
      jsonObject['name'],
      jsonObject['title'],
      //tst تو ویدیو نیس
      getVariantType(jsonObject['type']),
    );
  }
}

VariantTypeEnum getVariantType(String type) {
  switch (type) {
    case 'Color':
      return VariantTypeEnum.COLOR;
    case 'Storage':
      return VariantTypeEnum.STOREG;
    case 'Voltage':
      return VariantTypeEnum.VOLTAGE;
    default:
      return VariantTypeEnum.COLOR;
  }
}

enum VariantTypeEnum {
  COLOR,
  STOREG,
  VOLTAGE;
}
