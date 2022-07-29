part of 'post_cubit.dart';

@immutable
abstract class PostState {}

class PostInitial extends PostState {}


class PostStateLoading extends PostState {
  List<Object?> get props => [];
}

class PostStateLoaded extends PostState {
  final ApiResponse  post;
  PostStateLoaded(this.post);
  List<Object?> get props => [post];
}

class PostStateError extends PostState {
  final String error;

  PostStateError(this.error);
  List<Object?> get props => [error];
}