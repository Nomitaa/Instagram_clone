import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:my_app/widget/authentication.dart';
import 'package:my_app/Pages/homePage.dart';
import 'package:my_app/login&signup/loginpage.dart';
import 'package:my_app/Pages/userslist.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Authentication _auth = Authentication();

  bool passwordvisible = false;
  bool confirmpassword = false;
  TextEditingController uname = TextEditingController();
  TextEditingController semail = TextEditingController();
  TextEditingController phon = TextEditingController();
  TextEditingController spass = TextEditingController();
  TextEditingController cpass = TextEditingController();
  FocusNode sf1 = FocusNode();
  FocusNode sf2 = FocusNode();
  FocusNode sf3 = FocusNode();
  FocusNode sf4 = FocusNode();
  FocusNode sf5 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: h / 6,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  focusNode: sf1,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(sf2);
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: uname,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      labelText: 'User Name',
                      hintText: 'Enter valid name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid username';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  focusNode: sf2,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(sf3);
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                      return 'Enter a valid email!';
                    }
                    return null;
                  },
                  controller: semail,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      labelText: 'Email',
                      hintText: 'Enter Valid Email Name'),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(10),
                  child:
                      // TextField(
                      //   controller: phon,
                      //   decoration: InputDecoration(
                      //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      //       labelText: 'Phone No',
                      //       hintText: 'Enter valid name'
                      //   ),
                      // ),
                      IntlPhoneField(
                    focusNode: sf3,
                    onSubmitted: (value) {
                      FocusScope.of(context).requestFocus(sf4);
                    },
                    controller: phon,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(),
                      ),
                    ),
                    initialCountryCode: 'IN',
                    onChanged: (phone) {
                      print(phone.completeNumber);
                    },
                  )),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  focusNode: sf4,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(sf5);
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: spass,
                  obscureText: passwordvisible,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: 'Password',
                    hintText: 'Enter your secure password',
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          passwordvisible = !passwordvisible;
                        });
                      },
                      child: (passwordvisible == false)
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    ),
                  ),
                  validator: (PassCurrentValue) {
                    RegExp regex = RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                    var passNonNullValue = PassCurrentValue ?? "";
                    if (passNonNullValue.isEmpty) {
                      return ("Password is required");
                    } else if (passNonNullValue.length < 6) {
                      return ("Password Must be more than 5 characters");
                    }
                    // else if(!regex.hasMatch(passNonNullValue)){
                    //   return ("Password should contain upper,lower,digit and Special character ");
                    // }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  focusNode: sf5,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: cpass,
                  validator: (value) {
                    if (spass.text != cpass.text) {
                      return "invalid password";
                    }
                  },
                  obscureText: confirmpassword,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: ' Confirm Password',
                    hintText: 'Enter your secure password',
                    suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            confirmpassword = !confirmpassword;
                          });
                        },
                        child: (confirmpassword == false)
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off)),
                  ),
                ),
              ),
              SizedBox(
                height: h / 40,
              ),
              InkWell(
                onTap: () {
                  _auth.SignUp(
                      uname.text, spass.text, context, semail.text, phon.text);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue,
                  ),
                  child: Center(
                    child: Text(
                      "SIGNUP",
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
                height: h / 18,
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
            ],
          ),
        ),
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}
