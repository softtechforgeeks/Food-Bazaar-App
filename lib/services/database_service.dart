import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/model.dart';
import '../models/order_model.dart';

class DatabaseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<Order>> getOrders() {
    return _firebaseFirestore.collection('orders').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Order.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<Order>> getPendingOrders() {
    return _firebaseFirestore
        .collection('orders')
        .where('isDelivered', isEqualTo: false)
        .where('isCancelled', isEqualTo: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Order.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<Product>> getProducts(String type) {
    return _firebaseFirestore
        .collection('products')
        .snapshots()
        .map((snapshot) {
      // print('get products');
      // print(snapshot.docs
      //     .map((doc) => Product.fromSnapshot(doc))
      //     .where((element) => (element.category == type || type == 'All'))
      //     .toList()
      //     .length);
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
        .where('id', isEqualTo: order.id)
        .get()
        .then((querySnapshot) => {
              querySnapshot.docs.first.reference.update({field: newValue})
            });
  }

  Future<void> addProduct(Product product) {
    return _firebaseFirestore.collection('products').add(product.toMap());
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
