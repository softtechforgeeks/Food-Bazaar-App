import 'package:cloud_firestore/cloud_firestore.dart';

class UserOrder {
  final String id;
  final String category;
  final String imageUrl;
  final num price;
  final int quantity;
  final String name;
  UserOrder({
    required this.category,
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.quantity,
  });
  factory UserOrder.fromDocument(QueryDocumentSnapshot doc) {
    return UserOrder(
      id: doc["id"],
      category: doc["category"],
      imageUrl: doc["imageUrl"],
      price: doc["price"],
      quantity: doc["quantity"],
      name: doc["name"],
    );
  }
}
