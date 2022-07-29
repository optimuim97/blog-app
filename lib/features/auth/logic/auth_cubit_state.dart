part of 'auth_cubit_cubit.dart';

@immutable
abstract class AuthCubitState {}

class AuthCubitInitial extends AuthCubitState {
  List<Object?> get props => [];
}

class AuthCubitLoading extends AuthCubitState {
  List<Object?> get props => [];
}

class AuthCubitLoaded extends AuthCubitState {
  final ApiResponse  user;
  AuthCubitLoaded(this.user);
  List<Object?> get props => [user];
}

class AuthCubitError extends AuthCubitState {
  final String error;

  AuthCubitError(this.error);
  List<Object?> get props => [error];
}
