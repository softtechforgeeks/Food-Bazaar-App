import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  final String id;
  final String category;
  final String imageUrl;
  final num price;
  final int quantity;
  final String name;
  CartModel({
    required this.category,
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.quantity,
  });
  factory CartModel.fromDocument(QueryDocumentSnapshot doc) {
    // print(doc['name']);
    return CartModel(
      id: doc["id"],
      category: doc["category"],
      imageUrl: doc["imageUrl"],
      price: doc["price"],
      quantity: doc["quantity"],
      name: doc["name"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'imageUrl': imageUrl,
      'price': price,
      'quantity': quantity,
      'name': name,
    };
  }
}
