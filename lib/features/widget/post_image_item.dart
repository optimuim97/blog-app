import 'package:blogapp/models/post.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PostImageItem extends StatelessWidget {
  const PostImageItem({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
             imageUrl: post.cover!,
             imageBuilder:
                 (context, imageProvider) =>
                     Container(
               width: MediaQuery.of(context)
                       .size
                       .width *
                   0.35,
               height: 200,
               // padding: EdgeInsets.all(10),
               // height: MediaQuery.of(context).size.height *
               //     0.2,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.only(
                     topLeft: Radius.circular(10),
                     bottomLeft:
                         Radius.circular(10)),
                 image: DecorationImage(
                   image: imageProvider,
                   fit: BoxFit.cover,
                 ),
               ),
             ),
             placeholder: (context, url) =>
                 Container(
               width: MediaQuery.of(context)
                       .size
                       .width *
                   0.35,
               // padding: EdgeInsets.all(10),
               height: 200,
               decoration: BoxDecoration(
                 color: Colors.grey.shade300,
                 borderRadius: BorderRadius.only(
                     topLeft: Radius.circular(10),
                     bottomLeft:
                         Radius.circular(10)),
               ),
             ),
             errorWidget: (context, url, error) =>
                 Container(
                     width: MediaQuery.of(context)
                             .size
                             .width *
                         0.35,
                     // padding: EdgeInsets.all(10),
                     height: 200,
                     child: Center(
                         child: const Icon(
                             Icons.error)),
                     decoration: BoxDecoration(
                         color: Colors.grey.shade300,
                         borderRadius:
                             BorderRadius.only(
                                 topLeft: Radius
                                     .circular(10),
                                 bottomLeft:
                                     Radius.circular(
                                         10)))),
           );
  }
}