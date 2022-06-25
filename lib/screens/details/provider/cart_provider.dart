import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_login_ui/models/cart_model.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> cartList = [];
  CartModel? cartModel;

  Future getCartData() async {
    List<CartModel> newCartList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userCart")
        .get();

    for (var element in querySnapshot.docs) {
      cartModel = CartModel.fromDocument(element);
      notifyListeners();
      newCartList.add(cartModel!);
    }
    cartList = newCartList;
    notifyListeners();
  }

  List<CartModel> get getCartList {
    return cartList;
  }

  num subTotal() {
    num subtotal = 0.0;
    for (var element in cartList) {
      subtotal += element.price * element.quantity;
    }
    return subtotal;
  }
}
