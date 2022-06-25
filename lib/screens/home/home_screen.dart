import 'dart:io';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/pages/profile_page.dart';
import 'package:flutter_login_ui/screens/details/cartPage/cart_page.dart';
import 'package:flutter_login_ui/screens/manage_orders/user_orders.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_login_ui/constants.dart';
import 'package:flutter_login_ui/screens/home/components/body.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_login_ui/models/user.dart';
import 'package:flutter_login_ui/pages/login_page.dart';
import 'package:flutter_login_ui/pages/splash_screen.dart';
// import 'package:flutter_login_ui/pages/widgets/header_widget.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_ui/services/auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../pages/registration_page.dart';
// import '../../pages/menu.dart';
import '../../pages/forgot_password_page.dart';
import 'package:share_plus/share_plus.dart';

class HomeScreen extends StatelessWidget {
  final double _drawerIconSize = 24;
  final double _drawerFontSize = 17;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [
                0.0,
                1.0
              ],
                  colors: [
                Theme.of(context).primaryColor.withOpacity(0.2),
                Theme.of(context).colorScheme.secondary.withOpacity(0.5),
              ])),
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: const [0.0, 1.0],
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).colorScheme.secondary,
                    ],
                  ),
                ),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: const Text(
                    "Food Bazaar",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.screen_lock_landscape_rounded,
                  size: _drawerIconSize,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                title: Text(
                  'Splash Screen',
                  style: TextStyle(
                      fontSize: 17,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const SplashScreen(title: "Splash Screen")));
                },
              ),
              Divider(
                color: Theme.of(context).primaryColor,
                height: 1,
              ),
              ListTile(
                leading: Icon(Icons.login_rounded,
                    size: _drawerIconSize,
                    color: Theme.of(context).colorScheme.secondary),
                title: Text(
                  'Login Page',
                  style: TextStyle(
                      fontSize: _drawerFontSize,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
              ),
              Divider(
                color: Theme.of(context).primaryColor,
                height: 1,
              ),
              ListTile(
                leading: Icon(Icons.person_add_alt_1,
                    size: _drawerIconSize,
                    color: Theme.of(context).colorScheme.secondary),
                title: Text(
                  'Registration Page',
                  style: TextStyle(
                      fontSize: _drawerFontSize,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegistrationPage()),
                  );
                },
              ),
              Divider(
                color: Theme.of(context).primaryColor,
                height: 1,
              ),
              ListTile(
                leading: Icon(
                  Icons.menu_rounded,
                  size: _drawerIconSize,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                title: Text(
                  'Profile Page',
                  style: TextStyle(
                      fontSize: _drawerFontSize,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfilePage()),
                  );
                },
              ),
              Divider(
                color: Theme.of(context).primaryColor,
                height: 1,
              ),
              ListTile(
                leading: Icon(
                  Icons.password_rounded,
                  size: _drawerIconSize,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                title: Text(
                  'Forgot Password Page',
                  style: TextStyle(
                      fontSize: _drawerFontSize,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ForgotPasswordPage()),
                  );
                },
              ),
              // Divider(
              //   color: Theme.of(context).primaryColor,
              //   height: 1,
              // ),
              // ListTile(
              //   leading: Icon(
              //     Icons.verified_user_sharp,
              //     size: _drawerIconSize,
              //     color: Theme.of(context).colorScheme.secondary,
              //   ),
              //   title: Text(
              //     'Verification Page',
              //     style: TextStyle(
              //         fontSize: _drawerFontSize,
              //         color: Theme.of(context).colorScheme.secondary),
              //   ),
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => ForgotPasswordVerificationPage(
              //               email: email, code: code)),
              //     );
              //   },
              // ),
              Divider(
                color: Theme.of(context).primaryColor,
                height: 1,
              ),
              ListTile(
                leading: Icon(
                  Icons.logout_rounded,
                  size: _drawerIconSize,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                      fontSize: _drawerFontSize,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                onTap: () {
                  AuthService().signOut();
                },
              ),
            ],
          ),
        ),
      ),
      body: const Body(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    Future<void> _shareApp() async {
      const urlImage = 'https://i.ibb.co/KXKfdrM/logo.png';
      final url = Uri.parse(urlImage);
      final response = await http.get(url);
      final bytes = response.bodyBytes;
      final temp = await getTemporaryDirectory();
      final path = '${temp.path}/logo.png';
      print(path);
      File(path).writeAsBytesSync(bytes);

      await Share.shareFiles([path],
          text: 'Download FoodBazaar Now! at: https://i.diawi.com/qT5xzG',
          subject: 'Share App');
    }

    openWhatsApp() async {
      var whatsapp = "00201028980878";
      var whatsappURL_android =
          "https://api.whatsapp.com/send?phone=${whatsapp}" +
              "&text=Hello I need help";
      var whatsappURL_ios =
          "https://wa.me/${whatsapp}?text=${Uri.parse("Hello I need help")}";
      if (Platform.isIOS) {
        // ignore: deprecated_member_use
        if (await canLaunch(whatsappURL_ios)) {
          await launch(whatsappURL_ios);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: new Text("Whatsapp is not installed")));
        }
      } else {
        if (await canLaunch(whatsappURL_android)) {
          await launch(whatsappURL_android);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: new Text("Whatsapp is not installed")));
        }
      }
    }

    launchWhatsApp() async {
      final link = WhatsAppUnilink(
        phoneNumber: '+201028980878',
        text: "Hey! I'm inquiring about my order",
      );
      // Convert the WhatsAppUnilink instance to a string.
      // Use either Dart's string interpolation or the toString() method.
      // The "launch" method is part of "url_launcher".
      await launch('$link');
    }

    return AppBar(
      backgroundColor: const Color.fromARGB(255, 255, 106, 0),
      elevation: 0,
      // leading: IconButton(
      //   icon: SvgPicture.asset("assets/icons/back.svg"),
      //   onPressed: () {},
      // ),

      actions: [
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/share.svg",
            // By default our  icon color is white
            color: kTextColor,
          ),
          onPressed: _shareApp,
        ),
        IconButton(
            icon: const Icon(Icons.whatsapp_rounded),
            onPressed: () {
              launchWhatsApp();
            }),
        IconButton(
            icon: const Icon(Icons.lightbulb),
            onPressed: () {
              Get.isDarkMode
                  ? Get.changeTheme(ThemeData.light())
                  : Get.changeTheme(ThemeData.dark());
            }),
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/history_icon.svg",
            // By default our  icon color is white
            color: kTextColor,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const UserActiveOrders()));
          },
        ),
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/cart.svg",
            // By default our  icon color is white
            color: kTextColor,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CartPage()));
          },
        ),
        const SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }
}
