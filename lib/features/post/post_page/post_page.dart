import 'dart:developer';

import 'package:blogapp/constant.dart';
import 'package:blogapp/features/entity/logic/entity_cubit.dart';

import 'package:blogapp/features/post/post_page/logic/post_cubit.dart';
import 'package:blogapp/features/post/post_page/post_detail.dart';
import 'package:blogapp/features/widget/post_image_item.dart';
import 'package:blogapp/models/entity_model.dart';
import 'package:blogapp/models/post.dart';

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
  @override
  void initState() {
    context.read<PostCubit>().postFetch();
    // context.read<PostCubit>().getPostLimit();
    // context.read<EntityCubit>().getEntity();
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
                  color: Colors.black,
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
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
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
          return SizedBox(
              height:
                  MediaQuery.of(context).size.height * 0.25 * _postList.length,
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
                        padding: const EdgeInsets.only(left :20.0,right: 20.0,top: 10),
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 1),
                              color: Colors.white),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             PostImageItem(post: post)
                                ,
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 15.0, right: 10, ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                
                                 
                                    ListTile(
                                      title:     Text(
                                      '' +
                                          post.title.toString().toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 16),
                                    ),
                                      subtitle: _buildRowBtnLikeAndComment(post, context),
                                      
                                      
                                      contentPadding: EdgeInsets.all(0),
                                    ),
                                    _buildEntiTyContent(post),
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

  Widget _buildEntiTyContent(Post post) {
    return Row(
                                      children: [
                                        Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          image: post.cover.isEmpty
                                              ? DecorationImage(
                                                  image: NetworkImage(
                                                      '${post.cover.isEmpty}'),
                                               fit: BoxFit.cover)
                                              : null,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: Colors.blue),
                                      child: post.cover.isEmpty
                                          ? SizedBox()
                                          : Center(
                                              child: Text(
                                                post.publisherName.length >
                                                        1
                                                    ? post.publisherName
                                                        .toString()
                                                        .substring(0, 1)
                                                    : '',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 20),
                                              ),
                                            ),
                                    ),SizedBox(width: 10,),
                                        Text(
                                          post.publisherName.toString(),
                                          style: TextStyle(
                                              fontWeight:
                                                  FontWeight.bold,
                                              color: Colors.grey,
                                              fontSize: 14),
                                        ),
                                      ],
                                    );
  }

  Widget _buildRowBtnLikeAndComment(Post post, BuildContext context) {
    return Padding(
                                    padding: EdgeInsets.only(
                                        right: 5, top: 5,),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 5,
                                        ),
                                        kLikeAndComment(
                                          post.likesCount,

                                          // 'heart-svgrepo-com.svg',
                                          Colors.blue,
                                          () {
                                            context
                                                .read<PostCubit>()
                                                .handlePostLikeDislike(
                                                    post.id);
                                            context
                                                .read<PostCubit>()
                                                .postFetch();
                                          },
                                          27,
                                          Icons.favorite_outline_sharp,
                                        ),
                                        
                                        kLikeAndComment(
                                          post.commentsCount,
                                          Colors.blue,
                                          () {
                                    
                                          },
                                          30,
                                          Icons.comment,
                                        ),
                                        IconButton(onPressed: (){}, icon: Icon(Icons.bookmark_border,color: Colors.blue,))
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
            child: ListView.builder(
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
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    border: Border.all(
                                        color: Colors.blue, width: 1),
                                    color: Colors.white),
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    context.read<PostCubit>().postFetch();
                                  },
                                  child: Text(
                                    'Tous',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                              ),
                            )
                          : Container(),
                      Container(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Container(
                          width: 170,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              border:
                                  Border.all(color: Colors.blue, width: 1),
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
                                  fontSize: 15,
                                  color: Colors.blue,
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
        return CarouselSlider(
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
                        posts.cover,
                      ),
                      fit: BoxFit.cover),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '' + posts.title.toString().toLowerCase(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 25),
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


