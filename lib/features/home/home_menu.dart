
import 'package:blogapp/features/explore/explore_page.dart';
import 'package:blogapp/features/post/post_edit/view/post_edit_page.dart';
import 'package:blogapp/features/post/post_page/post_page.dart';
import 'package:blogapp/features/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:moony_nav_bar/moony_nav_bar.dart';
// import 'package:story/features/home/home_screen_page.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({Key? key}) : super(key: key);

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  final Widget _screen1 = const HomePostPage();
  final Widget _screen2 = const ExplorePage();
  // final Widget _screen3 = const PostEditPage(
  //   btnTitle: 'Poster',
  //   post: null,
  // );
  // final Widget _screen4 = const HomePostPage();
  final Widget _screen5 = const ProfilePage();
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.lightBlue.shade50,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  )),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => PostEditPage(
                                  btnTitle: 'Poster',
                                  post: null,
                                )),
                        (route) => false);
                  },
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: Colors.blue,
                  )),
            ),
          )
        ],
        title: Text(
          'Logo',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: getBody(),
      bottomNavigationBar: MoonyNavigationBar(
        items: <NavigationBarItem>[
          NavigationBarItem(
              icon: Icons.widgets_outlined,
              color: Colors.blue,
              onTap: () {
                onTapHandler(0);
              }),
          NavigationBarItem(
              icon: Icons.explore,
              activeIcon: Icons.explore,
              color: Colors.blue,
              indicatorColor: Colors.blue,
              onTap: () {
                onTapHandler(1);
              }),
          // NavigationBarItem(
          //     icon: Icons.shopping_bag_outlined,
          //     color: Colors.blue,
          //     onTap: () {
          //       onTapHandler(3);
          //     }),
          NavigationBarItem(
              icon: Icons.person_outline,
              color: Colors.blue,
              onTap: () {
                onTapHandler(4);
              })
        ],
        style: MoonyNavStyle(
          activeColor: Colors.blue,
          indicatorPosition: IndicatorPosition.TOP,
          indicatorType: IndicatorType.POINT,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget getBody() {
    if (selectedIndex == 0) {
      return _screen1;
    } else if (selectedIndex == 1) {
      return _screen2;
      // } else if (selectedIndex == 2) {
      //   return _screen3;}
    }
    // } else if (selectedIndex == 2) {
    //   return _screen4;
    // }
    return _screen5;
  }

  void onTapHandler(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
