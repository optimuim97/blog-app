import 'package:flutter/material.dart';

class Entity extends StatefulWidget {
  Entity({Key? key}) : super(key: key);

  @override
  _EntityState createState() => _EntityState();
}

class _EntityState extends State<Entity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Entities Screen'),
      ),
    );
  }
}
