part of 'post_comment_cubit.dart';

@immutable
abstract class PostCommentState {}

class PostCommentInitial extends PostCommentState {}
class PostCommentStateLoading extends PostCommentState{
   List<Object?> get props => [];
}
class PostCommentStateSucces extends PostCommentState {
  final ApiResponse  comment;
final int userId;
  PostCommentStateSucces(this.comment, this.userId);
  List<Object?> get props => [comment,userId];
}

class PostCommentStateError extends PostCommentState {
  final String message;

  PostCommentStateError(this.message);
  List<Object?> get props => [message];
}
class PostCommentStateFailed extends PostCommentState {
  final String message;

  PostCommentStateFailed(this.message);
  List<Object?> get props => [message];
}