

import 'package:json_annotation/json_annotation.dart';


class UserDetails {
  String? uid;
  String? name;
  String? email;
  String? photoUrl;
  bool? isEmailVerified;

  UserDetails({
    this.uid,
    required this.name,
    this.email,
    this.photoUrl,
    this.isEmailVerified,
  }) ;

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "photoUrl": photoUrl,
      "isEmailVerified": isEmailVerified,
    };
  }

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      uid: json["uid"],
      name: json["name"],
      email: json["email"],
      photoUrl: json["photoUrl"],
      isEmailVerified: json["isEmailVerified"],
    );
  }



}
