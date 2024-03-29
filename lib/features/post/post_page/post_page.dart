import 'dart:developer';

import 'package:blogapp/constant.dart';
import 'package:blogapp/constant.dart';
import 'package:blogapp/features/entity/logic/entity_cubit.dart';
import 'package:blogapp/features/post/post_edit/view/post_edit_page.dart';

import 'package:blogapp/features/post/post_page/logic/post_cubit.dart';
import 'package:blogapp/features/post/post_page/post_detail.dart';
import 'package:blogapp/features/widget/post_image_item.dart';
import 'package:blogapp/models/entity_model.dart';
import 'package:blogapp/models/post.dart';
import 'package:blogapp/services/user_service.dart';
import 'package:shimmer/shimmer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePostPage extends StatefulWidget {
  const HomePostPage({Key? key}) : super(key: key);

  @override
  State<HomePostPage> createState() => _HomePostPageState();
}

class _HomePostPageState extends State<HomePostPage> {
  int current = 0;
  final CarouselController _controller = CarouselController();
  List<dynamic> _postList = [];
  List<dynamic> _postListLimit = [];
  List<dynamic> _entityList = [];
  bool isLoading = true;
  int userId = 0;

  @override
  Future<void> getId() async {
    userId = await getUserId();
  }

  void initState() {
    context.read<PostCubit>().postFetch();
    context.read<PostCubit>().getPostLimit();
    context.read<EntityCubit>().getEntity();
    getId();
    Future.delayed(const Duration(milliseconds: 3000), () {
      setState(() {
        isLoading = false;
      });
    });
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
        _buildCarousel(),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: ListTile(
            contentPadding: EdgeInsets.all(0),
            trailing: TextButton(
              onPressed: () {},
              child: Text(
                'voir plus',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            title: Text(
              'Entité',
              style: TextStyle(
                  color: colorTextBold,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        _buildEntityList(),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Text(
            'Actualité',
            style: TextStyle(
                color: colorTextBold,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        ),
        _buildPostsList(),
      ],
    ));
  }

  BlocBuilder<PostCubit, PostState> _buildPostsList() {
    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        log(state.toString());

        if (state is PostStateLoaded) {
          if (state.post.error == null) {
            _postList = state.post.data as List<dynamic>;
            log('zzze' + _postList.toString());
            // _loading = _loading ? !_loading : _loading;

          }
        }
        return isLoading
            ? Shimmer.fromColors(
                baseColor: Colors.blue.shade200,
                highlightColor: Colors.blue.shade500,
                child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25 * 10,
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 5.0, top: 10),
                              child: Container(
                                  height: 160,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: colorBorder, width: 1),
                                      color: Colors.blue),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.25,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 15.0,
                                                  right: 5,
                                                ),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [])))
                                      ])));
                        })),
              )
            : SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.25 *
                    _postList.length,
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _postList.length,
                    itemBuilder: (BuildContext context, int index) {
                      Post post = _postList[index];
                      log(post.cover.toString());
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => PostDetail(
                                        post: post,
                                      )),
                              (Route<dynamic> route) => false);
                          // Navigator.of(context).pushReplacement(MaterialPageRoute(
                          //     builder: (context) => PostDetail(
                          //           post: post,
                          //         )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 5.0, top: 10),
                          child: Container(
                            height: 160,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border:
                                    Border.all(color: colorBorder, width: 1),
                                color: Colors.white),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PostImageItem(post: post),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 15.0,
                                    right: 5,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        title: Text(
                                          '' +
                                              post.title
                                                  .toString()
                                                  .toLowerCase(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: colorTextBold,
                                              fontSize: 16),
                                        ),
                                        subtitle: _buildEntiTyFooter(post),
                                        contentPadding: EdgeInsets.all(0),
                                      ),
                                      _buildRowBtnLikeAndComment(post, context),
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
    );
  }

  Widget _buildEntiTyFooter(Post post) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                image: post.publisherImage != null
                    ? DecorationImage(
                        image: NetworkImage('${post.publisherImage}'),
                        fit: BoxFit.cover)
                    : null,
                borderRadius: BorderRadius.circular(25),
                color: Colors.red),
            child: post.publisherImage != null
                ? SizedBox()
                : Center(
                    child: Text(
                      post.publisherName!.length > 1
                          ? post.publisherName.toString().substring(0, 1)
                          : '',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: colorTextBold,
                          fontSize: 15),
                    ),
                  ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            post.publisherName.toString().toUpperCase(),
            style: TextStyle(
                fontWeight: FontWeight.bold, color: colortext, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildRowBtnLikeAndComment(Post post, BuildContext context) {
    log(post.publisherId.toString() + '==' + userId.toString());
    return Padding(
      padding: EdgeInsets.only(
        right: 5,
        top: 5,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 5,
          ),
          kLikeAndComment(
            post.likesCount!,

            // 'heart-svgrepo-com.svg',
            Colors.blue,
            () {
              context.read<PostCubit>().handlePostLikeDislike(post.id ?? 0);
              context.read<PostCubit>().postFetch();
            },
            27,
            'Vector.svg',
          ),
          kLikeAndComment(
            post.commentsCount!,
            Colors.blue,
            () {},
            30,
            'comment.svg',
          ),
          Spacer(),
          post.publisherId == userId
              ? PopupMenuButton(
                  child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.more_vert,
                        color: Colors.blue,
                      )),
                  itemBuilder: (context) => [
                    PopupMenuItem(child: Text('Modifier'), value: 'edit'),
                    PopupMenuItem(child: Text('Delete'), value: 'delete')
                  ],
                  onSelected: (val) {
                    if (val == 'edit') {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => PostEditPage(
                                    post: post,
                                    btnTitle: 'Modification du post',
                                  )),
                          (Route<dynamic> route) => false);
                    } else {
                      // _handleDeletePost(post.id ?? 0);
                    }
                  },
                )
              : SizedBox(),
        ],
      ),
    );
  }

  BlocBuilder<EntityCubit, EntityState> _buildEntityList() {
    return BlocBuilder<EntityCubit, EntityState>(
      builder: (context, state) {
        log(state.toString());
        if (state is EntityStateLoaded) {
          log('+++++++++++' + state.post.data.toString());
          _entityList = state.post.data as List<dynamic>;
        }
        return SizedBox(
          height: 50,
          child: isLoading
              ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Shimmer.fromColors(
                        baseColor: Colors.blue.shade200,
                        highlightColor: Colors.blue.shade500,
                        child: Container(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Container(
                              width: 150,
                              height: 48,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  border:
                                      Border.all(color: colorBorder, width: 1),
                                  color: Colors.white),
                            )));
                  })
              : ListView.builder(
                  itemCount: _entityList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    EntityModel entity = _entityList[index];
                    return Row(
                      children: [
                        index == 0
                            ? Container(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: Container(
                                  width: 150,
                                  height: 48,
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      border: Border.all(
                                          color: colorBorder, width: 1),
                                      color: Colors.white),
                                  child: Center(
                                      child: TextButton(
                                    onPressed: () {
                                      context.read<PostCubit>().postFetch();
                                    },
                                    child: Text(
                                      'Tous',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: colortext,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                                ),
                              )
                            : Container(),
                        Container(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Container(
                            width: 185,
                            height: 48,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                border:
                                    Border.all(color: colorBorder, width: 1),
                                color: Colors.white),
                            child: Center(
                                child: TextButton(
                              onPressed: () {
                                context
                                    .read<PostCubit>()
                                    .getPostsByEntity(entity.id!.toInt());
                              },
                              child: Text(
                                entity.name.toString(),
                                style: TextStyle(
                                    fontSize: 16,
                                    color: colorTextBold,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                          ),
                        ),
                      ],
                    );
                  }),
        );
      },
    );
  }

  BlocBuilder<PostCubit, PostState> _buildCarousel() {
    return BlocBuilder<PostCubit, PostState>(builder: (context, state) {
      // log(state.toString());

      if (state is PostStateLoadedLimit) {
        if (state.post.error == null) {
          _postListLimit = state.post.data as List<dynamic>;
          log('zzze' + _postListLimit.toString());
          // _loading = _loading ? !_loading : _loading;

        }
      }
      return isLoading
          ? Shimmer.fromColors(
              baseColor: Colors.blue.shade200,
              highlightColor: Colors.blue.shade500,
              child: Center(
                  child: Container(
                height: 200,
                padding: EdgeInsets.only(left: 20, right: 20, top: 50),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
              )))
          : CarouselSlider(
              carouselController: _controller,
              options: CarouselOptions(
                  height: 200.0,
                  viewportFraction: 0.8,
                  autoPlay: false,
                  enlargeCenterPage: true,
                  aspectRatio: 2.0,
                  onPageChanged: (index, reason) {
                    current = index;
                  }),
              items: _postList.map<Widget>((_postLists) {
                Post posts = _postLists;
                return Builder(
                  builder: (BuildContext context) {
                    return _buildCarouselItem(context, posts);
                  },
                );
              }).toList(),
            );
    });
  }

  Widget _buildCarouselItem(BuildContext context, Post posts) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 50),
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
            '' + posts.title.toString().toLowerCase(),
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.blue,
            ),
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Lire maintenant',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }
}
