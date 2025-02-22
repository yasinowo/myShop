import 'package:aplle_shop_pj/data/datasourse/repository/comment_repository.dart';
import 'package:aplle_shop_pj/data/model/comment.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  ICommentRepository repository;
  CommentBloc(this.repository) : super(CommentLoading()) {
    on<CommentInitEvent>((event, emit) async {
      final response = await repository.getComment(event.productId);
      emit(CommentResponseState(response));
    });
    on<CommentPostEvent>(
      (event, emit) async {
        emit(CommentLoading());
        await repository.postComment(event.productId, event.comment);
        final response = await repository.getComment(event.productId);
        emit(CommentResponseState(response));
      },
    );
  }
}
