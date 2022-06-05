import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Order extends Equatable {
  final int id;
  final int customerId;
  final List<int> productIds;
  final double deliveryFee;
  final double subtotal;
  final double total;
  final bool isAccepted;
  final bool isDelivered;
  final bool isCancelled;
  final DateTime createdAt;

  const Order({
    required this.id,
    required this.customerId,
    required this.productIds,
    required this.deliveryFee,
    required this.subtotal,
    required this.total,
    required this.isAccepted,
    required this.isDelivered,
    required this.isCancelled,
    required this.createdAt,
  });

  Order copyWith({
    int? id,
    int? customerId,
    List<int>? productIds,
    double? deliveryFee,
    double? subtotal,
    double? total,
    bool? isAccepted,
    bool? isDelivered,
    bool? isCancelled,
    DateTime? createdAt,
  }) {
    return Order(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      productIds: productIds ?? this.productIds,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      subtotal: subtotal ?? this.subtotal,
      total: total ?? this.total,
      isAccepted: isAccepted ?? this.isAccepted,
      isDelivered: isDelivered ?? this.isDelivered,
      isCancelled: isCancelled ?? this.isCancelled,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'productIds': productIds,
      'deliveryFee': deliveryFee,
      'subtotal': subtotal,
      'total': total,
      'isAccepted': isAccepted,
      'isDelivered': isDelivered,
      'createdAt': createdAt,
    };
  }

  factory Order.fromSnapshot(DocumentSnapshot snap) {
    return Order(
      id: snap['id'] as int,
      customerId: snap['customerId'] as int,
      productIds: List<int>.from(snap['productIds']),
      deliveryFee: snap['deliveryFee'] as double,
      subtotal: snap['subtotal'] as double,
      total: snap['total'] as double,
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
  List<Object> get props => [
        id,
        customerId,
        productIds,
        deliveryFee,
        subtotal,
        total,
        isAccepted,
        isDelivered,
        createdAt,
      ];

  static List<Order> orders = [
    Order(
      id: 1,
      customerId: 1,
      productIds: const [1, 2, 3],
      deliveryFee: 10,
      subtotal: 30.0,
      total: 40.0,
      isAccepted: false,
      isDelivered: false,
      isCancelled: false,
      createdAt: DateTime.now(),
    ),
    Order(
      id: 2,
      customerId: 2,
      productIds: const [2, 3],
      deliveryFee: 10,
      subtotal: 30.0,
      total: 40.0,
      isAccepted: false,
      isDelivered: false,
      isCancelled: false,
      createdAt: DateTime.now(),
    ),
  ];
}
