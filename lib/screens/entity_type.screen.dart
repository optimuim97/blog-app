import 'package:flutter/material.dart';

class EntityType extends StatefulWidget {
  EntityType({Key? key}) : super(key: key);

  @override
  _EntityTypeState createState() => _EntityTypeState();
}

class _EntityTypeState extends State<EntityType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Entity Type'),
      ),
    );
  }
}
