import 'package:aplle_shop_pj/data/model/variant.dart';
import 'package:aplle_shop_pj/data/model/variants_model.dart';

class ProductVariant {
  VariantType variantType;
  List<Variant> variantList;
  ProductVariant(this.variantType, this.variantList);
}
