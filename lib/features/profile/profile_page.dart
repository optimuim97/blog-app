
import 'dart:io';

import 'package:blogapp/features/auth/view/login_page.dart';
import 'package:blogapp/features/profile/logic/profile_cubit.dart';
import 'package:blogapp/features/widget/textfield_widget.dart';
import 'package:blogapp/models/user.dart';
import 'package:blogapp/services/user_service.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user;
 String image='';
  bool loading = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File? _imageFile;
  final _picker = ImagePicker();
  TextEditingController txtNameController = TextEditingController();
  TextEditingController txtEmailController = TextEditingController();
  Future getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }
  @override
  void initState() {
    context.read<ProfileCubit>().getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
          

            BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
              if (state is ProfileStateLoaded) {
                user = state.post;
                txtNameController.text = user!.name!;
                txtEmailController.text = user!.email!;
                image=user?.image ??'';
                // log(state.post.email.toString());
              }

              return Column(
                children: [
                      Center(
                        child: GestureDetector(
                      child: Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            image: _imageFile == null
                                // ignore: unnecessary_null_comparison
                                ?DecorationImage(
                                        image: NetworkImage('$image'),
                                        fit: BoxFit.cover)
                                   
                                : DecorationImage(
                                    image: FileImage(_imageFile ?? File('')),
                                    fit: BoxFit.cover),
                            color: Colors.amber),
                      ),
                      onTap: () {
                        getImage();
                      },
                    )),
                      TextButton(onPressed:  () {
                  logout().then((value) => {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => LoginPage()),
                            (route) => false)
                      });
                },child: Text('Deconnexion')),
                  TextFieldWidget(
                      nameController: txtNameController,
                      lib: 'Nom d utilisateur',
                      obscureText: false),
                  TextFieldWidget(
                      nameController: txtEmailController,
                      lib: 'Email',
                      obscureText: false),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)),
                      child: TextButton(
                        onPressed: () {
                          context.read<ProfileCubit>().updateProfile(txtNameController.text,_imageFile!);
                        },
                        child: const Text(
                          'Mettre a jour',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      )),
                  // Center(
                  //       child: GestureDetector(
                  //     child: Container(
                  //       width: 110,
                  //       height: 110,
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(60),
                  //           image: _imageFile == null
                  //               ? user!.image != null
                  //                   ? DecorationImage(
                  //                       image: NetworkImage('${user!.image}'),
                  //                       fit: BoxFit.cover)
                  //                   : null
                  //               : DecorationImage(
                  //                   image: FileImage(_imageFile ?? File('')),
                  //                   fit: BoxFit.cover),
                  //           color: Colors.amber),
                  //     ),
                  //     onTap: () {
                  //       getImage();
                  //     },
                  //   )),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
