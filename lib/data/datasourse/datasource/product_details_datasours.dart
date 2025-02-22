import 'package:aplle_shop_pj/data/model/category.dart';
import 'package:aplle_shop_pj/data/model/product_image.dart';
import 'package:aplle_shop_pj/data/model/product_perperty.dart';
import 'package:aplle_shop_pj/data/model/product_variant.dart';
import 'package:aplle_shop_pj/data/model/variant.dart';
import 'package:aplle_shop_pj/data/model/variants_model.dart';
import 'package:aplle_shop_pj/di/di.dart';
import 'package:aplle_shop_pj/util/api_exception.dart';
import 'package:dio/dio.dart';

abstract class IDetailProductDataSource {
  Future<List<ProductImage>> getGallery(String productId);
  Future<List<VariantType>> getVariantType();
  Future<List<Variant>> getVarian(String productId);
  Future<List<ProductVariant>> getProductVariants(String productId);
  Future<Categorys> getProductCategory(String categoryId);
  Future<List<ProductPerperties>> getProductPropertis(String productId);
}

class DetailsProductRemotDataSource extends IDetailProductDataSource {
  final Dio dio = locator.get();
  @override
  Future<List<ProductImage>> getGallery(String productId) async {
    try {
      var qParams = {'filter': 'product_id="$productId"'};
      var response = await dio.get('collections/gallery/records',
          queryParameters: qParams);
      return response.data['items']
          .map<ProductImage>((jsonObject) => ProductImage.fromJson(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiException(0, 'unknow errorr');
    }
  }

  @override
  Future<List<VariantType>> getVariantType() async {
    try {
      var response = await dio.get(
        'collections/variants_type/records',
      );
      return response.data['items']
          .map<VariantType>((jsonObject) => VariantType.fromObject(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiException(0, 'unknow errorr');
    }
  }

  @override
  Future<List<Variant>> getVarian(String productId) async {
    try {
      var qParams = {'filter': 'product_id="$productId"'};
      //at0y1gm0t65j62j
//                برا فیلتر نزده ادیبی
      var response = await dio.get('collections/variants/records',
          queryParameters: qParams);
      return response.data['items']
          .map<Variant>((jsonObject) => Variant.fromJson(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiException(0, 'unknow errorr');
    }
  }

  @override
  Future<List<ProductVariant>> getProductVariants(String productId) async {
    var variantTypeList = await getVariantType();
    var variantList = await getVarian(productId);
    List<ProductVariant> productVariantList = [];
    try {
      for (var variantType in variantTypeList) {
        //قاطی کردن اسم ؟؟
        var vriant = variantList
            .where((element) => element.typeId == variantType.id)
            .toList();
        productVariantList.add(ProductVariant(variantType, vriant));
      }
      return productVariantList;
    } on DioException catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiException(0, 'unknow errorr');
    }
  }

  @override
  Future<Categorys> getProductCategory(String categoryId) async {
    try {
      Map<String, String> qParams = {'filter': 'id="$categoryId"'};
      var response = await dio.get('collections/category/records',
          queryParameters: qParams);
      return Categorys.fromMapJson(response.data['items'][0]);
    } on DioException catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiException(0, 'unknow errorr');
    }
  }

  @override
  Future<List<ProductPerperties>> getProductPropertis(String productId) async {
    try {
      var qParams = {'filter': 'product_id="$productId"'};

      var response = await dio.get('collections/properties/records',
          queryParameters: qParams);
      return response.data['items']
          .map<ProductPerperties>(
              (jsonObject) => ProductPerperties.fromJson(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiException(0, 'unknow errorr');
    }
  }
}
