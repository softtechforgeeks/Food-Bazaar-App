import 'package:flutter_login_ui/services/database_service.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_login_ui/controllers/order_controller.dart';
import 'package:flutter_login_ui/models/order_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'order_card.dart';

class OrderBody extends StatefulWidget {
  OrderBody({Key? key}) : super(key: key);

  @override
  State<OrderBody> createState() => _OrderBodyState();
}

class _OrderBodyState extends State<OrderBody> {
  var orders = <Order>[].obs;
  final DatabaseService database = DatabaseService();
  @override
  Widget build(BuildContext context) {
    orders.bindStream(database.getUserOrders());
    print(orders.length);
    return 
    // (orders.length == 0)?Container(
    //       child: const Text(
    //         "Active Orders",
    //       )):
          Container(
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (BuildContext context, int index) {
                      print(index);
                      return OrderCard(order: orders[index]);
                    }),
              ),
            ),
          ],
        ),
      );
  }
}