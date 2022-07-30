// ----- STRINGS ------
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// const baseURL = 'http://192.168.121.201:8000/api';
const baseURL = 'http://192.168.1.68:8000/api';
const loginURL = baseURL + '/login';
const registerURL = baseURL + '/register';
const logoutURL = baseURL + '/logout';
const userURL = baseURL + '/user';
const postsURL = baseURL + '/posts';
const commentsURL = baseURL + '/comments';

// ----- Errors -----
const serverError = 'Erreur du serveur';
const unauthorized = 'Non autorisé';
const somethingWentWrong =
    'Quelque chose s\'est mal passé, veuillez réessayer!';

// --- input decoration
InputDecoration kInputDecoration(String label) {
  return InputDecoration(
      labelText: label,
      contentPadding: EdgeInsets.all(10),
      border: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.black)));
}

// button

TextButton kTextButton(String label, Function onPressed) {
  return TextButton(
    child: Text(
      label,
      style: TextStyle(color: Colors.white),
    ),
    style: ButtonStyle(
        backgroundColor:
            MaterialStateColor.resolveWith((states) => Colors.blue),
        padding: MaterialStateProperty.resolveWith(
            (states) => EdgeInsets.symmetric(vertical: 10))),
    onPressed: () => onPressed(),
  );
}

// loginRegisterHint
Row kLoginRegisterHint(String text, String label, Function onTap) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(text),
      GestureDetector(
          child: Expanded(
              child: Text(label,
                  style: TextStyle(color: Colors.blue, fontSize: 15.0))),
          onTap: () => onTap())
    ],
  );
}

// likes and comment btn

Widget kLikeAndComment(int value, Color color, Function onTap ,double width , IconData icon) {
  return SizedBox(
    width: 60,
    child: Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: () => onTap(),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
//                 SvgPicture.asset('assets/images/${icon}',
// width: width,
//                     color: color, semanticsLabel: 'A red up arrow'),
                Icon(
                  icon,
                  size: 22,
                  color: color,
                ),
                SizedBox(width: 4),
                Text('$value',style: TextStyle(color: color),)
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
