import 'package:aplle_shop_pj/di/di.dart';
import 'package:aplle_shop_pj/util/api_exception.dart';
import 'package:dio/dio.dart';
import 'package:aplle_shop_pj/data/model/category.dart';

abstract class ICategoryDatasource {
  Future<List<Categorys>> getCategory();
}

//Category
class CategoryRemoteDataSource extends ICategoryDatasource {
  final Dio dio = locator.get();
  @override
  Future<List<Categorys>> getCategory() async {
    try {
      var response = await dio.get('collections/category/records');
      return response.data['items']
          .map<Categorys>((jsonObject) => Categorys.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiException(0, 'unknow errorr');
    }
  }
}
