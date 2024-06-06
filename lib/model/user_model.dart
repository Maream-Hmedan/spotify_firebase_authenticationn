import 'package:cloud_firestore/cloud_firestore.dart';


class UserModel {
  String email;
  String mobile;
  String uid;
  String username;
  bool isVerify;
  String? token;

  UserModel(
      {required this.email,
        required this.mobile,
        this.token,
        required this.uid,
        required this.username,
        this.isVerify = false});

  factory UserModel.fromJson(Map<String, dynamic> map) => UserModel(
    email: map["userEmail"],
    mobile: map["userMobile"],
    uid: map["userId"],
    username: map["userName"],
    isVerify: map["isVerify"],
  );

  factory UserModel.fromQueryDocumentSnapShot(QueryDocumentSnapshot map) {
    UserModel model;
    model = UserModel(
      email: map["userEmail"],
      mobile: map["userMobile"],
      uid: map["userId"],
      username: map["userName"],
      isVerify: map["isVerify"],
    );
    return model;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "userEmail": email,
      "userMobile": mobile,
      "userId": uid,
      "userName": username,
      "isVerify": isVerify,
    };
    return map;
  }
}
