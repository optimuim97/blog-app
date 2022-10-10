import 'dart:developer';


import 'package:blogapp/features/entity/logic/entity_cubit.dart';
import 'package:blogapp/features/entity/view/entity_profile_page.dart';
import 'package:blogapp/models/entity_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class EntityPage extends StatefulWidget {
  const EntityPage({Key? key}) : super(key: key);

  @override
  State<EntityPage> createState() => _EntityPageState();
}

class _EntityPageState extends State<EntityPage> {
  List<dynamic> _entityList = [];
   bool isLoading = true;
  @override
  void initState() {
    context.read<EntityCubit>().getEntity();
      Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        isLoading = false;
      });
    });
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
            
              _entityList = state.post.data as List<dynamic>;
            }
            return isLoading ? Shimmer.fromColors(
                baseColor: Colors.blue.shade200,
                highlightColor: Colors.blue.shade500,
                child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25 * 10,child:
                    GridView.builder(
                  itemCount: 10,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1,
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                
                    return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300, width: 1),
            color: Colors.white),
        );})
                    ))
            
            :  _buildGrid(context);
          },
        ),
      ]),
    ));
  }

  Widget _buildGrid(BuildContext context) {
    return SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: GridView.builder(
                  itemCount: _entityList.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1,
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    EntityModel entity = _entityList[index];
                    return _buildCardEntity(entity);
                  }));
  }

  Widget _buildCardEntity(EntityModel entity) {
    return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300, width: 1),
            color: Colors.white),
        child: Center(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            CachedNetworkImage(
              imageUrl: entity.logo.toString(),
              imageBuilder: (context, imageProvider) => Container(
                width: 100,
                height: 100,
                // padding: EdgeInsets.all(10),
                // height: MediaQuery.of(context).size.height *
                //     0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => Container(
                width: 100,
                height: 100,
                // padding: EdgeInsets.all(10),
                // height: MediaQuery.of(context).size.height *
                //     0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),

                  color: Colors.grey.shade300,
                  //  borderRadius: BorderRadius.all( Radius.circular(0) ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  // padding: EdgeInsets.all(10),
                  height: 90,
                  child: Center(child: const Icon(Icons.error)),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                  )),
            ),
            Center(
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EntityProfilePage( entity)));
                    
                  },
                  child: Text(
                    entity.name.toString().toUpperCase(),
                    style: TextStyle(fontSize: 12, color: Colors.black),
                    textAlign: TextAlign.center,
                  )),
            )
          ]),
        ));
  }
}
