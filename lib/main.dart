import 'package:blogapp/features/auth/logic/auth_cubit_cubit.dart';
import 'package:blogapp/features/entity/logic/entity_cubit.dart';
import 'package:blogapp/features/post/post_comment/logic/post_comment_cubit.dart';
import 'package:blogapp/features/post/post_edit/logic/post_edit_cubit.dart';
import 'package:blogapp/features/post/post_page/logic/post_cubit.dart';
import 'package:blogapp/features/profile/logic/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/loading.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AuthCubit(),
      ),
      BlocProvider(
        create: (context) => PostCubit(),
      ),
      BlocProvider(create: (context) => EntityCubit()),
      BlocProvider(create: (context) => ProfileCubit()),
      BlocProvider(create: (context) => PostEditCubit()),
      BlocProvider(create: (context) => PostCommentCubit())
    ],
    child: App(),
  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // fontFamily: 'Aclonica',
        primaryColor: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Loading(),
    );
  }
}
