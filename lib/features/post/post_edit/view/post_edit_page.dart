import 'dart:io';

import 'package:blogapp/constant.dart';
import 'package:blogapp/features/post/post_edit/logic/post_edit_cubit.dart';
import 'package:blogapp/models/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

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
  bool _loading = false;
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
      _txtControllerBody.text = widget.post!.description ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_sharp,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
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
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: TextFormField(
                    controller: _txtControllerBody,
                    keyboardType: TextInputType.multiline,
                    minLines: 1, //Normal textInputField will be displayed

                    maxLines: 9,
                    validator: (val) => val!.isEmpty ? 'Champ requit' : null,
                    decoration: InputDecoration(
                        hintText: "Description de la publication ...",
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
                ),
              ),
              widget.post != null
                  ? SizedBox()
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      height: _imageFile == null ? 40 :  MediaQuery.of(context).size.height * 0.5,
                      decoration: BoxDecoration(
                          image: _imageFile == null
                              ? null
                              : DecorationImage(
                                  image: FileImage(_imageFile ?? File('')),
                                  fit: BoxFit.cover)),
                    ),
            widget.post != null
                  ? SizedBox()
                  :    Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.image, size: 30, color: Colors.black38),
                    onPressed: () {
                      getImage();
                    },
                  ),Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text('photos'),
                  )
                ],
              ),
              BlocConsumer<PostEditCubit, PostEditState>(
                  listener: (context, state) {
                print(state.toString());
                if (state is PostEditStateSucces) {
                  print('ok');
                  return Navigator.pop(context);
                }
                if (state is PostEditStateFailed) {
                  print('ok');
                  return Navigator.pop(context);
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
                return Center(
                  child:Container()
                  //  Text(
                  //   message,
                  //   style: TextStyle(color: Colors.black),
                  // ),
                );
              }),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: kTextButton(widget.btnTitle, () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _loading = !_loading;
                    });
                    if (widget.post == null) {
                      // _createPost();
                      context
                          .read<PostEditCubit>()
                          .createPost(_txtControllerBody.text, _imageFile);
                    } else {
                      context.read<PostEditCubit>().editPost(
                          widget.post!.id ?? 0, _txtControllerBody.text);
                      // _editPost(widget.post!.id ?? 0);
                    }
                  }
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
