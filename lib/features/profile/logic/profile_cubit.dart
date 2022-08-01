import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blogapp/constant.dart';
import 'package:blogapp/features/post/post_comment/logic/post_comment_cubit.dart';
import 'package:blogapp/features/service/user_provider.dart';
import 'package:blogapp/models/api_response.dart';
import 'package:blogapp/models/user.dart';
import 'package:blogapp/services/user_service.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  final UserApiProvider _userApiprovider = UserApiProvider();

  Future getUser() async {
    emit(ProfileStateLoading());
    ApiResponse response = await _userApiprovider.getUserDetail();
    log(response.error.toString());
    if (response.error == null) {
      final user = response.data as User;
      emit(ProfileStateLoaded(user));
    } else if (response.error == unauthorized) {
      log('message');
    } else {
      
    }
  }
    //update profile
  Future updateProfile(String name,File imageFile) async {
    ApiResponse response =
        await _userApiprovider.updateUser(name, getStringImage(imageFile));
    // setState(() {
    //   loading = false;
    // });
    if (response.error == null) {
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text('${response.data}')));
    } else if (response.error == unauthorized) {
      // logout().then((value) => {
      //       Navigator.of(context).pushAndRemoveUntil(
      //           MaterialPageRoute(builder: (context) => Login()),
      //           (route) => false)
      //     });
    } else {
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }
}
