import 'package:flutter/material.dart';
import 'package:my_app/Pages/followers.dart';
import 'package:my_app/Pages/following.dart';

import 'followerslist.dart';

class Followinglist extends StatefulWidget {
  const Followinglist({super.key});

  @override
  State<Followinglist> createState() => _FollowinglistState();
}

class _FollowinglistState extends State<Followinglist>
  with SingleTickerProviderStateMixin {
  late TabController _tabController;

  void initState() {
  _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
  // TODO: implement initState
  super.initState();
  _tabController.addListener(() {
  setState(() {});
  });
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: TabBar(
            controller: _tabController,
            labelColor:Colors.red ,
            unselectedLabelColor: Colors.black,
            tabs: [
              Tab(
                child: Text("Followers",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
              ),
              Tab(
                child: Text("Following",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            followers(),
            Following(),
          ],
        ),
      ),
    );
  }
}
