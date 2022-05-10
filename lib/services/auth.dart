import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_ui/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  UserModel userFromFirebaseUser(User? user) {
    return (user != null) ? UserModel(uid: user.uid) : UserModel(uid: null);
  }

  // auth change user stream
  Stream<UserModel> get user {
    return _auth
        .authStateChanges()
        // .map((User user) => _userFromFirebaseUser(user));
        .map(userFromFirebaseUser);
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
