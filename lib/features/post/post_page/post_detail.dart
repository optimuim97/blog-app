import 'dart:developer';

import 'package:blogapp/features/home/home_menu.dart';
import 'package:blogapp/features/post/post_comment/logic/post_comment_cubit.dart';
import 'package:blogapp/features/post/post_page/post_page.dart';

import 'package:blogapp/features/widget/post_detail_image_Item.dart';
import 'package:blogapp/features/widget/textfield_widget.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:blogapp/models/comment.dart';
import 'package:blogapp/models/post.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:html_editor_enhanced/utils/shims/dart_ui_real.dart';

class PostDetail extends StatefulWidget {
  const PostDetail({Key? key, required this.post}) : super(key: key);
  final Post post;
  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  List<dynamic> _commentsList = [];

  int userId = 0;
  int _editCommentId = 0;
  TextEditingController _txtCommentController = TextEditingController();

  @override
  void initState() {
    context.read<PostCommentCubit>().getComments(widget.post.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_sharp,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => HomeMenu()),
                (Route<dynamic> route) => false);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PostDetailImage(widget: widget),
                SizedBox(
                  height: 20,
                ),
                _buildEntiTyItemPost(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  widget.post.title!,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),

                Text(widget.post.description!,
                    style: TextStyle(
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
                // Html(
                //   data: widget.post.description!,
                //   onImageError: (exception, stackTrace) {
                //     print(exception);
                //   },
                // ),

                //   Text(
                //   widget.post.description!,
                //   style: TextStyle(
                //       color: Colors.grey,
                //       fontWeight: FontWeight.bold,
                //       fontSize: 15),
                // ),
                SizedBox(
                  height: 10,
                ),
                _buildLikeAndComment(),
                _buildTextfieldComment(context),
                SizedBox(
                  height: 20,
                ),
                _buildBlocListComment()
              ],
            )),
      ),
    );
  }

  BlocBuilder<PostCommentCubit, PostCommentState> _buildBlocListComment() {
    return BlocBuilder<PostCommentCubit, PostCommentState>(
      builder: (context, state) {
        if (state is PostCommentStateSucces) {
          _commentsList = state.comment.data as List<dynamic>;
          userId = state.userId;
          log(userId.toString());
        }

        print(state.toString());
        return SizedBox(
          height: 120 * _commentsList.length.toDouble(),
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: _commentsList.length,
              itemBuilder: (BuildContext context, int index) {
                Comment comment = _commentsList[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black26, width: 0.5)),
                    child: Column(
                      children: [
                        _buildItemComment(comment, context),
                      ],
                    ),
                  ),
                );
              }),
        );
      },
    );
  }

  Widget _buildItemComment(Comment comment, BuildContext context) {
    return ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              image: comment.user!.image != null
                  ? DecorationImage(
                      image: NetworkImage('${comment.user!.image}'),
                      fit: BoxFit.cover)
                  : null,
              borderRadius: BorderRadius.circular(25),
              color: Colors.blue),
          child: comment.user!.image != null
              ? SizedBox()
              : Center(
                  child: Text(
                    comment.user!.name.toString().substring(0, 1),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                ),
        ),
        contentPadding: EdgeInsets.all(0),
        trailing: comment.user!.id == userId
            ? PopupMenuButton(
                child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.more_vert,
                      color: Colors.black,
                    )),
                itemBuilder: (context) => [
                  PopupMenuItem(child: Text('Edit'), value: 'edit'),
                  PopupMenuItem(child: Text('Delete'), value: 'delete')
                ],
                onSelected: (val) {
                  if (val == 'edit') {
                    setState(() {
                      _editCommentId = comment.id ?? 0;
                      _txtCommentController.text = comment.comment ?? '';
                    });
                  } else {
                    log(comment.id.toString());
                    context
                        .read<PostCommentCubit>()
                        .deleteComment(comment.id ?? 0);

                    // _deleteComment( comment.id??0);
                    context
                        .read<PostCommentCubit>()
                        .getComments(widget.post.id!);
                    // _deleteComment(comment.id ?? 0);
                  }
                },
              )
            : SizedBox(),
        title: Text(
          comment.user!.name.toString().toLowerCase(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          comment.comment.toString().toLowerCase(),
          style: TextStyle(
            color: Colors.black,
          ),
        ));
  }

  Widget _buildTextfieldComment(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFieldWidget(
              nameController: _txtCommentController,
              lib: 'ajouter votre commentaire',
              obscureText: false),
        ),
        IconButton(
          icon: Icon(
            Icons.send,
            color: Colors.blue,
          ),
          onPressed: () {
            if (_txtCommentController.text.isNotEmpty) {
              if (_editCommentId > 0) {
                // _editComment();
                context
                    .read<PostCommentCubit>()
                    .editComment(_editCommentId, _txtCommentController.text);
                context.read<PostCommentCubit>().getComments(widget.post.id!);
                _txtCommentController.text = '';
                setState(() {
                  _editCommentId = 0;
                });
              } else {
                context
                    .read<PostCommentCubit>()
                    .createComment(widget.post.id!, _txtCommentController.text);

                context.read<PostCommentCubit>().getComments(widget.post.id!);
                _txtCommentController.text = '';
                setState(() {
                  _editCommentId = 0;
                });
                // _createComment();
              }
            }
          },
        )
      ],
    );
  }

  Widget _buildLikeAndComment() {
    return Row(
      children: [
        Icon(
          Icons.favorite,
          color: Colors.blue,
        ),
        Text(
          widget.post.likesCount!.toString() + " j'aimes",
          style: TextStyle(
              color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 13),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          widget.post.commentsCount!.toString() + ' commentaires',
          style: TextStyle(
              color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildEntiTyItemPost() {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              image: widget.post.publisherImage != null
                  ? DecorationImage(
                      image: NetworkImage('${widget.post.publisherImage}'),
                      fit: BoxFit.cover)
                  : null,
              borderRadius: BorderRadius.circular(25),
              color: Colors.blue),
          child: Center(
            child: Text(
              widget.post.publisherName!.length > 1
                  ? widget.post.publisherName.toString().substring(0, 1)
                  : '',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20),
            ),
          ),
        ),
        Expanded(
            child: Text(
          widget.post.publisherName!,
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ))
      ],
    );
  }
}
