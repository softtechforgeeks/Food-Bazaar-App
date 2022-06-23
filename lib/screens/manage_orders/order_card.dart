import 'package:flutter_login_ui/services/database_service.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_login_ui/controllers/order_controller.dart';
import 'package:flutter_login_ui/models/order_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({Key? key, required this.order}) : super(key: key);

  final Order order;
  // final OrderController orderController = Get.find();

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
                                    "Address: ${order.notes}",
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
                        const SizedBox(height: 5),
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
                              "Order Sent Successfully",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )
                          : (order.isAccepted && !order.isDelivered)
                              ? const Text(
                                  "Order In Progress",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              : (order.isAccepted && order.isDelivered)
                                  ? const Text(
                                      "Order Delivered Successfully",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : order.isCancelled
                                      ? const Text(
                                          "Sorry, we can't afford this order now.",
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
                    ])
              ],
            ),
          ),
        ));
  }
}
