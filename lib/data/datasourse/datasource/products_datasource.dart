import 'package:aplle_shop_pj/data/model/products.dart';
import 'package:aplle_shop_pj/di/di.dart';
import 'package:aplle_shop_pj/util/api_exception.dart';
import 'package:dio/dio.dart';

abstract class IProductsDatasource {
  Future<List<Products>> getProducts();
  Future<List<Products>> getHotestProducts();
  Future<List<Products>> getBestSellerProducts();
}

//Category
class ProductsRemotDatasource extends IProductsDatasource {
  final Dio dio = locator.get();
  @override
  Future<List<Products>> getProducts() async {
    try {
      var response = await dio.get('collections/products/records');
      return response.data['items']
          .map<Products>((jsonObject) => Products.fromJson(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiException(0, 'unknow errorr');
    }
  }

  @override
  Future<List<Products>> getBestSellerProducts() async {
    try {
      Map<String, String> qParams = {'filter': 'popularity="Best Seller"'};
      var respones = await dio.get('collections/products/records',
          queryParameters: qParams);
      return respones.data['items']
          .map<Products>((jsonObject) => Products.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown erorr');
    }
  }

  @override
  Future<List<Products>> getHotestProducts() async {
    try {
      Map<String, String> qParams = {'filter': 'popularity="Hotest"'};
      var respones = await dio.get('collections/products/records',
          queryParameters: qParams);
      return respones.data['items']
          .map<Products>((jsonObject) => Products.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown erorr');
    }
  }
}
