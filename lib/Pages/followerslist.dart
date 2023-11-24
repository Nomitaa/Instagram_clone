import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


import 'followers.dart';
import 'following.dart';

String? currentUser = FirebaseAuth.instance.currentUser?.uid;

class Followerslist extends StatefulWidget {
  const Followerslist({super.key});

  @override
  State<Followerslist> createState() => _FollowerslistState();
}

class _FollowerslistState extends State<Followerslist>
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
            labelColor: Colors.red,
            unselectedLabelColor: Colors.black,
            tabs: [
              Tab(
                child: Text(
                  "Followers",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Tab(
                child: Text(
                  "Following",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
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
