import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/model.dart';

class DatabaseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

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
