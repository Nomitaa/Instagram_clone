import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/widget/authentication.dart';
import 'package:my_app/login&signup/loginpage.dart';
import 'package:my_app/navpage/screens.dart';
import 'package:my_app/Model/profilemodel.dart';
import 'package:my_app/Pages/userslist.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  Authentication obj=Authentication();

  ///To get my details from firebase to profilemodels

  getmodel() async {
    pfmodels=await obj.getlogin(FirebaseAuth.instance.currentUser!.uid);
  }

  ///keep me loggedin()

  getMethod(){
  SharedPreferences.getInstance().then((value){
    if(value.containsKey("uid")){
      myid=value.getString('uid');
      usernow=value.getString('uid');
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const Mainpage()), (route) => false);
    }
    else{
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const Login()), (route) => false);
    }
  });
  }
  @override
  void initState() {
   Future.delayed(const Duration(seconds: 3),(){
     getMethod();
   });
    super.initState();
    getmodel();
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: Center(
          child: CircularProgressIndicator(

          ),
        ),
      ),
    );
  }
}
