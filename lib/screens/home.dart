import 'dart:io';

import 'package:blogapp/constant.dart';
import 'package:blogapp/features/auth/view/login_page.dart';
import 'package:blogapp/models/api_response.dart';
import 'package:blogapp/models/user.dart';
import 'package:blogapp/screens/entity_screen.dart';
import 'package:blogapp/screens/entity_type.screen.dart';

import 'package:blogapp/screens/profile.dart';
import 'package:blogapp/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'login.dart';

import '../constant.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  User? user;
  bool loading = true;

  void getUser() async {
    ApiResponse response = await getUserDetail();
    if (response.error == null) {
      setState(() {
        user = response.data as User;
        loading = false;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Login()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ActuPlus'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              logout().then((value) => {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false)
                  });
            },
          )
        ],
      ),
      body: currentIndex == 0 ? Container()
      // PostScreen() 
      : Profile(),
      drawer: MyDrawer(
        onTap: (ctx, i) {
          setState(() {
            // index = i;
            Navigator.pop(ctx);
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) => PostForm(
          //           title: 'Ajouter une nouveau post',
          //         )));
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5,
        elevation: 10,
        clipBehavior: Clip.antiAlias,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: '')
          ],
          currentIndex: currentIndex,
          onTap: (val) {
            setState(() {
              currentIndex = val;
            });
          },
        ),
      ),
    );
  }
}

class MyDrawer extends StatefulWidget {
  final Function onTap;
  MyDrawer({required this.onTap});

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  User? user;
  bool loading = true;
  File? imageFile;
  final _picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  //Get User Details
  void getUser() async {
    ApiResponse response = await getUserDetail();
    if (response.error == null) {
      setState(() {
        user = response.data as User;

        loading = false;
        // print('user: $user');
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Login()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  @override
  void initState() {
    getUser();
    // getImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Padding(
                padding: EdgeInsets.all(6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        // width: 60,
                        // height: 60,
                        // child: Container(
                        //   width: 110,
                        //   height: 110,
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(60),
                        //       image: imageFile == null
                        //           ? user!.image != null
                        //               ? DecorationImage(
                        //                   image: NetworkImage('${user!.image}'),
                        //                   fit: BoxFit.cover)
                        //               : null
                        //           : DecorationImage(
                        //               image: FileImage(imageFile ?? File('')),
                        //               fit: BoxFit.cover),
                        //       color: Colors.amber),
                        // ),
                        ),
                    SizedBox(
                      height: 9.0,
                    ),
                    // Text('${user!.name ?? ''}',
                    //     style: TextStyle(color: Colors.white, fontSize: 20.0)),
                    SizedBox(
                      height: 5,
                    ),
                    // Text(
                    //   '${user!.email ?? ''}',
                    //   style: TextStyle(color: Colors.white, fontSize: 12.0),
                    // ),
                  ],
                ),
              ),
            ),
            ListTile(
                leading: Icon(Icons.home),
                title: Text('Accueil'),
                onTap: () => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Home()),
                    (route) => true)

                // widget.onTap(context, 0),
                ),
            Divider(
              height: 3.0,
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Type D\' Entités'),
              onTap: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => EntityType()),
                  (route) => true)
              // onTap(context, 1)
              ,
            ),
            Divider(
              height: 3.0,
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Liste Entités'),
              onTap: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Entity()),
                  (route) => true)
              // onTap(context, 2)
              ,
            ),
            Divider(
              height: 3.0,
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Se déconnecté'),
              // onTap: () => onTap(context, 3),
            ),
            Divider(
              height: 3.0,
            ),
          ],
        ),
      ),
    );
  }
}
