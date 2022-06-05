import 'package:flutter_login_ui/services/database_service.dart';
import 'package:get/get.dart';
import '/models/product_model.dart';

class ProductController extends GetxController {
  final DatabaseService database = DatabaseService();
  final String type;
  var products = <Product>[].obs;
  ProductController({required this.type});

  @override
  void onInit() {
    products.bindStream(database.getProducts(type));
    // print(products);
    super.onInit();
  }

  RxList<Product> onUpdate(String ty) {
    var pro = <Product>[].obs;
    products.bindStream(database.getProducts(ty));
    // print('on update');
    // print(pro.length);
    return pro;
  }

  var newProduct = {}.obs;

  get category => newProduct['category'];
  get description => newProduct['description'];

  get price => newProduct['price'];
  get quantity => newProduct['quantity'];

  get isRecommended => newProduct['isRecommended'];
  get isPopular => newProduct['isPopular'];

  void updateProductCategory(
    int index,
    Product product,
    String value,
  ) {
    product.category = value;
    products[index] = product;
  }

  void saveNewProductCategory(
    Product product,
    String field,
    String value,
  ) {
    database.updateField(
      product,
      field,
      value,
    );
  }

  void updateProductDescription(
    int index,
    Product product,
    String value,
  ) {
    product.description = value;
    products[index] = product;
  }

  void saveNewProductDescription(
    Product product,
    String field,
    String value,
  ) {
    database.updateField(
      product,
      field,
      value,
    );
  }

  void updateProductPrice(
    int index,
    Product product,
    double value,
  ) {
    product.price = value;
    products[index] = product;
  }

  void saveNewProductPrice(
    Product product,
    String field,
    double value,
  ) {
    database.updateField(
      product,
      field,
      value,
    );
  }

  void updateProductQuantity(
    int index,
    Product product,
    int value,
  ) {
    product.quantity = value;
    products[index] = product;
  }

  void saveNewProductQuantity(
    Product product,
    String field,
    int value,
  ) {
    database.updateField(
      product,
      field,
      value,
    );
  }
}
