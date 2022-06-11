import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/model.dart';
import '../models/order_model.dart';

class DatabaseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<Order>> getOrders() {
    // Stream<List<Order>>? allOrders;
    // List<String> names = [];
    // final x = _firebaseFirestore.collection('users').get().then((value) {
    //   for (var element in value.docs) {
    //     names.add(element.id);
    //   }
    // });
    // print(allOrders);
    // for (var element in names) {
    //   try {
    //     _firebaseFirestore.doc("users/$element").get().then((doc) {
    //       print(doc);
    //     });
    //     if (allOrders == null) {
    //       allOrders = _firebaseFirestore
    //           .collection('orders')
    //           .doc(element)
    //           .collection('all')
    //           .snapshots()
    //           .map((snapshot) {
    //         return snapshot.docs
    //             .map((doc) => Order.fromSnapshot(doc.data()))
    //             .toList();
    //       });
    //     } else {
    //       allOrders += _firebaseFirestore
    //           .collection('orders')
    //           .doc(element)
    //           .collection('all')
    //           .snapshots()
    //           .map((snapshot) {
    //         return snapshot.docs
    //             .map((doc) => Order.fromSnapshot(doc.data()))
    //             .toList();
    //       });
    //     }
    //   } catch (e) {
    //     // If any error
    //     // return false;
    //   }
    // }
    // print(allOrders);
    return _firebaseFirestore
        .collection('orders')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('all')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Order.fromSnapshot(doc.data()))
          .toList();
    });
  }

  Stream<List<Order>> getAllOrders() {
    final allUsers =
        _firebaseFirestore.collection('orders').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Order.fromSnapshot(doc.data()))
          .toList();
    });
    return _firebaseFirestore
        .collection('orders')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('all')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Order.fromSnapshot(doc.data()))
          .toList();
    });
  }
  // Stream<List<Order>> getPendingOrders() {
  //   return _firebaseFirestore
  //       .collection('orders')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .collection('all')
  //       .where('isDelivered', isEqualTo: false)
  //       .where('isCancelled', isEqualTo: false)
  //       .snapshots()
  //       .map((snapshot) {
  //     return snapshot.docs.map((doc) => Order.fromSnapshot(doc)).toList();
  //   });
  // }

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
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('all')
        .get()
        .then((querySnapshot) => {
              querySnapshot.docs.first.reference.update({field: newValue})
            });
  }

  Future<void> addProduct(Product product) {
    return _firebaseFirestore.collection('products').add(product.toMap());
  }

  Future<void> addOrder(Order order) {
    print(order.subtotal);
    return _firebaseFirestore
        .collection('orders')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('all')
        .add(order.toMap());
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
