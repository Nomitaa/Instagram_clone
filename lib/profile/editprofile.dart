import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:my_app/widget/firebaseconstands.dart';
import 'package:my_app/Model/profilemodel.dart';
import 'package:my_app/widget/root.dart';
import 'package:my_app/Pages/userslist.dart';
import '../widget/authentication.dart';

class Edit extends StatefulWidget {
  const   Edit({super.key});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  CollectionReference reference = FirebaseFirestore.instance.collection(myid);
  String imgUrl = '';
  ImagePicker imagePicker = ImagePicker();

  //imagepicker.pickImage(source: ImageSource.camera);
  TextEditingController name = TextEditingController(text: pfmodels!.name);
  TextEditingController phone = TextEditingController(text: pfmodels!.phone);
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Edit Profile',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, right: 15, left: 15),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(pfmodels?.profile ?? ''),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 10,
                                    color: Colors.grey,
                                    spreadRadius: 3)
                              ]),
                          child: CircleAvatar(
                            radius: 18,
                            child: InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        width: w,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          // borderRadius: BorderRadius.only(
                                          //   topRight: Radius.circular(50),
                                          //   topLeft: Radius.circular(50),
                                          // )
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            GestureDetector(
                                              child: ListTile(
                                                leading: Icon(
                                                  Icons.camera_alt_outlined,
                                                ),
                                                title: Text("Camera"),
                                              ),
                                              onTap: () {
                                                auth.camera();
                                                Navigator.pop(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          Edit(),
                                                    ));
                                              },
                                            ),
                                            GestureDetector(
                                              child: ListTile(
                                                leading: Icon(
                                                    Icons.perm_media_outlined),
                                                title: Text("Gallery"),
                                              ),
                                              onTap: () {
                                                auth.media();
                                                Navigator.pop(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          Edit(),
                                                    ));
                                              },
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                               child: Icon(Icons.camera_alt)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: h / 10,
                ),
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      labelText: 'User Name',
                      hintText: 'Enter Valid Name'),
                ),
                SizedBox(
                  height: h / 20,
                ),
                IntlPhoneField(
                  controller: phone,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    //hintText: 'Enter valid phone number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(),
                    ),
                  ),
                  initialCountryCode: 'IN',
                  onChanged: (phone) {
                   // print(phone.completeNumber);
                  },
                ),
                ElevatedButton(
                    onPressed: () async {
                      final val = formKey.currentState!.validate();
                      if (val) {
                        pfmodels = (
                            await auth.getlogin(FirebaseAuth.instance.currentUser!.uid));
                        var updateData = pfmodels!.copyWith(
                            name: name.text,
                            phone: phone.text);
                        FirebaseFirestore.instance
                            .collection(Constants.fc)
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update(updateData.toJson());
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>Root(),
                            ),
                                (route) => false);
                      }
                    },
                    child: Text("Done"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
