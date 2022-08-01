import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:blogapp/constant.dart';
import 'package:blogapp/features/service/comment_provider.dart';
import 'package:blogapp/features/service/user_provider.dart';
import 'package:blogapp/models/api_response.dart';
import 'package:meta/meta.dart';

part 'post_comment_state.dart';

class PostCommentCubit extends Cubit<PostCommentState> {
  PostCommentCubit() : super(PostCommentInitial());
  final UserApiProvider _userApiprovider = UserApiProvider();
  final CommentApiProvider _commentApiprovider = CommentApiProvider();

  Future getComments(int postId) async {
    final userId = await _userApiprovider.getUserId();
    log(('token'+userId.toString()));
    var response = await _commentApiprovider.getComments(postId);
log(response.error.toString());
    if (response.error == null) {
      emit(PostCommentStateSucces(response,userId));
    } else if (response.error == unauthorized) {
      emit(PostCommentStateFailed('2'));
    } else {
      emit(PostCommentStateFailed('3'));
    }
  }

  // create comment
  Future createComment(int postId, String text) async {
    ApiResponse response =
        await _commentApiprovider.createComment(postId, text);
    if (response.error == null) {
    } else if (response.error == unauthorized) {
    } else {}
  }

  // edit comment
  void editComment(int commentId, String text) async {
    ApiResponse response =
        await _commentApiprovider.editComment(commentId, text);

    if (response.error == null) {
      // _editCommentId = 0;
      // _txtCommentController.clear();
      // _getComments();
    } else if (response.error == unauthorized) {
    } else {}
  }

  // Delete comment
  Future deleteComment(int commentId) async {
    ApiResponse response = await _commentApiprovider.deleteComment(commentId);
log('ok');
    if (response.error == null) {
    } else if (response.error == unauthorized) {
    } else {}
  }
}
