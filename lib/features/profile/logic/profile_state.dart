part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}
class ProfileStateLoading extends ProfileState {
  List<Object?> get props => [];
}

class ProfileStateLoaded extends ProfileState {
  final User  post;
  ProfileStateLoaded(this.post);
  List<Object?> get props => [post];
}

class ProfileStateError extends ProfileState {
  final String error;

  ProfileStateError(this.error);
  List<Object?> get props => [error];
}