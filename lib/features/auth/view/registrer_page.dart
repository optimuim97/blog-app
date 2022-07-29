import 'dart:developer';

import 'package:blogapp/constant.dart';
import 'package:blogapp/features/auth/logic/auth_cubit_cubit.dart';
import 'package:blogapp/features/auth/view/login_page.dart';
import 'package:blogapp/features/home/home_menu.dart';
import 'package:blogapp/features/post/post_page/post_page.dart';
import 'package:blogapp/features/widget/textfield_widget.dart';
import 'package:blogapp/models/user.dart';
import 'package:blogapp/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool loading = false;
  TextEditingController nameController = TextEditingController(),
      emailController = TextEditingController(),
      passwordController = TextEditingController(),
      passwordConfirmController = TextEditingController();

  var s;

  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomeMenu()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   elevation: 0,
        //   leading: IconButton(
        //     icon: const Icon(
        //       Icons.arrow_back,
        //       color: Colors.black,
        //     ),
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //   ),
        // ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child:
                        Image.asset('assets/images/3907317.jpg', height: 200)),

                Center(
                  child: const Text(
                    'Creer votre compte',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                ),
                // const SizedBox(
                //   height: 70,
                // ),
                SizedBox(
                  height: 70,
                  child: TextFieldWidget(
                    nameController: nameController,
                    lib: 'Nom',
                    obscureText: false,
                  ),
                ),
                SizedBox(
                  height: 70,
                  child: TextFieldWidget(
                    nameController: emailController,
                    lib: 'Email',
                    obscureText: false,
                  ),
                ),
                SizedBox(
                  height: 70,
                  child: TextFieldWidget(
                    nameController: passwordController,
                    lib: 'Mot de passe',
                    obscureText: true,
                  ),
                ),
                SizedBox(
                  height: 70,
                  child: TextFieldWidget(
                    nameController: passwordConfirmController,
                    lib: 'mot de passe',
                    obscureText: true,
                  ),
                ),
                BlocBuilder<AuthCubit, AuthCubitState>(
                  builder: (context, state) {
                    log(state.toString());
                    if (state is AuthCubitLoading) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (state is AuthCubitLoaded) {
                      log(state.user.data.toString());
                      if (state.user.error == null) {
                        _saveAndRedirectToHome(state.user.data as User);

                        s = 'chargement';
                      } else {}
                      s = state.user.error.toString();
                    }

                    return Center(
                        child: Text(
                      s == null ? '' : s.toString(),
                      style: TextStyle(color: Colors.black),
                    ));
                  },
                ),
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
                        context.read<AuthCubit>().registerFetch(
                            nameController.text,
                            emailController.text,
                            passwordController.text);
                      },
                      child: const Text(
                        'Se connecter',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Déja un compte? ?  '),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                              (route) => false);
                        },
                        child: Text(' Se Connecter '))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
