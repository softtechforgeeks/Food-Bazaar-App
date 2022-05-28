import 'package:flutter/material.dart';
import 'package:flutter_login_ui/models/user.dart';
// import 'package:flutter_login_ui/pages/home.dart';
import 'package:flutter_login_ui/pages/login_page.dart';
// import 'package:flutter_login_ui/pages/menu.dart';
import 'package:flutter_login_ui/screens/home/home_screen.dart';

import 'package:flutter_login_ui/products_screen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  UserModel loggedInUser;

  Wrapper({required this.loggedInUser});

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);

    // print(userModel.uid);
    // return either home or login page
    if (userModel.uid != null) {
      // print(loggedInUser.title);
      if (loggedInUser.title == "Admin") {
        return ProductsScreen();
      } else {
        return HomeScreen();
      }
    } else {
      return const LoginPage();
    }
  }
}
