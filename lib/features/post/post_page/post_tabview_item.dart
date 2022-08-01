import 'package:blogapp/constant.dart';
import 'package:blogapp/features/post/post_page/logic/post_cubit.dart';
import 'package:blogapp/features/post/post_page/post_detail.dart';
import 'package:blogapp/features/widget/post_image_item.dart';
import 'package:blogapp/models/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostListItem extends StatefulWidget {
  const PostListItem({ Key? key }) : super(key: key);

  @override
  State<PostListItem> createState() => _PostListItemState();
}

class _PostListItemState extends State<PostListItem> {
    List<dynamic> _postList = [];
      @override
  void initState() {
    context.read<PostCubit>().postFetch();

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
          return SizedBox(
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
                                          image: post.publisherImage != null
                                              ? DecorationImage(
                                                  image: NetworkImage(
                                                      '${post.publisherImage}'),
                                                  fit: BoxFit.cover)
                                              : null,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: Colors.blue),
                                      child: post.publisherImage != null
                                          ? SizedBox()
                                          : Center(
                                              child: Text(
                                                post.publisherName!.length >
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
                                        
                                        kLikeAndComment(
                                          post.commentsCount!,
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

}