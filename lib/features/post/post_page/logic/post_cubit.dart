import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:blogapp/constant.dart';
import 'package:blogapp/features/service/post_provider.dart';
import 'package:blogapp/models/api_response.dart';
import 'package:blogapp/screens/login.dart';
import 'package:blogapp/services/user_service.dart';
import 'package:meta/meta.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostInitial());
    final PostApiProvider _apiProvider = PostApiProvider();
  Future postFetch() async {
    emit(PostStateLoading());
    try {
      var result = await _apiProvider.getPosts();
      emit(PostStateLoaded(result));
    } catch (e) {
      emit(PostStateError(e.toString()));
    }
  }

Future handleDeletePost(int postId) async {
    ApiResponse response = await _apiProvider.deletePost(postId);
    if (response.error == null) {
      // retrievePosts();
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

  // post like dislik
  Future handlePostLikeDislike(int postId) async {
    ApiResponse response = await _apiProvider.likeUnlikePost(postId);

    if (response.error == null) {
      // retrievePosts();
      log('ok');
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
 
