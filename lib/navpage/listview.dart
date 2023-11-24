import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widget/authentication.dart';
import '../Model/profilemodel.dart';
import '../Pages/userslist.dart';

class Userview extends StatefulWidget {
  const Userview({super.key});

  @override
  State<Userview> createState() => _UserviewState();
}

class _UserviewState extends State<Userview> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
    );
  }
}
