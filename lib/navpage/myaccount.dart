import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_app/widget/authentication.dart';
import 'package:my_app/profile/editprofile.dart';
import 'package:my_app/widget/firebaseconstands.dart';

import 'package:my_app/Pages/followers.dart';
import 'package:my_app/Pages/following.dart';
import 'package:my_app/Model/profilemodel.dart';

import '../Model/postmodel.dart';
import '../Pages/followerslist.dart';
import '../Pages/followinglist.dart';
import '../Pages/userslist.dart';

class Myaccount extends StatefulWidget {
  const Myaccount({super.key});

  @override
  State<Myaccount> createState() => _MyaccountState();
}

class _MyaccountState extends State<Myaccount> {
  String _value = "one";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        ///dropdownmenu

        title: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _value,
            items: [
              DropdownMenuItem(
                child: Row(
                  children: [
                    Icon(
                      Icons.lock_outline,
                      color: Colors.black,
                      size: 20,
                    ),
                    Text(
                      pfmodels!.name.toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                value: 'one',
              ),
            ],
            onChanged: (_value) {},
          ),
        ),
        actions: [
          // IconButton(
          //   icon: Icon(
          //     Icons.logout,
          //     color: Colors.black,
          //   ),
          //   onPressed: () {
          //     // do something
          //   },
          // ),
          Icon(
            Icons.add_box_outlined,
            color: Colors.black,
          ),
          SizedBox(
            width: w / 12,
          ),
          InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: h / 2,
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            auth.signOut(context);
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: Icon(
                                  Icons.logout,
                                  color: Colors.black,
                                ),
                                title: Text("Signout"),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
              child: Icon(
                Icons.menu,
                color: Colors.black,
              ))
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: Padding(
          padding: const EdgeInsets.only(right: 18, left: 18),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: h / 7,
                  width: w,
                  // color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(pfmodels!.profile.toString()),
                        radius: h * 0.06,
                      ),
                      Container(
                        width: w / 6,
                        height: h / 12,
                        // color: Colors.blue,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "10",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: h / 40),
                            ),
                            Text(
                              "Post",
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Followerslist()));
                        },
                        child: Container(
                          width: w / 6,
                          height: h / 12,
                          // color: Colors.blue,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${pfmodels!.followers.length}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: h / 40),
                              ),
                              Text(
                                "Follower",
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Followinglist()));
                        },
                        child: Container(
                          width: w / 6,
                          height: h / 12,
                          // color: Colors.blue,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${pfmodels!.following.length}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: h / 40),
                              ),
                              Text("Following"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Namitha"),
                      Text(
                        "5259258928952582589289",
                        style: TextStyle(fontSize: h / 90),
                      ),
                      Text("namithac2002@gmail.com"),
                      Text("628238790"),
                    ],
                  ),
                  height: h / 11,
                  width: w,
                  // color: Colors.green,
                ),
                SizedBox(
                  height: h / 90,
                ),
                Container(
                  height: h / 20,
                  width: w,
                  // color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Edit()));
                        },
                        child: Container(
                          height: h / 21,
                          width: w / 3,
                          child: Center(child: Text("Edit Profile")),
                          decoration: BoxDecoration(
                              // border: Border.all(color: Colors.black),
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(h / 70)),
                        ),
                      ),
                      Container(
                        height: h / 21,
                        width: w / 3,
                        child: Center(child: Text("Share Profile")),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(h / 70)),
                      ),
                      Container(
                        height: h / 21,
                        width: w / 7,
                        child: Center(
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.person_add_sharp),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(h / 70)),
                      ),
                    ],
                  ),
                ),

                ///tab bar

                TabBar(
                  unselectedLabelColor: Colors.black,
                    labelColor: Colors.blue,
                    tabs: [
                  Tab(
                    child: Icon(Icons.grid_on,color: Colors.black,),
                ),
                Tab(
                  child: Icon(Icons.person,color: Colors.black,),
                )
                ]),
                SizedBox(
                  height: h / 90,
                ),
                Container(
                  height: h / 11,
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: h / 25,
                        backgroundColor: Colors.grey.shade100,
                        child: Center(
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: h / 1,
                  width: w,

                  ///To get details my  details

                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection(Constants.fc)
                        .doc(myid)
                        .collection('posts')
                        .snapshots()
                        .map((event) => event.docs
                        .map((e) => PostClass.fromJson(e.data()))
                        .toList()),
                    builder: (context, snapshot) {
                      var data = snapshot.data;
                      return GridView.builder(
                          itemCount: data?.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              child: Image(
                                image: NetworkImage(data?[index].post??''),
                                fit: BoxFit.contain,
                              ),
                            );
                          });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
