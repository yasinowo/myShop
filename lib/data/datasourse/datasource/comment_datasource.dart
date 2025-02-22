import 'package:aplle_shop_pj/data/model/comment.dart';
import 'package:aplle_shop_pj/di/di.dart';
import 'package:aplle_shop_pj/util/api_exception.dart';
import 'package:aplle_shop_pj/util/auth_manager.dart';
import 'package:dio/dio.dart';

abstract class ICommentDataSource {
  Future<List<Comment>> getComment(String productId);
  Future<void> postComment(String productId, String comment);
}

class CommentRemoteDataSource extends ICommentDataSource {
  final Dio dio = locator.get();
  final String userId = AuthManager.getId();
  @override
  Future<List<Comment>> getComment(String productId) async {
    Map<String, dynamic> qParams = {
      'filter': 'product_id="$productId"',
      'expand': 'user_id',
      'perPage': 1000,
      'sort': '-updated'
    };
    try {
      var response = await dio.get('collections/comment/records',
          queryParameters: qParams);
      return response.data['items']
          .map<Comment>((jsonObject) => Comment.fromJsom(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiException(0, 'unknow errorr');
    }
  }

  @override
  Future<void> postComment(String productId, String comment) async {
    try {
      await dio.post('collections/comment/records',
          options: Options(
            followRedirects: false,
            headers: {
              'Content-Type': 'application/json',
            },
          ),
          data: {'text': comment, 'user_id': userId, 'product_id': productId});
    } on DioException catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    }
  }
}
