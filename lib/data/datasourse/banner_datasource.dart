import 'package:aplle_shop_pj/data/model/banner.dart';
import 'package:aplle_shop_pj/di/di.dart';
import 'package:aplle_shop_pj/util/api_exception.dart';
import 'package:dio/dio.dart';

abstract class IBannerDatasource {
  Future<List<Banner>> getBanner();
}

//Category
class BannerRemotDatasource extends IBannerDatasource {
  final Dio dio = locator.get();
  @override
  Future<List<Banner>> getBanner() async {
    try {
      var response = await dio.get('collections/banner/records');
      return response.data['items']
          .map<Banner>((jsonObject) => Banner.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiException(0, 'unknow errorr');
    }
  }
}
