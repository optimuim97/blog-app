
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';

// ignore: camel_case_types
class htmlEditor extends StatelessWidget {
  const htmlEditor({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HtmlEditorController controller;

  @override
  Widget build(BuildContext context) {
    return HtmlEditor(
        controller: controller, //required
        htmlEditorOptions: HtmlEditorOptions(
          hint: "Description de la publication",
          //initalText: "text content initial, if any",
        ),   
        otherOptions: OtherOptions(
          height: 200,
        ),
    );
  }
}
