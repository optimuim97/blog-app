import 'package:blogapp/features/post/post_comment/logic/post_comment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostCOmmentPage extends StatefulWidget {
  const PostCOmmentPage({Key? key, required this.postId}) : super(key: key);
final int postId;
  @override
  State<PostCOmmentPage> createState() => _PostCOmmentPageState();
}

class _PostCOmmentPageState extends State<PostCOmmentPage> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCommentCubit, PostCommentState>(
      builder: (context, state) {
        return Text('');
      },
    );
  }
}
