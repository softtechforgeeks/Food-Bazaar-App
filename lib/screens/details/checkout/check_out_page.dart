import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/models/cart_model.dart';
import 'package:flutter_login_ui/models/order_model.dart';
import 'package:flutter_login_ui/models/user.dart';
import 'package:flutter_login_ui/screens/details/checkout/checkout_body.dart';
import 'package:flutter_login_ui/screens/manage_orders/user_orders.dart';

import 'package:flutter_login_ui/services/database_service.dart';
import 'package:flutter_login_ui/widgets/my_button.dart';
import 'package:flutter_login_ui/widgets/single_cart_item.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../appColors/app_colors.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  double subTotal = 0.0;
  final notesController = TextEditingController();
  final addrController = TextEditingController();
  DatabaseService database = DatabaseService();
  List<CartModel> orderList = [];

  @override
  Widget build(BuildContext context) {
    String uid = Provider.of<UserModel>(context).uid!;
    return Scaffold(
      body: CheckBody(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(0, 59, 57, 57),
        centerTitle: true,
        title: const Text(
          "Cart",
          style: TextStyle(
            color: AppColors.KblackColor,
          ),
        ),
      ),
      // body:
      //
    );
  }
}
