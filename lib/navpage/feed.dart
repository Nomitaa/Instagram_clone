import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Pages/message.dart';
import 'package:my_app/widget/firebaseconstands.dart';
import 'package:my_app/navpage/myaccount.dart';
import 'package:my_app/Model/profilemodel.dart';
import 'package:my_app/Pages/userslist.dart';
import '../widget/authentication.dart';
import 'Util/Userpost.dart';
import 'Util/stories.dart';

class Feed extends StatefulWidget {

  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {

  ///to get images from profilemodels

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


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Instagram",style: TextStyle(color: Colors.black),),
                Row(
                  children: [
                   // Icon(Icons.add,),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Icon(Icons.favorite_outline,color: Colors.black,),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Message(),));
                      },
                        child: Icon(CupertinoIcons.paperplane,color: Colors.black,)),
                  ],
                ),
              ],),),

        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 100,
                color: Colors.white,
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      // color: Colors.green,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height:60 ,
                              width:60,
                              decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.grey[400],),),
                          ),
                          Text("Namitha",style: TextStyle(color: Colors.black),)
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 8,
                        itemBuilder: (context, index) {
                        return Storyview(text: '',);
                      },),
                    ),
                  ],
                ),
              ),
              // Userpost(),

              // StreamBuilder<List<PostClass>>(
              //   stream: FirebaseFirestore.instance.collectionGroup(PostConst.pc).snapshots().map((event) => event.docs.map((e) => PostClass.fromJson(e.data())).toList()),
              //   builder: (context,snapshot){
              //     if(snapshot.hasData)
              //       {
              //         List<PostClass>?data=snapshot.data;
              //         return Container(
              //           height: h*0.9,
              //           width: w,
              //           color:Colors.blue,
              //           child: ListView.builder(
              //               itemCount:data?.length,
              //               itemBuilder:(context,index){
              //                 var users=data![index];
              //                 return  StreamBuilder<Pfmodels>(
              //                     stream: FirebaseFirestore.instance.collection(Constants.fc).doc(data[index].id).snapshots().map((event) =>Pfmodels.fromJson(event.data()!)),
              //                     builder:(context ,snapshot){
              //                       Pfmodels?  pdata=snapshot.data;
              //                       return Padding(
              //                         padding: const EdgeInsets.only(bottom: 5),
              //                         child: Container(
              //
              //                           width: w * .6,
              //                           decoration: BoxDecoration(
              //                               color: Colors.white,doc
              //                               borderRadius: BorderRadius.circular(0)),
              //                           child: Column(
              //                             children: [
              //
              //                               Row(
              //                                 mainAxisAlignment:
              //                                 MainAxisAlignment.start,
              //                                 children: [
              //                                   SizedBox(
              //                                     width: w * .05,
              //                                   ),
              //                                   InkWell(onTap: (){
              //                                     if(pdata!.id.contains(myid)) {
              //                                       Navigator.push(
              //                                           context,
              //                                           MaterialPageRoute(
              //                                               builder: (context) =>
              //                                                   Myaccount()));
              //                                     }else{
              //                                       // Navigator.push(
              //                                       //     context,
              //                                       //     MaterialPageRoute(
              //                                       //         builder: (context) =>
              //                                       //             userprof(data: pdata)));
              //                                     }
              //                                   },
              //                                     child: CircleAvatar(
              //                                       backgroundImage: NetworkImage(
              //                                           pdata
              //                                               ?.profile
              //                                               .toString()??''),
              //                                     ),
              //                                   ),
              //                                   SizedBox(
              //                                     width: w * .05,
              //                                   ),
              //                                   Container(
              //                                     height: h * 0.1,
              //                                     width: w * 0.6,
              //                                     child: Column(
              //                                       mainAxisAlignment:
              //                                       MainAxisAlignment.center,
              //                                       crossAxisAlignment:
              //                                       CrossAxisAlignment.start,
              //                                       children: [
              //                                         Text(
              //                                             pdata?.name
              //                                                 .toString()??'',
              //                                             style: TextStyle(
              //                                                 fontSize: 14,
              //                                                 )),
              //                                         SizedBox(
              //                                           height: 10,
              //                                         ),
              //                                       ],
              //                                     ),
              //                                   ),
              //                                 ],
              //                               ),
              //                               InkWell(
              //                                 onDoubleTap:() {
              //
              //                                 },
              //                                 child: Container(
              //                                   height: h * .5,
              //                                   width: w,
              //                                   color: Colors.transparent,
              //                                   child: Image(
              //                                     image: NetworkImage(
              //                                         data[index].post??""),
              //                                   ),
              //                                 ),
              //                               ),
              //                               Row(
              //                                 children: [
              //
              //                                   InkWell(
              //                                       onTap:(
              //                                           ) {
              //                                         data[index].likes.contains(myid) ?
              //                                         FirebaseFirestore.instance.collection(Constants.fc).doc(pdata?.id).collection(PostConst.pc).doc(data[index].postId).
              //                                         update({'likes':FieldValue.arrayRemove([myid])}):
              //                                         FirebaseFirestore.instance.collection(Constants.fc).doc(pdata?.id).collection(PostConst.pc).doc(data[index].postId).
              //                                         update({'likes':FieldValue.arrayUnion([myid])});
              //
              //                                       },
              //                                       child: data[index].likes.contains(myid)
              //                                           ? Icon(Icons.favorite,):Icon(Icons.favorite_border_rounded)
              //                                   ),
              //                                   IconButton(
              //                                     onPressed: () {},
              //                                     icon: Icon(
              //                                         Icons.comment),
              //                                   ),
              //                                   IconButton(
              //                                     onPressed: () {},
              //                                     icon: Icon(
              //                                         CupertinoIcons.paperplane),
              //
              //                                   ),
              //                                   SizedBox(width: w*.45,),
              //                                   IconButton(
              //                                     onPressed: () {},
              //                                     icon: Icon(
              //                                         CupertinoIcons.bookmark),
              //                                   )
              //                                 ],
              //                               )
              //                             ],
              //                           ),
              //                         ),
              //                       );
              //                     } );
              //               }),
              //         );
              //       }
              //     else{
              //       return Container();
              //
              //     }
              //   },
              // ),
           Userpost()
            ],
          ),
        ),
      ),
        );
  }
}
