import 'package:flutter/material.dart';

import 'screens/loading.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'Aclonica',
          primaryColor: Colors.blue,
          accentColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: Loading(),
    );
  }
}
