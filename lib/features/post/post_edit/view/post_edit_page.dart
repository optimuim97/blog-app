import 'dart:developer';
import 'dart:io';


import 'package:blogapp/constant.dart';
import 'package:blogapp/features/home/home_menu.dart';
import 'package:blogapp/features/post/post_edit/logic/post_edit_cubit.dart';

import 'package:blogapp/features/widget/html_editor.dart';
import 'package:blogapp/models/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class PostEditPage extends StatefulWidget {
  const PostEditPage({Key? key, required this.post, required this.btnTitle})
      : super(key: key);
  final Post? post;
  final String btnTitle;
  @override
  State<PostEditPage> createState() => _PostEditPageState();
}

class _PostEditPageState extends State<PostEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _txtControllerBody = TextEditingController();
  final TextEditingController _txtControllerTitle = TextEditingController();

  HtmlEditorController controller = HtmlEditorController();
 
  File? _imageFile;
  final _picker = ImagePicker();
  String message = '';

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
    if (widget.post != null) {
      _txtControllerTitle.text = widget.post!.title ?? '';
      _txtControllerBody.text = widget.post!.description ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Editeur',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_sharp,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => HomeMenu()),
                (route) => false);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: ListView(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextfieldTitle(),
                    // Padding(
                    //   padding: EdgeInsets.all(8),
                    //   child: TextFormField(
                    //     controller: _txtControllerBody,
                    //     keyboardType: TextInputType.multiline,
                    //     minLines: 1, //Normal textInputField will be displayed

                    //     maxLines: 9,
                    //     validator: (val) =>
                    //         val!.isEmpty ? 'Champ requit' : null,
                    //     decoration: InputDecoration(
                    //       hintText: "Description de la publication ...",
                    //       focusedBorder: OutlineInputBorder(
                    //           borderSide:
                    //               BorderSide(width: 0, color: Colors.white)),
                    //       border: OutlineInputBorder(
                    //           borderSide:
                    //               BorderSide(width: 0, color: Colors.white)),
                    //       enabledBorder: OutlineInputBorder(
                    //           borderSide:
                    //               BorderSide(width: 0, color: Colors.white)),
                    //     ),
                    //   ),
                    // ),
                    widget.post != null
                        ? SizedBox()
                        : _buildImage(context),
                    widget.post != null
                        ? SizedBox()
                        : _buildBtnAddImage(),

                    htmlEditorPage(controller: controller, desc:widget.post!.description),
                  ],
                ),
              ),
              _buildBlocOfBtnValidate(),
              _buildBtnValidate(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextfieldTitle() {
    return Padding(
                    padding: EdgeInsets.all(8),
                    child: TextFormField(
                      controller: _txtControllerTitle,
                      keyboardType: TextInputType.multiline,
                      minLines: 1, //Normal textInputField will be displayed

                      maxLines: 9,
                      validator: (val) =>
                          val!.isEmpty ? 'Champ requit' : null,
                      decoration: InputDecoration(
                        hintText: "Titre de la publication ...",
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0, color: Colors.white)),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0, color: Colors.white)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0, color: Colors.white)),
                      ),
                    ),
                  );
  }

  Widget _buildBtnAddImage() {
    return GestureDetector(
                          onTap: () {
                            getImage();
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Icon(
                                      _imageFile == null
                                          ? Icons.add_a_photo
                                          : Icons.edit,
                                      size: 25,
                                      color: Colors.green)),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  _imageFile == null
                                      ? 'ajoutez une photos de decouverture'
                                      : 'modifier la photo de decouverture',
                                  style: TextStyle(color: Colors.black),
                                ),
                              )
                            ],
                          ),
                        );
  }

  Widget _buildImage(BuildContext context) {
    return Container(
                          width: MediaQuery.of(context).size.width,
                          height: _imageFile == null ? 40 : 200,
                          decoration: BoxDecoration(
                              image: _imageFile == null
                                  ? null
                                  : DecorationImage(
                                      image:
                                          FileImage(_imageFile ?? File('')),
                                      fit: BoxFit.cover)),
                        );
  }

  BlocConsumer<PostEditCubit, PostEditState> _buildBlocOfBtnValidate() {
    return BlocConsumer<PostEditCubit, PostEditState>(
        listener: (context, state) {
      print(state.toString());
      if (state is PostEditStateSucces) {
        print('ok');
        // context.read<PostCubit>().postFetch();
        //      Navigator.of(context).pushAndRemoveUntil(
        // MaterialPageRoute(builder: (context) => HomeMenu()),
        // (route) => false);
      }
      if (state is PostEditStateFailed) {
        print('ok');
        // context.read<PostCubit>().postFetch();
        //      Navigator.of(context).pushAndRemoveUntil(
        // MaterialPageRoute(builder: (context) => HomeMenu()),
        // (route) => false);
      }
    }, builder: (context, state) {
      if (state is PostEditStateLoading) {
        return Center(child: CircularProgressIndicator());
      }
      if (state is PostEditStateSucces) {
        message = state.message;
        print(message.toString());
      }
      if (state is PostEditStateFailed) {
        message = state.message;
        print(message.toString());
      }
      if (state is PostEditStateError) {
        message = state.message;
        print(message.toString());
      }
      return Center(child: Container());
    });
  }

  Widget _buildBtnValidate(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: kTextButton(widget.btnTitle, () async {
        if (_formKey.currentState!.validate()) {
          if (widget.post == null) {
            String txt = await controller.getText();
            // _createPost();
            log(txt);
            context
                .read<PostEditCubit>()
                .createPost(_txtControllerTitle.text, txt, _imageFile);
          } else {
            String txt = await controller.getText();
            context
                .read<PostEditCubit>()
                .editPost(widget.post!.id ?? 0, _txtControllerTitle.text, txt);
          }
        }
      }),
    );
  }
}
