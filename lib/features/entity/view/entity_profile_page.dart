import 'dart:developer';

import 'package:blogapp/features/post/post_page/logic/post_cubit.dart';
import 'package:blogapp/features/post/post_page/post_detail.dart';
import 'package:blogapp/features/widget/post_image_item.dart';
import 'package:blogapp/models/entity_model.dart';
import 'package:blogapp/models/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';

class EntityProfilePage extends StatefulWidget {
  const EntityProfilePage(this.entity, {Key? key}) : super(key: key);
  final EntityModel entity;
  @override
  State<EntityProfilePage> createState() => _EntityProfilePageState();
}

class _EntityProfilePageState extends State<EntityProfilePage> {
  List<dynamic> _postList = [];
  List<dynamic> _postListLimit = [];
  List<dynamic> _entityList = [];
  @override
  void initState() {
    context.read<PostCubit>().postFetch();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: new ListView(
        children: <Widget>[
          new Column(
            children: <Widget>[
              Container(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: Container(
                                height: 240.0,
                                decoration: BoxDecoration(color: Colors.white))
                            // image: DecorationImage(
                            //     fit: BoxFit.cover,
                            //           image: NetworkImage(
                            //               'https://www.sageisland.com/wp-content/uploads/2017/06/beat-instagram-algorithm.jpg'))),
                            // ),
                            )
                      ],
                    ), Container(height: 10,color: Colors.grey.shade300,),
                    Positioned(
                      top: 30.0,
                      child: Column(
                        children: [
                          Container(
                            height: 150.0,
                            width: 150.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(widget.entity.logo!),
                                ),
                                border:
                                    Border.all(color: Colors.white, width: 6.0)),
                          ),
                          Container(
                alignment: Alignment.bottomCenter,
               height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      widget.entity.name!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 28.0),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    )
                  ],
                ),
              )
                        ],
                      ),
                    ),
                  ],
                ),
              ),Container(height: 10,color: Colors.grey.shade300,),
              SizedBox(
                height: 12.0,
              ),
              Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding:EdgeInsets.only(left: 5.0) ,
                        alignment: Alignment.topLeft,
                        child: Text(
                          ' Listes des postes',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    Container(
                      child: Column(
                        children: <Widget>[_buildPostsList()],
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  _showMoreOption(cx) {
    showModalBottomSheet(
      context: cx,
      builder: (BuildContext bcx) {
        return new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.feedback,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Give feedback or report this profile',
                    style: TextStyle(fontSize: 18.0),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.block,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Block',
                    style: TextStyle(fontSize: 18.0),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.link,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Copy link to profile',
                    style: TextStyle(fontSize: 18.0),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Search Profile',
                    style: TextStyle(fontSize: 18.0),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
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
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 10),
                      child: Stack(
                        children: [
                          Center(
                            child: Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 50),
                width: MediaQuery.of(context).size.width,
                
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                 color:Colors.grey.shade200,
                  image: DecorationImage(
                      image: NetworkImage(
                        post.cover!,
                      ),
                      fit: BoxFit.cover),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '' + post.title.toString().toLowerCase(),
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
              ),
                          )

                        ],)
                      // Container(
                      //   height: 200,
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(10),
                      //       border: Border.all(
                      //           color: Colors.grey.shade300, width: 1),
                      //       color: Colors.white),
                      //   child: Row(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       PostImageItem(post: post),
                      //       SizedBox(
                      //         width: 10,
                      //       ),
                      //       Expanded(
                      //           child: Padding(
                      //         padding: const EdgeInsets.only(
                      //           top: 15.0,
                      //           right: 5,
                      //         ),
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             // ListTile(
                      //             //   title:     Text(
                      //             //   '' +
                      //             //       post.title.toString().toUpperCase(),
                      //             //   style: TextStyle(
                      //             //       fontWeight: FontWeight.bold,
                      //             //       color: Colors.black,
                      //             //       fontSize: 16),
                      //             // ),
                      //             //   subtitle: _buildRowBtnLikeAndComment(post, context),

                      //             //   contentPadding: EdgeInsets.all(0),
                      //             // ),
                      //             // _buildEntiTyFooter(post),
                      //           ],
                      //         ),
                      //       ))
                      //     ],
                      //   ),
                      // ),
                    ),
                  );
                }));
      },
    );
  }
}
