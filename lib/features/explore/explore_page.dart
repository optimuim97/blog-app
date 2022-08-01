import 'package:blogapp/features/entity/view/entity_page.dart';
import 'package:blogapp/features/post/post_page/post_tabview_item.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  bottom: const TabBar(
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.black,
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    indicatorColor: Colors.blue,
                    tabs: [
                      Tab(
                        text: 'Derniers postes',
                      ),
                      Tab(
                        text: 'Pages',
                      ),
                    ],
                  ),
                  backgroundColor: Colors.white,
                ),
                body: TabBarView(
                  physics: BouncingScrollPhysics(),
                  dragStartBehavior: DragStartBehavior.down,
                  children: [PostListItem(), EntityPage()],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
