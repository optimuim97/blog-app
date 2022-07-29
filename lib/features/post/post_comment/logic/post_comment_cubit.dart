import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'post_comment_state.dart';

class PostCommentCubit extends Cubit<PostCommentState> {
  PostCommentCubit() : super(PostCommentInitial());
}
