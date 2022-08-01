import 'dart:developer';

import 'package:blogapp/features/auth/logic/auth_cubit_cubit.dart';
import 'package:blogapp/features/auth/view/registrer_page.dart';
import 'package:blogapp/features/home/home_menu.dart';

import 'package:blogapp/features/widget/textfield_widget.dart';
import 'package:blogapp/models/user.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool loading = false;
  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    log('ddde'+user.token.toString());
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomeMenu()), (route) => true);
  }

  @override
  Widget build(BuildContext context) {
    var s = '';
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
 
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/images/bckpng.jpg', ),
                Center(
                  child: const Text(
                    'Connexion',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 70,
                  child: TextFieldWidget(
                    nameController: txtEmail,
                    lib: 'Email',
                    obscureText: false,
                  ),
                ),
                SizedBox(
                  height: 70,
                  child: TextFieldWidget(
                    nameController: txtPassword,
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
                      if (state.user.data != null) {
                        _saveAndRedirectToHome(state.user.data as User);
                        s = 'chargement';
                      } else {}
                      s = state.user.error.toString();
                    }

                    return Center(
                        // ignore: unnecessary_null_comparison
                        child: Text( s!=null ?
                      s.toString():'',
                      style: TextStyle(color: Colors.black),
                    ));
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextButton(
                      onPressed: () {
                        context
                            .read<AuthCubit>()
                            .loginFetch(txtEmail.text, txtPassword.text);
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
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Pas inscrire ?  '),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()),
                              (route) => false);
                        },
                        child: Text(' Créer mon compte '))
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
