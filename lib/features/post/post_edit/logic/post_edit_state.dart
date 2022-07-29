part of 'post_edit_cubit.dart';

@immutable
abstract class PostEditState {}

class PostEditInitial extends PostEditState {}
class PostEditStateLoading extends PostEditState{
   List<Object?> get props => [];
}
class PostEditStateSucces extends PostEditState {
  final String message;

  PostEditStateSucces(this.message);
  List<Object?> get props => [message];
}

class PostEditStateError extends PostEditState {
  final String message;

  PostEditStateError(this.message);
  List<Object?> get props => [message];
}
class PostEditStateFailed extends PostEditState {
  final String message;

  PostEditStateFailed(this.message);
  List<Object?> get props => [message];
}