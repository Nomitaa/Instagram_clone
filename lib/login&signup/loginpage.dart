import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_app/widget/authentication.dart';

import 'package:my_app/Pages/homePage.dart';
import 'package:my_app/login&signup/signup.dart';
import 'package:my_app/Pages/userslist.dart';



class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Authentication _auth = Authentication();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  FocusNode f1=FocusNode();
  FocusNode f2=FocusNode();
  bool pass = true;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: h / 5,
              ),
              Text(
                "Login",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              SizedBox(
                height: h / 20,
              ),
              // CircleAvatar(
              //   backgroundImage: AssetImage(
              //     "assets/images/img_3.png",
              //   ),
              //   radius: 70,
              //   backgroundColor: Colors.transparent,
              // ),
              SizedBox(
                height: h / 19,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  child: TextFormField(
                    focusNode: f1,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(f2);
                    },
                    autofocus: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _email,
                    onTap: (){
                      _password.clear();
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText: 'Email',
                        hintText: 'Enter valid name'),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  child: TextFormField(
                    focusNode: f2,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _password,
                    obscureText: pass,
                    decoration: InputDecoration(
                        suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                pass = !pass;
                              });
                            },
                            child: pass
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText: 'Password',
                        hintText: 'Enter your secure password'),
                  ),
                ),
              ),
              SizedBox(
                width: w / 1.5,
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        _auth.forgot(_email);
                      },
                      child: Text(
                        'Forgot Password? ',
                        style: TextStyle(fontSize: 14, color: Colors.redAccent),
                      )),
                ],
              ),
              SizedBox(
                height: h / 40,
              ),
              InkWell(
                onTap: () {
                  // if (_formKey.currentState!.validate())
                  _auth.login(_email, _password, context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue,
                  ),
                  child: Center(
                    child: Text(
                      "LOGIN",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  height: h / 20,
                  width: w / 1.9,
                ),
              ),
              SizedBox(
                height: h / 35,
              ),
              InkWell(
                onTap: () {
                  _auth.signInWithGoogle(context);
                },
                child: Container(
                  height: h / 20,
                  width: w / 1.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white10,
                      border: Border.all(color: Colors.black12)),
                  child: Row(
                    children: [
                      Image(image: AssetImage("assets/images/google.png")),
                      Text('Continue with google'),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: h / 28,
              ),
              Row(children: [
                SizedBox(
                  width: w / 5,
                ),
                Text("Dont Have An Account ?"),
                SizedBox(
                  width: w / 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx) {
                      return SignUp();
                    }));
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ]),
            ],
          ),
        ),
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}
