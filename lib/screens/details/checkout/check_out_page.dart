import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_login_ui/widgets/my_button.dart';
import 'package:flutter_login_ui/widgets/single_cart_item.dart';

import '../../../appColors/app_colors.dart';
import '../../../route/routing_page.dart';
import '../address/address_form.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(0, 59, 57, 57),
        centerTitle: true,
        title: const Text(
          "Check out",
          style: TextStyle(
            color: AppColors.KblackColor,
          ),
        ),
      ),
      body: Column(
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
                        physics: const BouncingScrollPhysics(),
                        itemCount: streamSnapshort.data!.docs.length,
                        itemBuilder: (ctx, index) {
                          var data = streamSnapshort.data!.docs[index];
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
                const ListTile(
                  leading: Text("Sub Total"),
                  trailing: Text("\$200"),
                ),

                const ListTile(
                  leading: Text("Delivery"),
                  trailing: Text("\$10"),
                ),
                const Divider(
                  thickness: 2,
                ),
                const ListTile(
                  leading: Text("Total"),
                  trailing: Text("\$500"),
                ),
                //scroll text input field

                MyButton(
                  onPressed: () {},
                  text: 'Buy Now',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
