import 'package:flutter/material.dart';
import 'package:news_app/screens/news_feed_page.dart';
import 'package:news_app/screens/bookmarks_page.dart';

class HomePage extends StatelessWidget {
   final VoidCallback toggleTheme;
  const HomePage({super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, 
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
            icon: Icon(Icons.brightness_6,color: Colors.white,),
            onPressed: toggleTheme,
          ),
          ],
          title: const Text('News App',style:TextStyle(color: Colors.black),),
          backgroundColor: Colors.grey.withOpacity(.7),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.article,color: Colors.black,), text: 'News'),
              Tab(icon: Icon(Icons.bookmark,color: Colors.black,), text: 'Bookmarks'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            NewsFeedPage(),
            BookmarksPage(),
          ],
        ),
      ),
    );
  }
}
