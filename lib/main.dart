import 'package:flutter/material.dart';
import 'package:flutter_login_ui/models/user.dart';
import 'package:flutter_login_ui/orders_screen.dart';
import 'package:flutter_login_ui/services/auth.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'pages/splash_screen.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'package:flutter_login_ui/products_screen.dart';
import 'package:flutter_login_ui/new_product_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(LoginUiApp());
}

class LoginUiApp extends StatelessWidget {
  //Color _primaryColor = HexColor('#ff8c00');
  //Color _accentColor = HexColor('#8A02AE');

  //Design color
  final Color _primaryColor = HexColor('#ff4c00');
  final Color _accentColor = HexColor('#FF8C00');

  // Our Logo Color
  // Color _primaryColor= HexColor('#D44CF6');
  // Color _accentColor= HexColor('#5E18C8');

  // Our Logo Blue Color
  //Color _primaryColor= HexColor('#651BD2');
  //Color _accentColor= HexColor('#320181');

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
//multiprovider

    return StreamProvider<UserModel>.value(
      value: AuthService().user,
      initialData: UserModel(uid: null),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Food Bazaar',
        getPages: [
          GetPage(name: '/products', page: () => ProductsScreen()),
          GetPage(name: '/products/news', page: () => const NewProductScreen()),
          GetPage(name: '/orders', page: () => OrderScreen()),
        ],
        theme: ThemeData(
          primaryColor: _primaryColor,
          scaffoldBackgroundColor: Colors.grey.shade100,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
              .copyWith(secondary: _accentColor),
        ),
        home: const SplashScreen(title: 'Food Bazaar'),
      ),
    );
  }
}
