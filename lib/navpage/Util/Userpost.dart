import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Model/profilemodel.dart';

import '../../Model/commentModel.dart';
import '../../Model/postmodel.dart';
import '../../Pages/userslist.dart';
import '../../widget/authentication.dart';
import '../../widget/firebaseconstands.dart';
import '../myaccount.dart';

class Userpost extends StatefulWidget {
  const Userpost({super.key});

  @override
  State<Userpost> createState() => _UserpostState();
}

class _UserpostState extends State<Userpost> {
  TextEditingController cmt = TextEditingController();

  ///to get our data from profilemodel

  userpro() {
    FirebaseFirestore.instance
        .collection(Constants.fc)
        .doc(myid)
        .snapshots()
        .listen((event) {
      pfmodels = Pfmodels.fromJson(event.data()!);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userpro();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    userpro();
    cmt.dispose();
  }

  @override

  ///to get subcollections(post nd etc) including me

  Widget build(BuildContext context) {
    return StreamBuilder<List<PostClass>>(
      stream: FirebaseFirestore.instance
          .collectionGroup(PostConst.pc)
          .snapshots()
          .map((event) =>
              event.docs.map((e) => PostClass.fromJson(e.data())).toList()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<PostClass>? data = snapshot.data;
          return Container(
            height: h * 0.7,
            width: w,
            color: Colors.white,
            child: ListView.builder(
                itemCount: data?.length,
                itemBuilder: (context, index) {
                  var users = data![index];

                  ///To get all users including me

                  return StreamBuilder<Pfmodels>(
                      stream: FirebaseFirestore.instance
                          .collection(Constants.fc)
                          .doc(data[index].id)
                          .snapshots()
                          .map((event) => Pfmodels.fromJson(event.data()!)),
                      builder: (context, snapshot) {
                        Pfmodels? pdata = snapshot.data;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Container(
                            width: w * .6,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(0)),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: w * .05,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if (pdata!.id.contains(myid)) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Myaccount()));
                                        } else {
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             userprof(data: pdata)));
                                        }
                                      },
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            pdata?.profile.toString() ?? ''),
                                      ),
                                    ),
                                    SizedBox(
                                      width: w * .05,
                                    ),
                                    Container(
                                      height: h * 0.1,
                                      width: w * 0.6,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(pdata?.name.toString() ?? '',
                                              style: TextStyle(
                                                fontSize: 14,
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                ///double tap like

                                InkWell(
                                  onDoubleTap: () {
                                    data[index].likes.contains(myid)
                                        ? FirebaseFirestore.instance
                                            .collection(Constants.fc)
                                            .doc(pdata?.id)
                                            .collection(PostConst.pc)
                                            .doc(data[index].postId)
                                            .update({
                                            'likes':
                                                FieldValue.arrayRemove([myid])
                                          })
                                        : FirebaseFirestore.instance
                                            .collection(Constants.fc)
                                            .doc(pdata?.id)
                                            .collection(PostConst.pc)
                                            .doc(data[index].postId)
                                            .update({
                                            'likes':
                                                FieldValue.arrayUnion([myid])
                                          });
                                  },
                                  child: Container(
                                    height: h * .5,
                                    width: w,
                                    color: Colors.transparent,
                                    child: Image(
                                      image:
                                          NetworkImage(data[index].post ?? ""),
                                    ),
                                  ),
                                ),

                                ///like

                                Row(
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          data[index].likes.contains(myid)
                                              ? FirebaseFirestore.instance
                                                  .collection(Constants.fc)
                                                  .doc(pdata?.id)
                                                  .collection(PostConst.pc)
                                                  .doc(data[index].postId)
                                                  .update({
                                                  'likes':
                                                      FieldValue.arrayRemove(
                                                          [myid])
                                                })
                                              : FirebaseFirestore.instance
                                                  .collection(Constants.fc)
                                                  .doc(pdata?.id)
                                                  .collection(PostConst.pc)
                                                  .doc(data[index].postId)
                                                  .update({
                                                  'likes':
                                                      FieldValue.arrayUnion(
                                                          [myid])
                                                });
                                        },
                                        child: data[index].likes.contains(myid)
                                            ? Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                              )
                                            : Icon(
                                                Icons.favorite_border_rounded)),

                                    ///comment
                                    IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                            showDragHandle: true,
                                            isScrollControlled: true,
                                            enableDrag: true,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            30))),
                                            context: context,
                                            builder: (context) {
                                              return Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    alignment: Alignment.center,
                                                    height: h * 0.05,
                                                    child: Text(
                                                      'Comments',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FontStyle.italic),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: h * 0.4355,
                                                    child: Column(
                                                      children: [
                                                        /// to get the (comment) subcollection of particular post

                                                        StreamBuilder(
                                                            stream: FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    Constants
                                                                        .fc)
                                                                .doc(pdata?.id)
                                                                .collection(
                                                                    PostConst
                                                                        .pc)
                                                                .doc(data[index]
                                                                    .postId)
                                                                .collection(
                                                                    CommentId
                                                                        .cmnt)
                                                                .snapshots()
                                                                .map((event) => event
                                                                    .docs
                                                                    .map((e) =>
                                                                        Comment_model.fromJson(e
                                                                            .data()))
                                                                    .toList()),
                                                            builder: (context,
                                                                snapshot) {
                                                              if (!snapshot
                                                                  .hasData) {
                                                                return CircularProgressIndicator();
                                                              }
                                                              List<Comment_model>?
                                                                  usrcmnt =
                                                                  snapshot.data;
                                                              return Container(
                                                                height:
                                                                    h * 0.43,
                                                                width: w,
                                                                child: ListView
                                                                    .builder(
                                                                  itemCount:
                                                                      usrcmnt
                                                                          ?.length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {

                                                                    ///To shown the details of the users

                                                                    return StreamBuilder<
                                                                            List<
                                                                                Pfmodels>>(
                                                                        stream: FirebaseFirestore
                                                                            .instance
                                                                            .collection(Constants
                                                                                .fc)
                                                                            .where('id',
                                                                            /// this id is the users id
                                                                            /// here we checkthe id of the user in the subcollection of comment if it matches then the details of that user will be taken

                                                                                isEqualTo: usrcmnt?[index].id)
                                                                            .snapshots()
                                                                            .map((event) => event.docs.map((e) => Pfmodels.fromJson(e.data())).toList()),
                                                                        builder: (context, snapshot) {
                                                                          List<Pfmodels>?
                                                                              profdata =
                                                                              snapshot.data;
                                                                          return ListTile(
                                                                            leading:
                                                                                CircleAvatar(
                                                                              backgroundImage: NetworkImage(profdata?[0].profile ?? ''),
                                                                            ),
                                                                            title:
                                                                                Column(
                                                                              children: [
                                                                                Text(profdata?[0].name ?? ''),
                                                                                Text(usrcmnt?[index].comment ?? ''),
                                                                              ],
                                                                            ),
                                                                            subtitle:
                                                                                Text("data"),
                                                                          );
                                                                        });
                                                                  },
                                                                ),
                                                              );
                                                            })
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        MediaQuery.of(context)
                                                            .viewInsets,
                                                    child: Container(
                                                      height: h * .06,
                                                      //width: w1*.9,
                                                      child: TextFormField(
                                                        controller: cmt,
                                                        decoration:
                                                            InputDecoration(
                                                                filled: true,
                                                                fillColor: Colors
                                                                    .white30,
                                                                //border: InputBorder.none,
                                                                border: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Colors
                                                                            .black),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20)),
                                                                //border: InputBorder.none,
                                                                hintText:
                                                                    'Add comment.....',
                                                                labelStyle: TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                                suffixIcon:
                                                                    IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    var a = Comment_model(
                                                                        comment: cmt
                                                                            .text,
                                                                        commentDate:
                                                                            Timestamp
                                                                                .now(),
                                                                        commentId:
                                                                            ' ',
                                                                        id: myid
                                                                            );
                                                                    FirebaseFirestore.instance.collection(Constants.fc).doc(pdata!.id)
                                                                        .collection(PostConst
                                                                            .pc)
                                                                        .doc(data[index]
                                                                            .postId)
                                                                        .collection(CommentId
                                                                            .cmnt)
                                                                        .add(a
                                                                            .toJson()).then(
                                                                            (value) async {
                                                                      comment_model = await auth.getcomment(
                                                                          pdata
                                                                              .id,
                                                                          data[index]
                                                                              .postId,
                                                                          value
                                                                              .id);
                                                                      var upddata =
                                                                          comment_model.copyWith(
                                                                              commentId: value.id);
                                                                      value.update(
                                                                          upddata
                                                                              .toJson());
                                                                    });
                                                                    cmt.clear();
                                                                    setState(
                                                                        () {});
                                                                  },
                                                                  icon: Icon(
                                                                      CupertinoIcons
                                                                          .paperplane),
                                                                )
                                                                // InkWell(
                                                                //   onTap: () {},
                                                                //   child: Text('Post',style: TextStyle(color: CupertinoColors.systemBlue,fontWeight: FontWeight.bold),),
                                                                // )
                                                                ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            });
                                      },
                                      icon: Icon(Icons.comment),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(CupertinoIcons.paperplane),
                                    ),
                                    SizedBox(
                                      width: w * .45,
                                    ),

                                    ///saved
                                    IconButton(
                                        onPressed: () {
                                          setState(() {});
                                          if (pfmodels.saved
                                              .contains(data[index].postId)) {
                                            FirebaseFirestore.instance
                                                .collection(Constants.fc)
                                                .doc(myid)
                                                .update({
                                              'saved': FieldValue.arrayRemove(
                                                  [data[index].postId])
                                            });
                                          } else {
                                            FirebaseFirestore.instance
                                                .collection(Constants.fc)
                                                .doc(myid)
                                                .update({
                                              'saved': FieldValue.arrayUnion(
                                                  [data[index].postId])
                                            });
                                          }
                                        },
                                        icon: pfmodels.saved
                                                .contains(data[index].postId)
                                            ? Icon(CupertinoIcons.bookmark_fill)
                                            : Icon(CupertinoIcons.bookmark))
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      });
                }),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
