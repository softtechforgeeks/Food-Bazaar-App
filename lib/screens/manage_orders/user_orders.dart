import 'package:flutter/material.dart';
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
      body: const OrderBody(),
    );
  }
}
