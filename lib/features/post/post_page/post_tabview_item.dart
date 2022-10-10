import 'package:blogapp/constant.dart';
import 'package:blogapp/features/post/post_page/logic/post_cubit.dart';
import 'package:blogapp/features/post/post_page/post_detail.dart';
import 'package:blogapp/features/widget/post_image_item.dart';
import 'package:blogapp/models/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class PostListItem extends StatefulWidget {
  const PostListItem({ Key? key }) : super(key: key);

  @override
  State<PostListItem> createState() => _PostListItemState();
}

class _PostListItemState extends State<PostListItem> {
    List<dynamic> _postList = [];
    bool isLoading = true;
      @override
  void initState() {
    context.read<PostCubit>().postFetch();
  Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return  SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _buildPostsList()
      ])));
  }
   BlocBuilder<PostCubit, PostState> _buildPostsList() {
    return BlocBuilder<PostCubit, PostState>(
        builder: (context, state) {
   
          if (state is PostStateLoaded) {
            if (state.post.error == null) {
              _postList = state.post.data as List<dynamic>;
            

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
              height:
                  MediaQuery.of(context).size.height * 0.25 * _postList.length,
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _postList.length,
                  itemBuilder: (BuildContext context, int index) {
                    Post post = _postList[index];
            
                    return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PostDetail(
                                post: post,
                              )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 5.0, top: 10),
                      child: Container(
                        height: 160,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: colorBorder, width: 1),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    title: Text(
                                      '' + post.title.toString().toLowerCase(),
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
                                         'vector.svg',
                                        ),
                                        
                                        kLikeAndComment(
                                          post.commentsCount!,
                                          Colors.blue,
                                          () {
                                    
                                          },
                                          30,
                                         'comment.svg',
                                        ),
                                        IconButton(onPressed: (){}, icon: Icon(Icons.bookmark_border,color: Colors.blue,))
                                      ],
                                    ),
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

}