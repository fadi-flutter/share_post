import 'package:cloud_firestore/cloud_firestore.dart';

class GetPostModel {
  String createdAt, description, userID, userName, id;
  List likes, disLikes;

  GetPostModel(
      {required this.createdAt,
      required this.description,
      required this.userID,
      required this.userName,
      required this.id,
      required this.disLikes,
      required this.likes});

  factory GetPostModel.fromMap(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return GetPostModel(
      id: doc.id,
      createdAt: data['created_at'],
      description: data['description'],
      userID: data['user_id'],
      userName: data['user_name'],
      disLikes: List.from(data['dislikes']),
      likes: List.from(data['likes']),
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['description'] = description;
    data['user_id'] = userID;
    data['user_name'] = userName;
    return data;
  }
}
