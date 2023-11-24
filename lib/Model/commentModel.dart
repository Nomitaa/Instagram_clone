import 'package:cloud_firestore/cloud_firestore.dart';
late Comment_model comment_model;
class Comment_model{
  String comment;
  String commentId;
  String id;
  Timestamp commentDate;
  Comment_model({
    required this.comment,
    required this.commentId,
    required this.id,
    required this.commentDate
  });
  Comment_model.fromJson(Map<String,dynamic>json):
        comment=json['comment'],
        commentId=json['commentId'],
        id=json['id'],
        commentDate=json['commentDate'];
  Map<String,dynamic>toJson(){
    return {
      'comment':comment,
      'id':id,
      'commentDate':commentDate,
      'commentId':commentId,
    };
  }
  Comment_model copyWith({
    String?id,
    String?comment,
    String?commentId,
    Timestamp? commentDate,

  }){
    return Comment_model(
        comment:comment??this.comment,
        commentId:commentId??this.commentId,
        commentDate:commentDate??this.commentDate,
        id:id??this.id

    );

  }
}