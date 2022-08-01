

import 'package:bloc/bloc.dart';
import 'package:blogapp/features/service/user_provider.dart';
import 'package:blogapp/models/api_response.dart';

import 'package:meta/meta.dart';


part 'auth_cubit_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  AuthCubit() : super(AuthCubitInitial());
  final UserApiProvider _apiProvider = UserApiProvider();
  Future loginFetch(String email, String password) async {
    emit(AuthCubitLoading());
    try {
      var result = await _apiProvider.login(email, password);
      emit(AuthCubitLoaded(result));
    } catch (e) {
      emit(AuthCubitError(e.toString()));
    }
  }

  Future registerFetch(String name, String email, String password) async {
    emit(AuthCubitLoading());
    try {
      var result = await _apiProvider.register(name, email, password);
      emit(AuthCubitLoaded(result));
    } catch (e) {
      emit(AuthCubitError(e.toString()));
    }
  }

  
}
