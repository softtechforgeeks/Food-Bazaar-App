import 'package:flutter/material.dart';
import 'package:flutter_login_ui/models/cart_model.dart';
import 'package:flutter_login_ui/screens/details/checkout/checkout_body.dart';

import 'package:flutter_login_ui/services/database_service.dart';

import '../../../appColors/app_colors.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  num subTotal = 0.0;
  final notesController = TextEditingController();
  final addrController = TextEditingController();
  DatabaseService database = DatabaseService();
  List<CartModel> orderList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const CheckBody(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(0, 59, 57, 57),
        centerTitle: true,
        title: const Text(
          "Cart",
          style: TextStyle(
            color: AppColors.blackColor,
          ),
        ),
      ),
      // body:
      //
    );
  }
}
