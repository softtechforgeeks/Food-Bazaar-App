import 'package:flutter/material.dart';
import 'package:flutter_login_ui/common/theme_helper.dart';
import 'package:flutter_login_ui/controllers/order_controller.dart';
import 'package:flutter_login_ui/models/order_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({Key? key}) : super(key: key);

  final OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Orders",
          ),
          backgroundColor: Colors.orange),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                  itemCount: orderController.orders.length,
                  itemBuilder: (BuildContext context, int index) {
                    return OrderCard(order: orderController.orders[index]);
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  OrderCard({Key? key, required this.order}) : super(key: key);

  final Order order;
  final OrderController orderController = Get.find();
  String cate = "Accepted";

  final String _content =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum diam ipsum, lobortis quis ultricies non, lacinia at justo.';

  void _shareContent() {
    Share.share(_content);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('hh:mm dd-MM-yyyy').format(order.createdAt),
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ]),
                const SizedBox(height: 10.0),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: order.orderList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 50,
                              width: 50,
                              child: Image.network(
                                order.orderList[index].imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  order.orderList[index].name,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  width: 285,
                                  child: Text(
                                    order.orderList[index].category,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                    overflow: TextOverflow.clip,
                                    maxLines: 2,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  width: 285,
                                  child: Text(
                                    "Quantity: ${order.orderList[index].quantity}",
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                    overflow: TextOverflow.clip,
                                    maxLines: 2,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  width: 285,
                                  child: Text(
                                    "Price: ${order.orderList[index].price}",
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                    overflow: TextOverflow.clip,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                const SizedBox(height: 10.0),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            width: 285,
                            child: Text(
                              "Address: ${order.address}",
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.clip,
                              maxLines: 2,
                            ),
                          ),
                          const SizedBox(height: 5),
                          (order.notes != '')
                              ? SizedBox(
                                  width: 285,
                                  child: Text(
                                    "Notes: ${order.notes}",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.clip,
                                    maxLines: 2,
                                  ),
                                )
                              : const SizedBox(
                                  width: 285,
                                  child: Text(
                                    "Notes: No Thanks",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.clip,
                                    maxLines: 2,
                                  ),
                                ),
                        ],
                      )
                    ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Text(
                          "Order Costs: ",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          "${order.subtotal}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: const [
                        Text(
                          "Delivery Fee: ",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          "5",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          "${order.total}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Status: ",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      (!order.isAccepted &&
                              !order.isDelivered &&
                              !order.isCancelled)
                          ? const Text(
                              "New Order",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )
                          : (order.isAccepted &&
                                  !order.isDelivered &&
                                  !order.isCancelled)
                              ? const Text(
                                  "Order In Progress",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              : (order.isDelivered)
                                  ? const Text(
                                      "Order Delivered Successfully",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : order.isCancelled
                                      ? const Text(
                                          "Order Cancelled",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : const Text(
                                          "Invalid Status",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        )

                      // order.isAccepted
                      //     ? ElevatedButton(
                      //         onPressed: () {
                      //           orderController.updateOrder(
                      //             order,
                      //             'isDelivered',
                      //             !order.isDelivered,
                      //           );
                      //         },
                      //         style: ElevatedButton.styleFrom(
                      //           primary: Colors.blue,
                      //           minimumSize: const Size(110, 40),
                      //         ),
                      //         child: const Text(
                      //           "Deliver",
                      //           style: TextStyle(fontSize: 14),
                      //         ),
                      //       )
                      //     : ElevatedButton(
                      //         onPressed: () {
                      //           orderController.updateOrder(
                      //             order,
                      //             'isAccepted',
                      //             !order.isAccepted,
                      //           );
                      //         },
                      //         style: ElevatedButton.styleFrom(
                      //           primary: Colors.blue,
                      //           minimumSize: const Size(110, 40),
                      //         ),
                      //         child: const Text(
                      //           "Accept",
                      //           style: TextStyle(fontSize: 14),
                      //         ),
                      //       ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     orderController.updateOrder(
                      //       order,
                      //       'isCancelled',
                      //       !order.isCancelled,
                      //     );
                      //   },
                      //   style: ElevatedButton.styleFrom(
                      //     primary: Colors.red,
                      //     minimumSize: const Size(110, 40),
                      //   ),
                      //   child: const Text(
                      //     "Cancel",
                      //     style: TextStyle(fontSize: 14),
                      //   ),
                      // ),
                    ]),
                (!order.isCancelled && !order.isDelivered)
                    ? Row(
                        children: [
                          Container(
                            child: DropdownButton<String>(
                              value: cate,
                              elevation: 16,
                              style: const TextStyle(color: Colors.orange),
                              underline: Container(
                                height: 2,
                                color: Colors.orange,
                              ),
                              onChanged: (value) {
                                print(value);
                                if (value == "Accepted") {
                                  orderController.updateOrder(
                                      order, 'isAccepted', true);
                                } else if (value == "Delivered") {
                                  orderController.updateOrder(
                                      order, 'isDelivered', true);
                                } else if (value == "Cancelled") {
                                  orderController.updateOrder(
                                      order, 'isCancelled', true);
                                }
                              },
                              items: <String>[
                                'Accepted',
                                'Delivered',
                                'Cancelled'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              // onSaved: (value) {
                              //   secondNameController.text = value!;
                              // },
                            ),
                            decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                          ),
                        ],
                      )
                    : Row(),
              ],
            ),
          ),
        ));
  }
}
