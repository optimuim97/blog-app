import 'package:blogapp/models/api_response.dart';
import 'package:blogapp/models/user.dart';
import 'package:blogapp/screens/home.dart';
import 'package:blogapp/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';
import 'login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool loading = false;
  TextEditingController nameController = TextEditingController(),
      emailController = TextEditingController(),
      passwordController = TextEditingController(),
      passwordConfirmController = TextEditingController();

  void _registerUser() async {
    ApiResponse response = await register(
        nameController.text, emailController.text, passwordController.text);
    if (response.error == null) {
      _saveAndRedirectToHome(response.data as User);
    } else {
      setState(() {
        loading = !loading;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  // Save and redirect to home
  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Home()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CRÉER MON COMPTE 📰',
          style: TextStyle(fontSize: 25.0),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
          children: [
            TextFormField(
                controller: nameController,
                validator: (val) => val!.isEmpty ? 'Nom invalide' : null,
                decoration: kInputDecoration('Nom')),
            SizedBox(
              height: 20,
            ),
            TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (val) => val!.isEmpty ? 'E-mail invalide' : null,
                decoration: kInputDecoration('Email')),
            SizedBox(
              height: 20,
            ),
            TextFormField(
                controller: passwordController,
                obscureText: true,
                validator: (val) => val!.length < 6
                    ? 'Ce champ requiere au moins 6 caractère'
                    : null,
                decoration: kInputDecoration('Mot de passe')),
            SizedBox(
              height: 20,
            ),
            TextFormField(
                controller: passwordConfirmController,
                obscureText: true,
                validator: (val) => val != passwordController.text
                    ? 'Mot de passe de confirmation'
                    : null,
                decoration: kInputDecoration('Confirmation ... ')),
            SizedBox(
              height: 20,
            ),
            loading
                ? Center(child: CircularProgressIndicator())
                : kTextButton(
                    'S\'inscrire',
                    () {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          loading = !loading;
                          _registerUser();
                        });
                      }
                    },
                  ),
            SizedBox(
              height: 20,
            ),
            kLoginRegisterHint('Déja un compte? ', 'Se Connecté', () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Login()),
                  (route) => false);
            })
          ],
        ),
      ),
    );
  }
}
