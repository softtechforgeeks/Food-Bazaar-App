import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/models/cart_model.dart';
import 'package:flutter_login_ui/models/order_model.dart';
import 'package:flutter_login_ui/screens/manage_orders/user_orders.dart';

import 'package:flutter_login_ui/services/database_service.dart';
import 'package:flutter_login_ui/widgets/my_button.dart';
import 'package:flutter_login_ui/widgets/single_cart_item.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
    return Scaffold(
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
      body: ListView(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("cart")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("userCart")
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshort) {
                if (!streamSnapshort.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return streamSnapshort.data!.docs.isEmpty
                    ? const Center(
                        child: Text(" No Cart"),
                      )
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: streamSnapshort.data!.docs.length,
                        itemBuilder: (ctx, index) {
                          var data = streamSnapshort.data!.docs[index];
                          // print(data['id'].runtimeType);
                          // print(data['category'].runtimeType);
                          // print(data['imageUrl'].runtimeType);
                          // print(data['price'].runtimeType);
                          // print(data['name'].runtimeType);
                          var c = CartModel(
                            id: data["id"].toString(),
                            category: data["category"],
                            imageUrl: data["imageUrl"],
                            price: data["price"],
                            quantity: data["quantity"],
                            name: data["name"],
                          );
                          var existingItem = orderList.firstWhere(
                              (itemToCheck) => itemToCheck.id == c.id,
                              orElse: () => CartModel(
                                    id: '',
                                    category: '',
                                    imageUrl: '',
                                    price: 0.0,
                                    quantity: 0,
                                    name: '',
                                  ));
                          if (existingItem.id == '') {
                            // print(data['price']);
                            subTotal += (data["price"] * data["quantity"]);
                            // print(data['quantity'].runtimeType);
                            // print(subTotal);
                            orderList.add(c);
                            // print(orderList);
                          } else {
                            if (existingItem.quantity != c.quantity) {
                              orderList.remove(existingItem);
                              subTotal -=
                                  (existingItem.price * existingItem.quantity);
                              orderList.add(c);
                              subTotal += (c.price * c.quantity);
                              // print("qantity is different");
                            }
                          }
                          return SingleCartItem(
                            id: data["id"],
                            category: data["category"],
                            imageUrl: data["imageUrl"],
                            price: data["price"],
                            quantity: data["quantity"],
                            name: data["name"],
                          );
                        },
                      );
              },
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 90,
                      child: Text(
                        'Notes',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        onChanged: (value) {
                          notesController.text = value;
                          print(notesController.text);
                        },
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 90,
                      child: Text(
                        'Address',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        onChanged: (value) {
                          addrController.text = value;
                          // print(addrController.text);
                        },
                        onSubmitted: (value) {
                          if (value.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Address cannot be Empty");
                          }
                        },
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ],
                ),
                ListTile(
                  leading: const Text("Sub Total"),
                  trailing: Text("\$" + subTotal.toString()),
                ),

                const ListTile(
                  leading: Text("Delivery"),
                  trailing: Text("\$5"),
                ),
                const Divider(
                  thickness: 2,
                ),
                ListTile(
                  leading: const Text("Total"),
                  trailing: Text("\$" + (subTotal + 5).toString()),
                ),
                //scroll text input field

                MyButton(
                  onPressed: () {
                    setState(() {});
                  },
                  text: 'Calculate',
                ),
                const Divider(
                  thickness: 2,
                ),
                MyButton(
                  onPressed: () async {
                    setState(() {});
                    if (addrController.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Address cannot be Empty");
                      return;
                    }
                    try {
                      // print(subTotal);
                      await database.addOrder(
                        Order(
                          orderList: orderList,
                          subtotal: subTotal,
                          total: (subTotal + 5),
                          notes: notesController.text,
                          address: addrController.text,
                          isAccepted: false,
                          isDelivered: false,
                          isCancelled: false,
                          createdAt: DateTime.now(),
                        ),
                      );
                      Fluttertoast.showToast(
                          msg: "Order created successfully.");
                      for (var item in orderList) {
                        FirebaseFirestore.instance
                            .collection("cart")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection("userCart")
                            .doc(item.id.toString())
                            .delete();
                        setState(() {});
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserActiveOrders()));
                    } on Exception catch (e) {
                      Fluttertoast.showToast(msg: "Exceptional error occured");
                      print(e);
                    }
                  },
                  text: 'Order Now',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
