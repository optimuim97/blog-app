import 'dart:developer';

import 'package:blogapp/constant.dart';
import 'package:blogapp/features/post/post_comment/view/post_comment_page.dart';
import 'package:blogapp/features/post/post_edit/view/post_edit_page.dart';
import 'package:blogapp/features/post/post_page/logic/post_cubit.dart';
import 'package:blogapp/features/post/post_page/post_detail.dart';
import 'package:blogapp/models/post.dart';
import 'package:blogapp/screens/comment_screen.dart';
import 'package:blogapp/screens/post_form.dart';
import 'package:blogapp/services/user_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePostPage extends StatefulWidget {
  const HomePostPage({Key? key}) : super(key: key);

  @override
  State<HomePostPage> createState() => _HomePostPageState();
}

class _HomePostPageState extends State<HomePostPage> {
   int _current = 0;
  final CarouselController _controller = CarouselController();
  List<dynamic> _postList = [];
  @override
  void initState() {
    context.read<PostCubit>().postFetch();
    super.initState();
  }

  List<String> images = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTIZccfNPnqalhrWev-Xo7uBhkor57_rKbkw&usqp=CAU",
    "https://wallpaperaccess.com/full/2637581.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        BlocBuilder<PostCubit, PostState>(builder: (context, state) {
          log(state.toString());

          if (state is PostStateLoaded) {
            if (state.post.error == null) {
              _postList = state.post.data as List<dynamic>;
              log('zzze' + _postList.toString());
              // _loading = _loading ? !_loading : _loading;

            }
          }
          return CarouselSlider(
             carouselController: _controller,
            options: CarouselOptions(
              viewportFraction : 0.8,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          
            // options: CarouselOptions(
            //   height: 300.0,
            //   enlargeCenterPage: true,
              
            //   onPageChanged: (position, reason) {
            //     print(reason);
            //     print(CarouselPageChangedReason.controller);
            //   },
            //   enableInfiniteScroll: false,
            // ),
            items: _postList.map<Widget>((_postLists) {
              Post posts = _postLists;
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    padding: EdgeInsets.only(left:20,right: 20,top:120),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      image: DecorationImage(
                          image: NetworkImage(
                            posts.cover!,
                          ),
                          fit: BoxFit.cover),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(
                                        '' +
                                            posts.title.toString().toLowerCase(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 25),
                                      ),SizedBox(height: 10,),
                                      Container(padding: EdgeInsets.all(5),
                                         decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.blue,),
                                        child: TextButton(onPressed: (){}, child:  Text(
                                          'Lire maintenant' ,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),),
                                      )
                      ],
                    ),
                  );
                },
              );
            }).toList(),
          );
        }),
         SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            'Entité',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 70,
          child: ListView.builder(
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 150,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: Colors.blue, width: 1),
                        color: Colors.white),
                    child: Center(
                        child: Text(
                      'entité',
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                );
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            'Actualité',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        BlocBuilder<PostCubit, PostState>(
          builder: (context, state) {
            log(state.toString());

            if (state is PostStateLoaded) {
              if (state.post.error == null) {
                _postList = state.post.data as List<dynamic>;
                log('zzze' + _postList.toString());
                // _loading = _loading ? !_loading : _loading;

              }
            }
            return SizedBox(
                height:  MediaQuery.of(context).size.height *
                                        0.25 * _postList.length,

                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                    itemCount: _postList.length,
                    itemBuilder: (BuildContext context, int index) {
                      Post post = _postList[index];
                      log(post.cover.toString());
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PostDetail(
                                    post: post,
                                  )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.grey.shade300, width: 1),
                                color: Colors.white),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: post.cover.toString(),
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    // padding: EdgeInsets.all(10),
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10)),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) => Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    // padding: EdgeInsets.all(10),
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10)),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.35,
                                          // padding: EdgeInsets.all(10),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.2,
                                          child: Center(
                                              child: const Icon(Icons.error)),
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade300,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10)))),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, right: 10, bottom: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '' +
                                            post.title.toString().toUpperCase(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        post.description!.substring(0, 40) +
                                            '/n' +
                                            post.publisherName
                                                .toString()
                                                .toLowerCase(),
                                        style: TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 15),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: 20, top: 15, bottom: 10),
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                  border: Border.all(
                                                      color: Colors.blue,
                                                      width: 1),
                                                  color: Colors.white),
                                              child: Center(
                                                  child: Text(
                                                post.publisherName
                                                    .toString()
                                                    .toLowerCase(),
                                                style: TextStyle(
                                                    // fontWeight: FontWeight.bold,
                                                    color: Colors.blue,
                                                    fontSize: 15),
                                              )),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            kLikeAndComment(
                                              post.likesCount!,

                                              // 'heart-svgrepo-com.svg',
                                              Colors.blue,
                                              () {
                                                context
                                                    .read<PostCubit>()
                                                    .handlePostLikeDislike(
                                                        post.id ?? 0);
                                                context
                                                    .read<PostCubit>()
                                                    .postFetch();
                                              },
                                              27,
                                              Icons.favorite_outline_sharp,
                                            ),
                                            // Container(
                                            //   height: 25,
                                            //   width: 0.5,
                                            //   color: Colors.black38,
                                            // ),
                                            kLikeAndComment(
                                              post.commentsCount!,
                                              Colors.blue,
                                              () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CommentScreen(
                                                              postId: post.id,
                                                            )));
                                              },
                                              30,
                                              Icons.comment,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                              ],
                            ),
                          ),
                        ),
                      );
                    }));
          },
        ),
      ],
    ));
  }
}
