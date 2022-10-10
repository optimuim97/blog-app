import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blogapp/constant.dart';
import 'package:blogapp/features/service/post_provider.dart';
import 'package:blogapp/models/api_response.dart';
import 'package:blogapp/features/service/user_provider.dart';
import 'package:meta/meta.dart';

part 'post_edit_state.dart';

class PostEditCubit extends Cubit<PostEditState> {
  PostEditCubit() : super(PostEditInitial());

  final PostApiProvider _apiProvider = PostApiProvider();

  Future createPost(final title,final String text, final File? _imageFile) async {
    emit(PostEditStateLoading());
    String? image = _imageFile == null
        ? null
        : UserApiProvider().getStringImage(_imageFile);
    ApiResponse response = await _apiProvider.createPost(title,text, image);
log(response.data.toString());
    if (response.error == null) {
      emit(PostEditStateSucces('1'));
    } else if (response.error == unauthorized) {
      emit(PostEditStateFailed('2'));
    } else {
      emit(PostEditStateFailed('3'));
    }
  }

  // edit post
  Future editPost(int postId,String title, String text) async {
    emit(PostEditStateLoading());
    ApiResponse response = await _apiProvider.editPost(postId, title,text);
    if (response.error == null) {
      emit(PostEditStateSucces('1'));
    } else if (response.error == unauthorized) {
      emit(PostEditStateFailed('2'));
    } else {
      emit(PostEditStateFailed('3'));
    }
  }
}
