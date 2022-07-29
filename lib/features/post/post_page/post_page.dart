import 'dart:developer';

import 'package:blogapp/constant.dart';
import 'package:blogapp/features/post/post_edit/view/post_edit_page.dart';
import 'package:blogapp/features/post/post_page/logic/post_cubit.dart';
import 'package:blogapp/models/post.dart';
import 'package:blogapp/screens/comment_screen.dart';
import 'package:blogapp/screens/post_form.dart';
import 'package:blogapp/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePostPage extends StatefulWidget {
  const HomePostPage({Key? key}) : super(key: key);

  @override
  State<HomePostPage> createState() => _HomePostPageState();
}

class _HomePostPageState extends State<HomePostPage> {
  List<dynamic> _postList = [];
  @override
  Widget build(BuildContext context) {
    context.read<PostCubit>().postFetch();
    return SingleChildScrollView(
        child: BlocBuilder<PostCubit, PostState>(builder: (context, state) {
      // if(state is PostStateLoading){
      //   return Center(child: CircularProgressIndicator());
      // }
      if (state is PostStateLoaded) {
        if (state.post.error == null) {
          _postList = state.post.data as List<dynamic>;
          // _loading = _loading ? !_loading : _loading;

        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${state.post.error}'),
          ));
        }
        // log(state.post.data);
      }
      return RefreshIndicator(
        onRefresh: () {
          return context.read<PostCubit>().postFetch();
          // return retrievePosts();
        },
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: [
              // BlocConsumer<PostCubit, PostState>(
              //   listener: (context, state) {
              //     if (state is PostStateLoaded) {
              //       if (state.post.error == null) {
              //         _postList = state.post.data as List<dynamic>;
              //         // _loading = _loading ? !_loading : _loading;

              //       } else {
              //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //           content: Text('${state.post.error}'),
              //         ));
              //       }
              //     }
              //   },
              //   builder: (context, state) {
              //  BlocBuilder<PostCubit, PostState>(
              //       builder: (context, state) {
              //         // if(state is PostStateLoading){
              //         //   return Center(child: CircularProgressIndicator());
              //         // }
              //         if (state is PostStateLoaded) {
              //           if (state.post.error == null) {
              //             _postList = state.post.data as List<dynamic>;
              //             // _loading = _loading ? !_loading : _loading;

              //           } else {
              //             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //               content: Text('${state.post.error}'),
              //             ));
              //           }
              //           // log(state.post.data);
              //         }
              // return
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: ListView.builder(
                    itemCount: _postList.length,
                    itemBuilder: (BuildContext context, int index) {
                      Post post = _postList[index];
                      return Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade300),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.only(
                                    left: 10, right: 5, top: 10),
                                trailing: PopupMenuButton(
                                  child: Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.more_vert,
                                        color: Colors.black,
                                      )),
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                        child: Text('Modifier'), value: 'edit'),
                                    PopupMenuItem(
                                        child: Text('Delete'), value: 'delete')
                                  ],
                                  onSelected: (val) {
                                    if (val == 'edit') {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PostEditPage(
                                                    btnTitle: 'Modifier',
                                                    post: post,
                                                  )));
                                    } else {
                                      context
                                          .read<PostCubit>()
                                          .handleDeletePost(post.id ?? 0);
                                      context.read<PostCubit>().postFetch();
                                      // _handleDeletePost(post.id ?? 0);
                                    }
                                  },
                                ),
                                leading: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      // image: post.user!.image != null
                                      //     ? DecorationImage(
                                      //         fit: BoxFit.cover,
                                      //         image: NetworkImage(
                                      //             '${post.user!.image}'))
                                      //     : null,
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.amber),
                                ),
                                title: Text(
                                  post.publisherName.toString().toLowerCase(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 20),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 5, bottom: 10),
                                child: Text(
                                  '${post.title}',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 17),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              post.cover != null
                                  ? Padding(
                                      padding: const EdgeInsets.all(14.0),
                                      child: CachedNetworkImage(
                                        imageUrl: '${post.cover}',
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          // padding: EdgeInsets.all(10),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.5,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    )
                                  : SizedBox(
                                      height: post.cover != null ? 0 : 10,
                                    ),
                              // Padding(
                              //   padding: EdgeInsets.only(
                              //       left: 20, right: 20, top: 5, bottom: 10),
                              //   child: Row(
                              //     children: [
                              //       kLikeAndComment(
                              //           post.likesCount ?? 0,
                              //           post.selfLiked == true
                              //               ? 'heartfull.svg'
                              //               : 'heart-svgrepo-com.svg',
                              //           post.selfLiked == true
                              //               ? Colors.red
                              //               : Colors.black, () {
                              //         context
                              //             .read<PostCubit>()
                              //             .handlePostLikeDislike(post.id ?? 0);
                              //         context.read<PostCubit>().postFetch();
                              //       }, 27),
                              //       // Container(
                              //       //   height: 25,
                              //       //   width: 0.5,
                              //       //   color: Colors.black38,
                              //       // ),
                              //       kLikeAndComment(
                              //           post.commentsCount ?? 0,
                              //           'comment-svgrepo-com.svg',
                              //           Colors.black, () {
                              //         Navigator.of(context).push(
                              //             MaterialPageRoute(
                              //                 builder: (context) =>
                              //                     CommentScreen(
                              //                       postId: post.id,
                              //                     )));
                              //       }, 30),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      );
                    }),
                //   );
                // },
              )
            ],
          ),
        ),
      );
    }));
  }
}
