import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/navpage/feed.dart';
import 'package:my_app/navpage/homeview.dart';
import 'package:my_app/navpage/myaccount.dart';
import 'package:my_app/navpage/Search.dart';
import '../Pages/userslist.dart';
import 'post.dart';
import 'listview.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  List page = [
    Feed(),
    PostView(),
    Imageupload(),
    Userview(),
    Myaccount()
  ];
  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        currentIndex: currentIndex,
        showSelectedLabels: false,
        onTap: onTap,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
         elevation: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'imageupload',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_call),
            label: 'person',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'myaccount',
          ),
        ],
      ),
    );
  }
}
