import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Model/profilemodel.dart';
import 'package:my_app/Pages/userslist.dart';

import '../widget/authentication.dart';
import '../widget/firebaseconstands.dart';

class followers extends StatefulWidget {
  const followers({super.key});

  @override
  State<followers> createState() => _followersState();
}

class _followersState extends State<followers> {

  var nam;

  TextEditingController search = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth.follower();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: SafeArea(
      //   child: Drawer(
      //     backgroundColor: Colors.white,
      //     child: ListView(
      //       children: [
      //         DrawerHeader(
      //             child: Column(
      //               children: [
      //                 Row(
      //                   mainAxisAlignment: MainAxisAlignment.end,
      //                   children: [
      //                     Icon(Icons.logout),
      //                   ],
      //                 ),
      //                 Row(
      //                   mainAxisAlignment: MainAxisAlignment.start,
      //                   children: [
      //                     CircleAvatar(
      //                       radius: 50,
      //                     ),
      //                     SizedBox(
      //                       width: w / 7,
      //                     ),
      //                     Text('Profile')
      //                   ],
      //                 ),
      //               ],
      //             )),
      //         ListTile(
      //           leading: Icon(Icons.person_add_sharp),
      //           title: Text("Followers"),
      //           onTap: () {
      //             Navigator.pop(context);
      //             Navigator.push(context,
      //                 MaterialPageRoute(builder: (context) => followers()));
      //           },
      //         ),
      //         ListTile(
      //           leading: Icon(Icons.person_add_sharp),
      //           title: Text("Following"),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
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
                        child: TextFormField(
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

                    )),
              ),

            ///To get followers list

              StreamBuilder<List<Pfmodels>>(
                  stream: auth.follower(),
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

                              ///To avoid null check
                              for(int i=0;i<data!.length;i++){


                                if(data[i].id==FirebaseAuth.instance.currentUser!.uid){
                                      nam=i;
                                  break;
                                }
                              print(nam);

                              }
                     ///To check my id contains on their followerslist
                              bool follow =
                              data[index].followers.contains(FirebaseAuth.instance.currentUser!.uid);

                              // if(data[nam].followers.contains(data[index].id)){
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

                                              ///To delete my id from followewrslist
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
                                              } else {

                                                ///otherwise insert myid to followerslist

                                                data[index].reference!.update({
                                                  "followers":
                                                  FieldValue.arrayUnion(
                                                      [myid])
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
                              // }else{
                              //   return
                              //     Container();
                              // }
                            }),
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
