import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/profile/editprofile.dart';
import 'package:my_app/widget/firebaseconstands.dart';
import 'package:my_app/Pages/followers.dart';
import 'package:my_app/Pages/following.dart';
import 'package:my_app/login&signup/loginpage.dart';
import 'package:my_app/Model/profilemodel.dart';

import '../widget/authentication.dart';

var h;
var w;
Authentication auth = Authentication();

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  TextEditingController search = TextEditingController();
  Authentication _auth=Authentication();
  //bool follow=true;

  ///To get my data from firebase to profilemodel

  userpro() {

    FirebaseFirestore.instance
        .collection(Constants.fc)
        .doc(myid)
        .get()
        .then(
            (value) {
              if(value.exists){
                pfmodels = Pfmodels.fromJson(value.data()!);
              }


          if (mounted) {
            setState(() {});
          }
        });
  }
  // getmodel() async {
  //   pfmodels=await auth.getlogin(FirebaseAuth.instance.currentUser!.uid);
  // }

  @override
  void initState() {
    userpro();
    // getmodel();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        // actions: [
        //   IconButton(
        //       icon: Icon(
        //         Icons.logout_outlined,
        //         size: 20,
        //         color: Colors.redAccent,
        //       ),
        //       onPressed: () {
        //         auth.signOut(context);
        //       }),
        //   //SizedBox(width: 10,)
        // ],
        title: TextFormField(
          controller: search,
          onChanged: (value) {
            setState(() {});
          },
          autovalidateMode: AutovalidateMode.always,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            suffixIcon: Icon(CupertinoIcons.multiply),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: BorderSide(color: Colors.cyan)),
            hintText: 'Search Here.....',
          ),
        ),
      ),
      drawer: SafeArea(
        child: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            children: [
              DrawerHeader(
                  child: Column(
                    children: [
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //       InkWell(onTap:() {
                      //         Navigator.push(context, MaterialPageRoute(builder: (context) => Edit(),));
                      //       },
                      //           child: Text("Edit Profile")),
                      //     InkWell(
                      //       onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Edit(),)),
                      //         child: Icon(Icons.edit)),
                      //
                      //   ],
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     CircleAvatar(
                      //       backgroundImage: NetworkImage(pfmodels?.profile??''),
                      //       radius: 50,
                      //     ),
                      //     SizedBox(
                      //       width: w / 7,
                      //     ),
                      //     Text(pfmodels?.name??'')
                      //   ],
                      // ),
                    ],
                  )),
              // ListTile(
              //   leading: Icon(Icons.person_add_sharp),
              //   title: Text("Followers"),
              //   onTap: () {
              //     Navigator.pop(context);
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => followers()));
              //   },
              // ),
              // ListTile(
              //   leading: Icon(Icons.person_add_sharp),
              //   title: Text("Following"),
              //   onTap: () {
              //     Navigator.pop(context);
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => Following()));
              //   },
              // ),
              // ListTile(
              //   leading:  IconButton(
              //     icon: Icon(
              //       Icons.logout,
              //     ),
              //
              //     onPressed: () {
              //       Navigator.push(context, MaterialPageRoute(builder: (context) => Login(),));
              //       // do something
              //     },
              //   ),
              //   title: Text("Logout"),
              // )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: h,
          width: w,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                    height: h / 15,
                    child: Center(
                        child: Text(
                          'Users List',
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent),
                        ))),
              ),

          /// To get the users except me from firebase
              StreamBuilder<List<Pfmodels>>(
                  stream: auth.user(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Pfmodels>? data = snapshot.data;

                      return Container(
                        height: h / 1.5,
                        decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(10)),
                        child: ListView.builder(
                            itemCount: data!.length,
                            itemBuilder: (context, index) {
                              bool follow =
                              data[index].followers.contains(myid);
                              if(data[index].id!=myid){
                                if (search.text.isEmpty) {
                                  return Column(
                                    children: [
                                      Card(
                                        child: ListTile(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(10)),
                                          leading: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text("${index + 1}.  "),
                                              CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    data[index]
                                                        .profile
                                                        .toString()),
                                              )
                                            ],
                                          ),
                                          title: Text(
                                            data[index].name.toString(),
                                          ),
                                          subtitle: Text(
                                            data[index].email.toString(),
                                            style: TextStyle(fontSize: 11),
                                          ),
                                          trailing: InkWell(
                                            onTap: () async {

                                              /// ///To delete my id from followewrslist

                                              if (data[index]
                                                  .followers
                                                  .contains(myid)) {
                                                // data[index].followers.remove(user);
                                                // var upd=data[index].copyWith(followers: data[index].followers);
                                                data[index].reference!.update({
                                                  "followers":
                                                  FieldValue.arrayRemove(
                                                      [myid])
                                                });
                                                // pfmodels!.following.remove(data[index].id);
                                                // var myupd=pfmodels!.copyWith(following:pfmodels!.following);
                                                // FirebaseFirestore.instance.collection('user').doc(user).update()
                                              }

                                              ///otherwise insert myid to followerslist

                                              else {
                                                data[index]=await _auth.getlogin(data[index].id);

                                                data[index].reference!.update({
                                                  "followers":
                                                  FieldValue.arrayUnion(
                                                      [usernow])
                                                });
                                              }
                                            },
                                            child: Container(
                                              height: h / .5,
                                              width: w * 0.15,
                                              // color:Colors.greenAccent,
                                              child: Text(
                                                  follow ? 'unfollow' : 'follow'),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                } else if (data[index]
                                    .name
                                    .toLowerCase()
                                    .toString()
                                    .contains(search.text.toLowerCase())) {
                                  return Column(
                                    children: [
                                      Card(
                                        child: ListTile(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(10)),
                                          leading: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text("${index + 1}.  "),
                                              CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    data[index]
                                                        .profile
                                                        .toString()),
                                              )
                                            ],
                                          ),
                                          title:
                                          Text(data[index].name.toString()),
                                          subtitle:
                                          Text(data[index].email.toString()),
                                          trailing: ElevatedButton(
                                            onPressed: () {},
                                            child: Text('follow'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return SizedBox();
                                }
                              }else{
                                return
                                  Container();
                              }}),
                      );
                    } else {
                      return Container(
                        child: Text("error"),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
