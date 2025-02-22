import 'package:aplle_shop_pj/data/model/products.dart';
import 'package:aplle_shop_pj/util/api_exception.dart';
import 'package:dio/dio.dart';

import '../../../di/di.dart';

abstract class ICategoryProductDatasource {
  Future<List<Products>> getProductCategoryById(String categoryId);
}

class CategoryProductRemoteDatasource extends ICategoryProductDatasource {
  @override
  Future<List<Products>> getProductCategoryById(String categoryId) async {
    final Dio dio = locator.get();
    Response response;
    Map<String, String> qParams = {'filter': 'category="$categoryId"'};
    try {
      if (categoryId == 'qnbj8d6b9lzzpn8') {
        response = await dio.get(
          'collections/products/records',
        );
      } else {
        response = await dio.get('collections/products/records',
            queryParameters: qParams);
      }

      return response.data['items']
          .map<Products>((jsonObject) => Products.fromJson(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiException(0, 'unknow errorr');
    }
  }
}
