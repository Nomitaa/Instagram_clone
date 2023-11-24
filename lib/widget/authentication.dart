import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/widget/firebaseconstands.dart';
import 'package:my_app/Pages/homePage.dart';
import 'package:my_app/navpage/screens.dart';
import 'package:my_app/Model/profilemodel.dart';
import 'package:my_app/Pages/userslist.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/commentModel.dart';
import '../Model/postmodel.dart';
import '../login&signup/loginpage.dart';
var myid;
var usernow;
String imgUrl='';
String dwnUrl='';
// Authentication _auth=Authentication();
class Authentication {
  media() async {
    ImagePicker imagePicker=ImagePicker();
    XFile? file=await imagePicker.pickImage(source: ImageSource.gallery);
    if(file==null)return;
    String imgName=DateTime.now().millisecondsSinceEpoch.toString();

    Reference imgRoot=FirebaseStorage.instance.ref();
    Reference directImg=imgRoot.child('media');
    Reference imgUpload=directImg.child(imgName);
    //file uploading/store-------------------------------------------
    try{
      await imgUpload.putFile(File(file.path));
      imgUrl=await imgUpload.getDownloadURL();
      pfmodels=await getlogin (FirebaseAuth.instance.currentUser!.uid);
      var a=pfmodels!.copyWith(profile: imgUrl);
      FirebaseFirestore.instance.collection(Constants.fc).doc(myid).update(a.toJson());
    }catch(error){
      print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
    }
  }
  camera() async {
    ImagePicker imagePicker=ImagePicker();
    XFile? file=await imagePicker.pickImage(source: ImageSource.camera);
    if(file==null)return;
    String imgName=DateTime.now().millisecondsSinceEpoch.toString();


    Reference imgRoot=FirebaseStorage.instance.ref();
    Reference directImg=imgRoot.child('media');
    Reference imgUpload=directImg.child(imgName);
    //file uploading/store-------------------------------------------
    try{
      await imgUpload.putFile(File(file.path));
      imgUrl=await imgUpload.getDownloadURL();
      pfmodels=await getlogin (FirebaseAuth.instance.currentUser!.uid);
      var a=pfmodels!.copyWith(profile: imgUrl);
      FirebaseFirestore.instance.collection(Constants.fc).doc(myid).update(a.toJson());
    }catch(error){
      print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
    }
  }



  ///google signup
  signInWithGoogle(BuildContext context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser
        ?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
      var userdata = Pfmodels(
          name: googleUser!.displayName!,
          id: value.user!.uid,
          saved: [],
          phone: '_',
          email: googleUser.email,
          createTime: Timestamp.now(),
          loginTime: Timestamp.now(),
          profile: googleUser.photoUrl,
          followers: [],
          following: []);
      print(value.user!.uid);
      myid =value.user!.uid;
      usernow=value.user!.uid;

      if (value.additionalUserInfo?.isNewUser ?? true) {
        FirebaseFirestore.instance.collection(Constants.fc).doc(value.user!.uid).set(
            userdata.toJson());
      }

      // {
      //
      //   //   "id": googleUser!.id,
      //   //   "name": googleUser.displayName,
      //   //   "phone": "",
      //   //   "email": googleUser.email,
      //   //   "profile": googleUser.photoUrl,
      //   //   "createTime":FieldValue.serverTimestamp()
      //   // }
      // }
      else {
        pfmodels=await getlogin(myid);
        SharedPreferences prf=await SharedPreferences.getInstance();
        prf.setString("uid",myid);
        // FirebaseFirestore.instance.collection("user").doc(value.user!.uid).update({
        //   "loginTime":Timestamp.now()
        // });
        // pfmodels=getlogin(myid);
        var a = pfmodels?.copyWith(loginTime: Timestamp.now());
        FirebaseFirestore.instance.collection(Constants.fc)
            .doc(value.user!.uid)
            .update(a!.toJson());
      }
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Mainpage(),));
    });
  }

  ///user from database-------------------------------------------
  /// To get the users except me from firebase
  Stream<List<Pfmodels>> user() {
    return FirebaseFirestore.instance
        .collection(Constants.fc).where('id',isNotEqualTo: myid)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map(
            (doc) => Pfmodels.fromJson(
          doc.data(),
        ),
      )
          .toList(),
    );
  }

  ///To check my id on others followerslist

  Stream<List<Pfmodels>> following() {
    return FirebaseFirestore.instance
        .collection(Constants.fc)
    // .where("id", isNotEqualTo: myid)
        .where("followers", arrayContains: myid)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map(
            (doc) => Pfmodels.fromJson(
          doc.data(),
        ),
      )
          .toList(),
    );
  }

