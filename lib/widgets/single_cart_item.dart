import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SingleCartItem extends StatefulWidget {
  final String imageUrl;
  final String name;
  final num price;
  final int quantity;
  final String category;
  final int id;

  const SingleCartItem({
    Key? key,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    required this.name,
    required this.category,
    required this.id,
  }) : super(key: key);

  @override
  _SingleCartItemState createState() => _SingleCartItemState();
}

class _SingleCartItemState extends State<SingleCartItem> {
  void quantityFuntion(int change) {
    FirebaseFirestore.instance
        .collection("cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userCart")
        .doc(widget.id.toString())
        .update({
      "quantity": widget.quantity + change,
    });
    setState(() {});
  }

  void deleteProductFuntion() {
    FirebaseFirestore.instance
        .collection("cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userCart")
        .doc(widget.id.toString())
        .delete();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(20.0),
        height: 150,
        width: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 7,
            )
          ],
        ),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.imageUrl),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          widget.name,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          widget.category,
                        ),
                        Text(
                          "\$ ${widget.price * widget.quantity}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IncrementAndDecrement(
                              icon: Icons.add,
                              onPressed: () {
                                setState(() {
                                  quantityFuntion(1);
                                });
                              },
                            ),
                            Text(
                              widget.quantity.toString(),
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            IncrementAndDecrement(
                              icon: Icons.remove,
                              onPressed: () {
                                if (widget.quantity > 1) {
                                  setState(() {
                                    quantityFuntion(-1);
                                  });
                                }
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            IconButton(
              onPressed: () {
                deleteProductFuntion();
              },
              icon: const Icon(
                Icons.close,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class IncrementAndDecrement extends StatelessWidget {
  final Function()? onPressed;
  final IconData icon;
  const IncrementAndDecrement({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 40,
      height: 30,
      elevation: 2,
      color: Colors.grey[300],
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(icon),
    );
  }
}
