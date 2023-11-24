import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/login&signup/loginpage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_app/Pages/userslist.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      InkWell(
        onTap: () {
          GoogleSignIn().signOut().then((value) {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login(),), (route) => false);
          });
        },
        child: Center(
          child: Container(
            width:w/10 ,
            height: h/10,
            color: Colors.lightGreenAccent,
            child: Icon(Icons.logout),
          ),
        ),
      ),
    );
  }
}

