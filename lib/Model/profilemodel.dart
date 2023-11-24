import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
late Pfmodels pfmodels;
// late PostClass postClass;
// late Comment_model comment_model;
class Pfmodels{
  String name;
  String id;
  String phone;
  String email;
  String? profile;
  Timestamp createTime ;
  Timestamp loginTime;
  List followers;
  List following;
  List saved;
  DocumentReference? reference;

  Pfmodels({
    this.reference,
    required this.name,
    required this.id,
    required this.phone,
    required this.email,
    required this.profile,
    required this.createTime,
    required this.loginTime,
    required this.followers,
    required this.following,
    required this.saved,
});
  Pfmodels.fromJson(Map<String,dynamic>json):
      reference=json['reference'],
        name=json['name']??'',
        id=json['id']??'',
        email=json['email']??'',
        profile=json['profile']??'',
        phone=json['phone']??'',
        createTime=json['createTime']??Timestamp.now(),
        loginTime=json['loginTime']??Timestamp.now(),
        followers=json['followers']??[],
        following=json['followings']??[],
      saved=json['saved'];
  Map<String,dynamic>toJson()=>{
    "reference":reference,
  "name":name,
  "id":id,
  "email":email,
  "profile":profile,
  "phone":phone,
  "createTime":createTime,
  "loginTime":loginTime,
    'followers':followers,
    'following':following,
    'saved':saved,

  };

Pfmodels copyWith({
  DocumentReference? reference,
  String? name,
  String? id,
  String? phone,
  String? email,
  String? profile,
  Timestamp? createTime ,
  Timestamp? loginTime,
  List? followers,
  List? following,
  List? saved,


})=>
    Pfmodels(
      reference: reference??this.reference,
        name: name??this.name,
        id: id??this.id,
        phone: phone??this.phone,
        email: email??this.email,
        profile: profile??this.profile,
        createTime: createTime??this.createTime,
        loginTime: loginTime??this.loginTime,
        followers: followers??this.followers,
        following: following??this.following,
         saved:saved??this.saved);

}

