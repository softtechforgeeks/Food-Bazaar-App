import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/models/cart_model.dart';
import 'package:flutter_login_ui/models/order_model.dart';
import 'package:flutter_login_ui/models/user.dart';
import 'package:flutter_login_ui/screens/manage_orders/user_orders.dart';
import 'package:flutter_login_ui/services/database_service.dart';
import 'package:flutter_login_ui/services/notify.dart';
import 'package:flutter_login_ui/widgets/my_button.dart';
import 'package:flutter_login_ui/widgets/single_cart_item.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class CheckBody extends StatefulWidget {
  const CheckBody({Key? key}) : super(key: key);

  @override
  State<CheckBody> createState() => _CheckBodyState();
}

class _CheckBodyState extends State<CheckBody> {
  num subTotal = 0.0;
  final notesController = TextEditingController();
  final addrController = TextEditingController();
  DatabaseService database = DatabaseService();
  Notify n = Notify();
  List<CartModel> orderList = [];

  var uuid = const Uuid();
  final String _sessionToken = '1234567890';
  // final List<String> _placeList = [];

  Future<List<String>> getPlaceSuggestions(String input) async {
    List<String> places = [];
    String kPLACESAPIKEY = "AIzaSyDXdESNtAANbXKvY15Q10MlqjkWaNtVufM";
    try {
      String baseURL =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String request =
          '$baseURL?input=$input&key=$kPLACESAPIKEY&sessiontoken=$_sessionToken';
      var response = await http.get(Uri.parse(request));
      final List data = json.decode(response.body)['predictions'];
      if (response.statusCode == 200) {
        places = data.map((e) => e["description"] as String).toList();
      } else {
        // print("error happend inside getsuggestions");
        throw Exception('Failed to load predictions');
      }
    } catch (e) {
      // print("error happend inside getsuggestions");
    }
    return places;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    String uname = "${user.firstName} ${user.lastName}";
    // print(uname);
    return ListView(
      children: [
        Expanded(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("cart")
                .doc(user.uid)
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
                          subTotal += (data["price"] * data["quantity"]);
                          orderList.add(c);
                        } else {
                          if (existingItem.quantity != c.quantity) {
                            orderList.remove(existingItem);
                            subTotal -=
                                (existingItem.price * existingItem.quantity);
                            orderList.add(c);
                            subTotal += (c.price * c.quantity);
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
                    width: 250,
                    child: TextField(
                      onChanged: (value) {
                        notesController.text = value;
                        // print(notesController.text);
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
                    width: 250,
                    child: TypeAheadField<String?>(
                      debounceDuration: const Duration(microseconds: 500),
                      textFieldConfiguration: const TextFieldConfiguration(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: "Seek your location here",
                        ),
                      ),
                      suggestionsCallback: getPlaceSuggestions,
                      itemBuilder: (context, String? suggestion) {
                        final String place = suggestion!;
                        return ListTile(title: Text(place));
                      },
                      onSuggestionSelected: (String? suggestion) {
                        setState(() {
                          addrController.text = suggestion!;
                        });
                      },
                      noItemsFoundBuilder: ((context) =>
                          const ListTile(title: Text('No place found.'))),
                    ),
                  ),
                ],
              ),
              ListTile(
                leading: const Text("Sub Total"),
                trailing: Text("\$$subTotal"),
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
                trailing: Text("\$${subTotal + 5}"),
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
                        uid: user.uid!,
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
                    Fluttertoast.showToast(msg: "Order created successfully.");
                    setState(() {
                      n.orderNotification(
                          title: "New Order Created",
                          body: "$uname made a new order");
                    });

                    for (var item in orderList) {
                      FirebaseFirestore.instance
                          .collection("cart")
                          .doc(user.uid)
                          .collection("userCart")
                          .doc(item.id.toString())
                          .delete();
                      setState(() {});
                    }
                  } on Exception {
                    Fluttertoast.showToast(msg: "Exceptional error occured");
                    // print(e);
                  }
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const UserActiveOrders()));
                },
                text: 'Order Now',
              ),
            ],
          ),
        )
      ],
    );
  }
}
