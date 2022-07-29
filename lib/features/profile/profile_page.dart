import 'package:blogapp/features/auth/view/login_page.dart';
import 'package:blogapp/services/user_service.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({ Key? key }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  
   @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        IconButton(onPressed: (){
             logout().then((value) => {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false)
                  });
        }, icon: Icon(Icons.logout))
      ],),
    );
  }
}