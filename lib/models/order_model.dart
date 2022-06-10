import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_login_ui/models/cart_model.dart';

class Order extends Equatable {
  final List<CartModel> orderList;
  CartModel? orderItem;
  final double subtotal;
  final double total;
  final String notes;
  final String address;
  final bool isAccepted;
  final bool isDelivered;
  final bool isCancelled;
  final DateTime createdAt;

  Order({
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

  // Future getOrderData() async {
  //   List<CartModel> newOrderList = [];
  //   QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //       .collection('orders')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .collection('all')
  //       .get();

  //   for (var element in querySnapshot.docs) {
  //     orderItem = CartModel.fromDocument(element);
  //     newOrderList.add(orderItem!);
  //     subtotal += (orderItem!.price * orderItem!.quantity);
  //     total += (orderItem!.price * orderItem!.quantity);
  //   }
  //   orderList = newOrderList;
  // }

  // Order copyWith({
  //   List<CartModel>? items,
  //   double? subtotal,
  //   double? total,
  //   String? notes,
  //   String? address,
  //   bool? isAccepted,
  //   bool? isDelivered,
  //   bool? isCancelled,
  //   DateTime? createdAt,
  // }) {
  //   return Order(
  //     orderList: items ?? orderList,
  //     subtotal: subtotal ?? this.subtotal,
  //     total: total ?? this.total,
  //     notes: notes ?? this.notes,
  //     address: address ?? this.address,
  //     isAccepted: isAccepted ?? this.isAccepted,
  //     isDelivered: isDelivered ?? this.isDelivered,
  //     isCancelled: isCancelled ?? this.isCancelled,
  //     createdAt: createdAt ?? this.createdAt,
  //   );
  // }

  // List<CartModel> get getOrderList {
  //   return orderList;
  // }

  Map<String, dynamic> toMap() {
    // print('orderlist in ordermodel toMap');
    // print(orderList);
    var js = {
      'items': List<dynamic>.from(orderList.map((e) => e.toMap())),
      'subtotal': subtotal,
      'total': total,
      'notes': notes,
      'address': address,
      'isAccepted': isAccepted,
      'isDelivered': isDelivered,
      'createdAt': createdAt,
    };
    // var elem={};

    // for (var element in orderList) {
    //   js.addEntries({element.id:{
    //       "id": element.id,
    //       "name": element.name,
    //       "price": element.price,
    //       "imageUrl": element.imageUrl,
    //       "category": element.category,
    //       "quantity": element.quantity,
    //     }});
    // }
    return js;
  }

  factory Order.fromSnapshot(QueryDocumentSnapshot snap) {
    print(snap['items'].runtimeType);
    List<CartModel> y = [];
    for (var element in snap['items']) {
      print(element);
      print(element['id'].runtimeType);
      print(element['quantity'].runtimeType);
      CartModel x = CartModel(
          category: element['category'],
          id: element['id'],
          imageUrl: element['imageUrl'],
          name: element['name'],
          price: element['price'],
          quantity: element['quantity']);
      y.add(x);
    }
    print(y);
    return Order(
      orderList: y,
      subtotal: snap['subtotal'] as double,
      total: snap['total'] as double,
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