///followers

  Stream<List<Pfmodels>> follower() {
    return FirebaseFirestore.instance
        .collection(Constants.fc).where('id',whereIn: pfmodels!.followers)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map(
            (doc) => Pfmodels.fromJson(
          doc.data(),
        ),
      )
          .toList(),
    );
  }




  ///signup

  SignUp(uname, password, BuildContext context, email, phone) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UsersList(),));
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: password).then((value) {

      var signdata=Pfmodels(name: uname,
          id: value.user!.uid,
          phone: phone,
          email: email,
          profile: '',
          createTime: Timestamp.now(),
          loginTime: Timestamp.now(),
          followers: [],
          following: [],
          saved: []);
      FirebaseFirestore.instance.collection(Constants.fc).doc(value.user!.uid).set(signdata.toJson());
    });
  }

  /// logout
  signOut(BuildContext context) async{
    SharedPreferences pred=await SharedPreferences.getInstance();
    pred.remove("uid");
    FirebaseAuth.instance.signOut().then((value) =>
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (context) => Login(),), (
            route) => false)
    );
  }

  ///login

  login(email, passwrd, context) {
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text, password: passwrd.text)
        .then((value) {
      Navigator.push(context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }


  ///forgot
  forgot(email) {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
  }

  /// my data from database(myid)myid lulla ella fieldsum datayilekk add cheyyan
  getlogin(String nuser) async

  {
    DocumentSnapshot<Map<String, dynamic>>snapshot =
    await FirebaseFirestore.instance.collection('user').doc(nuser).get();
    if (snapshot.exists) {
      var data = Pfmodels.fromJson(snapshot.data()!);
      return data;
    }
    else{
      return null;
    }

  }
  userget(){
    FirebaseFirestore.instance.collection('settings').doc('namitha').update({"test.name":FieldValue.delete()});

  }
gallery(){}
  gallary() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery,imageQuality: 50);
    if (file == null) return;
    String imgName = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();


    Reference imgRoot = FirebaseStorage.instance.ref();
    Reference directImg = imgRoot.child('post');
    Reference imgUpload = directImg.child(imgName);
    //file uploading/store-------------------------------------------
    try {
      await imgUpload.putFile(File(file.path));
      dwnUrl = await imgUpload.getDownloadURL();
      var a = PostClass(post: dwnUrl, id: myid, uploadTime: Timestamp.now(),likes: [],postId: '',description: '');
      FirebaseFirestore.instance.collection(Constants.fc)
          .doc(myid)
          .collection('posts')
          .add(a.toJson()).then((value) async {
        postClass=await getpost(value.id);
        var updid=postClass?.copyWith(postId: value.id);
        value.update(updid!.toJson());
      });
    } catch (error) {
      print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
    }
  }


  postcam() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.camera,imageQuality: 50);
    if (file == null) return;
    String imgName = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();


    Reference imgRoot = FirebaseStorage.instance.ref();
    Reference directImg = imgRoot.child('post');
    Reference imgUpload = directImg.child(imgName);
    //file uploading/store-------------------------------------------
    try {
      await imgUpload.putFile(File(file.path));
      dwnUrl = await imgUpload.getDownloadURL();
      var a = PostClass(post: dwnUrl, id: myid, uploadTime: Timestamp.now(),likes: [],postId: '',description: '');
      FirebaseFirestore.instance.collection(Constants.fc)
          .doc(myid)
          .collection('posts')
          .add(a.toJson()).then((value) async {
        postClass=await getpost(value.id);
        var updid=postClass?.copyWith(postId: value.id);
        value.update(updid!.toJson());
      });
    } catch (error) {
      print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
    }
  }
///To get posts from database of userid or myid(upd)

  getpost(String upd) async {
    DocumentSnapshot<Map<String,dynamic>>snapshot= await FirebaseFirestore.instance.collection(Constants.fc).doc(myid).collection('posts').doc(upd).get();
    if(snapshot.exists){
      var data=PostClass.fromJson(snapshot.data()!);
      return data;
    }
    else{
      return null;
    }
  }
  /// Comment

  getcomment(String a,String b,String c) async {
    DocumentSnapshot<Map<String,dynamic>>snapshot=await FirebaseFirestore.instance.collection(Constants.fc).doc(a).
    collection(PostConst.pc).doc(b).collection(CommentId.cmnt).doc(c).get();
    if(snapshot.exists){
      var data=Comment_model.fromJson(snapshot.data()!);
      return data;
    }
    else{
      return null;
    }
  }
}

