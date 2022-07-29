import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    required this.nameController, required this.lib, required this.obscureText,
  }) : super(key: key);

  final TextEditingController nameController;
final String lib;
final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:10.0),
      child: TextField(
        controller: nameController,
        style:
            TextStyle(fontSize: 16.0, color: Colors.black),
              obscureText: obscureText,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: lib,
          contentPadding: const EdgeInsets.only(
              left: 14.0, bottom: 8.0, top: 8.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(15.7),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.pink.shade50),
            borderRadius: BorderRadius.circular(15.7),
          ),
        ),
      ),
    );
  }
}