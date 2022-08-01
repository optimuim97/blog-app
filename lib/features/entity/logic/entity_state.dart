part of 'entity_cubit.dart';

@immutable
abstract class EntityState {}

class EntityInitial extends EntityState {}
class EntityStateLoading extends EntityState {
  List<Object?> get props => [];
}

class EntityStateLoaded extends EntityState {
  final ApiResponse  post;
  EntityStateLoaded(this.post);
  List<Object?> get props => [post];
}

class EntityStateError extends EntityState {
  final String error;

  EntityStateError(this.error);
  List<Object?> get props => [error];
}