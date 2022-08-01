import 'package:blogapp/features/post/post_page/post_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PostDetailImage extends StatelessWidget {
  const PostDetailImage({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final PostDetail widget;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
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
    );
  }
}
