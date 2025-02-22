import 'package:aplle_shop_pj/data/datasourse/datasource/comment_datasource.dart';
import 'package:aplle_shop_pj/data/model/comment.dart';
import 'package:aplle_shop_pj/di/di.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class ICommentRepository {
  Future<Either<String, List<Comment>>> getComment(String productId);
  Future<Either<String, String>> postComment(String productId, String comment);
}

class CommentRepository extends ICommentRepository {
  final ICommentDataSource _dataSource = locator.get();
  @override
  Future<Either<String, List<Comment>>> getComment(String productId) async {
    try {
      var response = await _dataSource.getComment(productId);
      return right(response);
    } on DioException catch (e) {
      return Left(e.message ?? 'null error');
    }
  }

  @override
  Future<Either<String, String>> postComment(
      String productId, String comment) async {
    try {
      //var response = await _dataSource.postComment(productId, comment);
      return right('نظر شما با موفقیت ثبت شمد');
    } on DioException catch (e) {
      return Left(e.message ?? 'null error');
    }
  }
}
