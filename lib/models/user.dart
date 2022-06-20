import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? lastName;
  String? mobile;
  String? title;
  String? password;

  UserModel(
      {this.uid,
      this.email,
      this.firstName,
      this.lastName,
      this.mobile,
      this.title,
      this.password}) {
    if (uid != null && title == null) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .get()
          .then((value) {
        final ex = UserModel.fromMap(value.data());
        email = ex.email;
        firstName = ex.firstName;
        lastName = ex.lastName;
        mobile = ex.mobile;
        title = ex.title;
      });
    }
  }

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      mobile: map['mobile'],
      title: map['title'],
      password: map['password'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'mobile': mobile,
      'title': title,
      'password': password,
    };
  }
}
