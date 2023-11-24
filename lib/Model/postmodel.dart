import 'package:cloud_firestore/cloud_firestore.dart';
late PostClass postClass;
class PostClass{
  String post;
  String id;
  List likes;
  Timestamp uploadTime;
  String postId;
  String description;
  PostClass({
    required this.post,
    required this.id,
    required this.likes,
    required this.postId,
    required this.uploadTime,
    required this.description,

  });
  PostClass.fromJson(Map<String, dynamic> json):
        postId = json['postId'],
        post = json["post"],
        id = json["id"],
        likes = json["likes"],
        description=json['description'],
        uploadTime = json["uploadTime"];

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'post': post,
      'uploadTime': uploadTime,
      'likes': likes,
      'id': id,
      'description':description,
    };
  }

  PostClass copyWith({
    String? id,
    String? post,
    Timestamp? uploadTime,
    List? likes,
    String? postId,
    String? description,
  }) {
    return PostClass(
      postId: postId ?? this.postId,
      post: post ?? this.post,
      id: id ?? this.id,
      uploadTime: uploadTime ?? this.uploadTime,
      likes: likes ?? this.likes,
      description: description?? this.description,
    );
  }
}