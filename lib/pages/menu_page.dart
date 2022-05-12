import 'package:flutter_login_ui/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/common/theme_helper.dart';
import 'package:flutter_login_ui/services/auth.dart';

//create a new page with a button //work for next 

class menu_page extends StatelessWidget {
  const menu_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              //let's create a common header widget
            ),
            SafeArea(
              child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(
                      20, 10, 20, 10), // This will be the login form
                  child: Column(
                    children: [
                      Text(
                        'Menu',
                        style: TextStyle(
                            fontSize: 60, fontWeight: FontWeight.bold),
                      ) ]
                  ),
              ),
            ),
          ]
        ),
      ),
    );

            
                     
                     

  }
}