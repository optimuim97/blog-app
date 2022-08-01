import 'dart:developer';
import 'dart:ui';

import 'package:blogapp/features/entity/logic/entity_cubit.dart';
import 'package:blogapp/models/entity_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EntityPage extends StatefulWidget {
  const EntityPage({Key? key}) : super(key: key);

  @override
  State<EntityPage> createState() => _EntityPageState();
}

class _EntityPageState extends State<EntityPage> {
  List<dynamic> _entityList = [];
  @override
  void initState() {
    context.read<EntityCubit>().getEntity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      BlocBuilder<EntityCubit, EntityState>(
          builder: (context, state) {
            log(state.toString());
            if (state is EntityStateLoaded) {
              log('+++++++++++' + state.post.data.toString());
              _entityList = state.post.data as List<dynamic>;
            }
            return SizedBox(
              height: MediaQuery.of(context).size.height *0.9,
              child: GridView.builder(
          itemCount: _entityList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1 ,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,),
          itemBuilder: (BuildContext context, int index) {
              EntityModel entity = _entityList[index];
            return Container(  padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey.shade300, width: 1),
                              color: Colors.white),
              child: Column(children: [
                 CachedNetworkImage(
                   imageUrl: entity.logo.toString(),
                   imageBuilder: (context, imageProvider) =>
                       Container(
                     width: MediaQuery.of(context).size.width *
                         0.4,
                     height: 100,
                     // padding: EdgeInsets.all(10),
                     // height: MediaQuery.of(context).size.height *
                     //     0.2,
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
                         0.4,
                     // padding: EdgeInsets.all(10),
                     height: 90,
                     decoration: BoxDecoration(
                       color: Colors.grey.shade300,
                      //  borderRadius: BorderRadius.all( Radius.circular(0) ),
                     ),
                   ),
                   errorWidget: (context, url, error) =>
                       Container(
                           width: MediaQuery.of(context)
                                   .size
                                   .width *
                               0.4,
                           // padding: EdgeInsets.all(10),
                           height: 90,
                           child: Center(
                               child: const Icon(Icons.error)),
                           decoration: BoxDecoration(
                               color: Colors.grey.shade300,
                             )),


          ),TextButton(onPressed: (){}, child: Text(entity.name.toString(),style: TextStyle(color:Colors.black),))]));})
            );
          },
      ),
    ]),
        ));
  }
}
