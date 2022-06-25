import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/model.dart';
import '../models/order_model.dart';

class DatabaseService {
//   static final DatabaseService _instance = DatabaseService._constructor();
//   factory DatabaseService() {
//     return _instance;
//   }
//   DatabaseService._constructor();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<Order>> getOrders() {
    return _firebaseFirestore.collection('orders').snapshots().map((snapshot) {
      return snapshot.docs.reversed
          .map((doc) => Order.fromSnapshot(doc))
          .toList();
    });
  }

  Stream<List<Order>> getUserOrders() {
    return _firebaseFirestore.collection('orders').snapshots().map((snapshot) {
      return snapshot.docs.reversed
          .map((doc) => Order.fromSnapshot(doc))
          .where((element) =>
              (element.uid == FirebaseAuth.instance.currentUser!.uid))
          .toList();
    });
  }

  Stream<List<Product>> getProducts(String type) {
    return _firebaseFirestore
        .collection('products')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Product.fromSnapshot(doc))
          .where((element) => (element.category == type || type == 'All'))
          .toList();
    });
  }

  Future<void> updateOrder(
    Order order,
    String field,
    dynamic newValue,
  ) {
    return _firebaseFirestore
        .collection('orders')
        .get()
        .then((querySnapshot) => {
              querySnapshot.docs
                  .where((element) =>
                      (element['address'] as String == order.address))
                  .first
                  .reference
                  .update({field: newValue})
            });
  }

  Future<void> addProduct(Product product) {
    return _firebaseFirestore.collection('products').add(product.toMap());
  }

  Future<void> addOrder(Order order) async {
    print(order.subtotal);
    int list =
        await _firebaseFirestore.collection('orders').get().then((value) {
      var count = 0;
      count = value.docs.length;

      return count;
    });
    // int x = list.length;
    print(list);
    return _firebaseFirestore
        .collection('orders')
        .doc((list + 1).toString())
        .set(order.toMap());
  }

  Future<void> updateField(
    Product product,
    String field,
    dynamic newValue,
  ) {
    return _firebaseFirestore
        .collection('products')
        .where('id', isEqualTo: product.id)
        .get()
        .then((querySnapshot) => {
              querySnapshot.docs.first.reference.update({field: newValue})
            });
  }
}
