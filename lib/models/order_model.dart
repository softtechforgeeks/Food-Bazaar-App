import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_login_ui/models/cart_model.dart';

class Order extends Equatable {
  final String uid;
  final List<CartModel> orderList;
  // CartModel? orderItem;
  final num subtotal;
  final num total;
  final String notes;
  final String address;
  final bool isAccepted;
  final bool isDelivered;
  final bool isCancelled;
  final DateTime createdAt;

  const Order({
    required this.uid,
    required this.orderList,
    required this.subtotal,
    required this.total,
    required this.notes,
    required this.address,
    required this.isAccepted,
    required this.isDelivered,
    required this.isCancelled,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    var js = {
      'uid': uid,
      'items': List<dynamic>.from(orderList.map((e) => e.toMap())),
      'subtotal': subtotal,
      'total': total,
      'notes': notes,
      'address': address,
      'isAccepted': isAccepted,
      'isCancelled': isCancelled,
      'isDelivered': isDelivered,
      'createdAt': createdAt,
    };
    // print("in to map after listing attributes");
    return js;
  }

  factory Order.fromSnapshot(DocumentSnapshot snap) {
    List<CartModel> y = [];
    for (var element in snap['items']) {
      CartModel x = CartModel(
          category: element['category'],
          id: element['id'],
          imageUrl: element['imageUrl'],
          name: element['name'],
          price: element['price'],
          quantity: element['quantity']);
      y.add(x);
    }
    // print(y);
    return Order(
      uid: snap['uid'] as String,
      orderList: y,
      subtotal: snap['subtotal'] as num,
      total: snap['total'] as num,
      notes: snap['notes'] as String,
      address: snap['address'] as String,
      isAccepted: snap['isAccepted'] as bool,
      isDelivered: snap['isDelivered'] as bool,
      isCancelled: snap['isCancelled'] as bool,
      createdAt: snap['createdAt'].toDate(),
    );
  }

  String toJson() => json.encode(toMap());
  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      uid,
      orderList,
      subtotal,
      total,
      notes,
      address,
      isAccepted,
      isDelivered,
      isCancelled,
      createdAt,
    ];
  }
}
