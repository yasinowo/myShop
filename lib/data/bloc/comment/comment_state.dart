part of 'comment_bloc.dart';

@immutable
sealed class CommentState {}

final class CommentLoading extends CommentState {}

final class CommentResponseState extends CommentState {
  Either<String, List<Comment>> response;
  CommentResponseState(this.response);
}

class CommentPostLoadingState extends CommentState {
  bool isLoading;
  CommentPostLoadingState(this.isLoading);
}

class CommentPostResponseState extends CommentState {
  Either<String, String> response;
  CommentPostResponseState(this.response);
}
