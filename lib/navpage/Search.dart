import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Pages/userslist.dart';
import '../widget/authentication.dart';
import '../Model/profilemodel.dart';

class PostView extends StatefulWidget {
  const PostView({super.key});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  TextEditingController Search=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
       // leading: Icon(Icons.search),
        title:TextFormField(
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
        // leading: [
        //   Icon(Icons.search,color: Colors.black,),
        //
        //   // TextFormField(
        //   //   controller: Search,
        //   // )
        // ],
      ),
    );
  }
}
