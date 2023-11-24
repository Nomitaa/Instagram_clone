import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Model/profilemodel.dart';
import 'package:my_app/Pages/userslist.dart';

import '../widget/authentication.dart';
import '../widget/firebaseconstands.dart';
import 'followers.dart';

// var myid=FirebaseAuth.instance.currentUser!.uid;
class Following extends StatefulWidget {
  const Following({super.key});

  @override
  State<Following> createState() => _FollowingState();
}
class _FollowingState extends State<Following> {
  bool follow=true;
  TextEditingController Search=TextEditingController();
  Authentication auth =Authentication();
  void textfield(){
    Search.clear();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,top: 20),
        child: Column(
          children: [
            Container(
                height: h / 15,
                child: Center(
                  child: TextFormField(
                    controller: Search,
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
            ),
            // SizedBox(
            //   height: h/5,
            // ),
            StreamBuilder(
                stream: auth.following(),
                builder: (context, snapshot) {

                  if (!snapshot.hasData) {
                    return CircularProgressIndicator(

                    );
                  }
                  print(snapshot.error);
                  var data = snapshot.data;

                  return Expanded(
                    child: Container(
                      // height: h/10,
                      child: ListView.builder(
                        itemCount: data?.length,
                        itemBuilder: (context, index) {
                          if (Search.text.isEmpty) {
                            return Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                height: h/10,
                                decoration: BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  leading: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("${index + 1} . "),
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            data![index].profile.toString()),
                                      ),
                                    ],
                                  ),
                                  title: Text(data![index].name.toString()),
                                  subtitle: Text(
                                    data![index].email.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  trailing: ElevatedButton(
                                    onPressed: () {
                                      if (data[index].followers.contains(myid)) {

                                        ///removing my id from users followers list

                                        FirebaseFirestore.instance
                                            .collection(Constants.fc)
                                            .doc(data[index].id)
                                            .update({
                                          "followers":
                                          FieldValue.arrayRemove([myid])
                                        });

                                      } else {

                                        FirebaseFirestore.instance
                                            .collection(Constants.fc)
                                            .doc(data[index].id)
                                            .update({
                                          "followers":
                                          FieldValue.arrayUnion([myid])
                                        });

                                      }
                                    },
                                    child: data[index].followers!.contains(myid)
                                        ? Text('Unfollow')
                                        : Text('Follow'),
                                  ),
                                ),
                              ),
                            );
                          } else if (data![index]
                              .name!
                              .toLowerCase()
                              .toString()
                              .contains(Search.text.toLowerCase())) {
                            return Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                height: h/10,
                                decoration: BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  leading: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("${index + 1} . "),
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            data![index].profile.toString()),
                                      ),
                                    ],
                                  ),
                                  title: Text(data![index].name.toString()),
                                  subtitle: Text(
                                    data![index].email.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  trailing: ElevatedButton(
                                    onPressed: () {
                                      follow = !follow;
                                    },
                                    child: follow
                                        ? Text('Follow')
                                        : Text('Unfollow'),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return SizedBox();
                          }
                        },
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
