import 'dart:developer';

import 'package:blogapp/features/post/post_comment/logic/post_comment_cubit.dart';
import 'package:blogapp/features/post/post_comment/view/post_comment_page.dart';
import 'package:blogapp/features/widget/textfield_widget.dart';
import 'package:blogapp/models/api_response.dart';
import 'package:blogapp/models/comment.dart';
import 'package:blogapp/models/post.dart';
import 'package:blogapp/services/comment_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';

class PostDetail extends StatefulWidget {
  const PostDetail({Key? key, required this.post}) : super(key: key);
  final Post post;
  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  List<dynamic> _commentsList = [];
  bool _loading = true;
  int userId = 0;
  int _editCommentId = 0;
  TextEditingController _txtCommentController = TextEditingController();
void _deleteComment(int commentId) async {
    ApiResponse response = await deleteComment(commentId);

    if(response.error == null){
    }
   
    else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}')
      ));
    }
  }
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
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: '${widget.post.cover}',
                  imageBuilder: (context, imageProvider) => Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    // padding: EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Center(child: Container()),
                  errorWidget: (context, url, error) =>
                      Center(child: const Icon(Icons.error)),
                ),
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
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.post.description!,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Colors.blue,
                    ),
                    Text(
                      widget.post.likesCount!.toString() + ' jaimes',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.post.likesCount!.toString() + ' commentaires',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                ),
                Row(
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
                            context.read<PostCommentCubit>().editComment(
                                _editCommentId, _txtCommentController.text);
                            context
                                .read<PostCommentCubit>()
                                .getComments(widget.post.id!);
                            _txtCommentController.text = '';
                          } else {
                            context.read<PostCommentCubit>().createComment(
                                widget.post.id!, _txtCommentController.text);
                    
                            context
                                .read<PostCommentCubit>()
                                .getComments(widget.post.id!);
                            _txtCommentController.text = '';
                            // _createComment();
                          }
                        }
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                BlocBuilder<PostCommentCubit, PostCommentState>(
                  builder: (context, state) {
                    if (state is PostCommentStateSucces) {
                      _commentsList = state.comment.data as List<dynamic>;
                      userId = state.userId;
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
                                    border: Border.all(
                                        color: Colors.black26, width: 0.5)),

                                child: Column(
                                  children: [
                                    ListTile(
                                        leading: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              image: comment.user!.image != null
                                                  ? DecorationImage(
                                                      image: NetworkImage(
                                                          '${comment.user!.image}'),
                                                      fit: BoxFit.cover)
                                                  : null,
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              color: Colors.blue),
                                          child: comment.user!.image != null
                                              ? SizedBox()
                                              : Center(
                                                  child: Text(
                                                    comment.user!.name
                                                        .toString()
                                                        .substring(0, 1),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize: 20),
                                                  ),
                                                ),
                                        ),
                                        contentPadding: EdgeInsets.all(0),
                                        trailing: comment.user!.id == userId
                                            ? PopupMenuButton(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 10),
                                                    child: Icon(
                                                      Icons.more_vert,
                                                      color: Colors.black,
                                                    )),
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                      child: Text('Edit'),
                                                      value: 'edit'),
                                                  PopupMenuItem(
                                                      child: Text('Delete'),
                                                      value: 'delete')
                                                ],
                                                onSelected: (val) {
                                                  if (val == 'edit') {
                                                    setState(() {
                                                      _editCommentId =
                                                          comment.id ?? 0;
                                                      _txtCommentController
                                                              .text =
                                                          comment.comment ?? '';
                                                    });
                                                  } else {
                                                    log(comment.id.toString());
                                                    context
                                                        .read<
                                                            PostCommentCubit>()
                                                        .deleteComment(
                                                            comment.id??0);
                                                            
                                                            
                                                            // _deleteComment( comment.id??0);
                                                            context
                                                        .read<
                                                            PostCommentCubit>()
                                                        .getComments(
                                                            widget.post.id!);
                                                    // _deleteComment(comment.id ?? 0);
                                                  }
                                                },
                                              )
                                            : SizedBox(),
                                        title: Text(
                                          comment.user!.name
                                              .toString()
                                              .toLowerCase(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        subtitle: Text(
                                          comment.comment
                                              .toString()
                                              .toLowerCase(),
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        )),
                                  ],
                                ),
                              
                              ),
                            );
                          }),
                    );
                  },
                )
              ],
            )),
      ),
    );
  }
}
