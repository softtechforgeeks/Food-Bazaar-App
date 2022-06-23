import 'package:flutter_login_ui/services/database_service.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_login_ui/controllers/order_controller.dart';
import 'package:flutter_login_ui/models/order_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'user_orders_body.dart';

class UserActiveOrders extends StatefulWidget {
  const UserActiveOrders({Key? key}) : super(key: key);

  @override
  State<UserActiveOrders> createState() => _UserActiveOrdersState();
}

class _UserActiveOrdersState extends State<UserActiveOrders> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Active Orders",
          ),
          backgroundColor: Colors.orange),
      body: OrderBody(),
    );
  }
}