import 'package:flutter_login_ui/common/theme_helper.dart';
import 'package:flutter_login_ui/products_screen.dart';
import 'package:flutter_login_ui/services/notify.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'services/database_service.dart';
import 'services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'controllers/product_controller.dart';
import 'models/model.dart';

class NewProductScreen extends StatefulWidget {
  const NewProductScreen({Key? key}) : super(key: key);

  @override
  State<NewProductScreen> createState() => _NewProductScreenState();
}

class _NewProductScreenState extends State<NewProductScreen> {
  final ProductController productController = Get.find();

  StorageService storage = StorageService();
  Notify n = Notify();
  DatabaseService database = DatabaseService();
  String dropdownValue = "Main";
  String title = 'UTM Student';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Product'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Obx(
          () => ListView(
            shrinkWrap: true,
            children: [
              SizedBox(
                height: 100,
                child: Card(
                  margin: EdgeInsets.zero,
                  color: Colors.black,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          ImagePicker picker = ImagePicker();
                          final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery);

                          if (image == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('No Image was selected'),
                              ),
                            );
                          }

                          if (image != null) {
                            await storage.uploadImage(image);

                            var imageUrl =
                                await storage.getDownloadURL(image.name);

                            productController.newProduct.update(
                                'imageUrl', (_) => imageUrl,
                                ifAbsent: () => imageUrl);

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text("Selected image added successfully"),
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.add_circle, color: Colors.white),
                      ),
                      const Text(
                        'Add an Image',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Product Information',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildTextFormField(
                'Product ID',
                'id',
                productController,
              ),
              _buildTextFormField('Product Name', 'name', productController),
              Row(
                children: [
                  const SizedBox(
                    width: 200,
                    child: Text(
                      'Product Category',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    decoration: ThemeHelper().inputBoxDecorationShaddow(),
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      elevation: 16,
                      style: const TextStyle(color: Colors.orange),
                      underline: Container(
                        height: 2,
                        color: Colors.orange,
                      ),
                      onChanged: (String? value) {
                        productController.newProduct.update(
                          'category',
                          (_) => value,
                          ifAbsent: () => value,
                        );
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      items: <String>['Main', 'Appetizers', 'Desserts']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      // onSaved: (value) {
                      //   secondNameController.text = value!;
                      // },
                    ),
                  ),
                ],
              ),
              _buildTextFormField(
                  'Product Description', 'description', productController),
              const SizedBox(height: 10),
              _buildSlider(
                  'Price', 'price', productController, productController.price),
              _buildSlider('Size', 'quantity', productController,
                  productController.quantity),
              const SizedBox(
                height: 10,
              ),
              _buildCheckbox('Recommended', 'isRecommended', productController,
                  productController.isRecommended),
              _buildCheckbox('Popular', 'isPopular', productController,
                  productController.isPopular),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (productController.newProduct.keys.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text("Please fill in with approperiate values."),
                        ),
                      );
                      return;
                    }
                    try {
                      database.addProduct(
                        Product(
                          id: int.parse(productController.newProduct['id']),
                          name: productController.newProduct['name'],
                          category: productController.newProduct['category'],
                          description:
                              productController.newProduct['description'],
                          imageUrl: productController.newProduct['imageUrl'],
                          isRecommended:
                              productController.newProduct['isRecommended'],
                          isPopular: productController.newProduct['isPopular'],
                          price: productController.newProduct['price'],
                          quantity:
                              productController.newProduct['quantity'].toInt(),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Meal created successfully."),
                        ),
                      );
                      setState(() {
                        n.productNotification(
                            title: "New meal for you",
                            body: "Admin add a new meal for you, try it Now!");
                      });
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => ProductsScreen()),
                          (Route<dynamic> route) => false);
                    } on Exception {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Exceptional error occured"),
                        ),
                      );
                      // print(e);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildCheckbox(
    String title,
    String name,
    ProductController productController,
    bool? controllerValue,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 125,
          child: Text(title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              )),
        ),
        Checkbox(
          value: (controllerValue == null) ? false : controllerValue,
          checkColor: Colors.black,
          activeColor: Colors.black12,
          onChanged: (value) {
            productController.newProduct.update(
              name,
              (_) => value,
              ifAbsent: () => value,
            );
          },
        ),
      ],
    );
  }

  Row _buildSlider(
    String title,
    String name,
    ProductController productController,
    num? controllerValue,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 75,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Slider(
            value: (controllerValue == null) ? 0 : controllerValue.toDouble(),
            min: 0,
            max: 25,
            divisions: 10,
            activeColor: Colors.black,
            inactiveColor: Colors.black12,
            onChanged: (value) {
              productController.newProduct.update(
                name,
                (_) => value,
                ifAbsent: () => value,
              );
            },
          ),
        ),
      ],
    );
  }

  TextFormField _buildTextFormField(
    String hintText,
    String name,
    ProductController productController,
  ) {
    return TextFormField(
      decoration: InputDecoration(hintText: hintText),
      onChanged: (value) {
        productController.newProduct.update(
          name,
          (_) => value,
          ifAbsent: () => value,
        );
      },
      validator: (val) {
        if (val!.isEmpty) {
          Fluttertoast.showToast(msg: "$name is required for create product");
        }
        return null;
      },
    );
  }
}
