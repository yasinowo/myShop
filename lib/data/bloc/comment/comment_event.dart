part of 'comment_bloc.dart';

@immutable
sealed class CommentEvent {}

class CommentInitEvent extends CommentEvent {
  String productId;

  CommentInitEvent(this.productId);
}

class CommentPostEvent extends CommentEvent {
  String productId;
  String comment;
  CommentPostEvent(this.productId, this.comment);
}
