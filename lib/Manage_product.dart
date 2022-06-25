import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/common/theme_helper.dart';
import 'package:flutter_login_ui/services/notify.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'models/model.dart';
import 'package:flutter_login_ui/pages/forgot_password_page.dart';
import 'package:flutter_login_ui/pages/login_page.dart';
import 'package:flutter_login_ui/pages/profile_page.dart';
import 'package:flutter_login_ui/pages/registration_page.dart';
import 'package:flutter_login_ui/pages/splash_screen.dart';
import 'package:flutter_login_ui/services/auth.dart';
import 'package:get/get.dart';

import 'package:flutter_login_ui/new_product_screen.dart';
import 'controllers/product_controller.dart';

class ManageProduct extends StatelessWidget {
  ManageProduct({Key? key}) : super(key: key);
  final ProductController productController =
      Get.put(ProductController(type: 'All'));
  Notify n = Notify();
  final double _drawerIconSize = 24;
  final double _drawerFontSize = 17;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Products'),
        backgroundColor: Colors.orange,
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [
                0.0,
                1.0
              ],
                  colors: [
                Theme.of(context).primaryColor.withOpacity(0.2),
                Theme.of(context).colorScheme.secondary.withOpacity(0.5),
              ])),
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: const [0.0, 1.0],
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).colorScheme.secondary,
                    ],
                  ),
                ),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: const Text(
                    "Food Bazaar",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.screen_lock_landscape_rounded,
                  size: _drawerIconSize,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                title: Text(
                  'Splash Screen',
                  style: TextStyle(
                      fontSize: 17,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const SplashScreen(title: "Splash Screen")));
                },
              ),
              Divider(
                color: Theme.of(context).primaryColor,
                height: 1,
              ),
              ListTile(
                leading: Icon(Icons.login_rounded,
                    size: _drawerIconSize,
                    color: Theme.of(context).colorScheme.secondary),
                title: Text(
                  'Login Page',
                  style: TextStyle(
                      fontSize: _drawerFontSize,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
              ),
              Divider(
                color: Theme.of(context).primaryColor,
                height: 1,
              ),
              ListTile(
                leading: Icon(Icons.person_add_alt_1,
                    size: _drawerIconSize,
                    color: Theme.of(context).colorScheme.secondary),
                title: Text(
                  'Registration Page',
                  style: TextStyle(
                      fontSize: _drawerFontSize,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegistrationPage()),
                  );
                },
              ),
              Divider(
                color: Theme.of(context).primaryColor,
                height: 1,
              ),
              ListTile(
                leading: Icon(
                  Icons.menu_rounded,
                  size: _drawerIconSize,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                title: Text(
                  'Profile Page',
                  style: TextStyle(
                      fontSize: _drawerFontSize,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfilePage()),
                  );
                },
              ),
              Divider(
                color: Theme.of(context).primaryColor,
                height: 1,
              ),
              ListTile(
                leading: Icon(
                  Icons.password_rounded,
                  size: _drawerIconSize,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                title: Text(
                  'Forgot Password Page',
                  style: TextStyle(
                      fontSize: _drawerFontSize,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ForgotPasswordPage()),
                  );
                },
              ),
              // Divider(
              //   color: Theme.of(context).primaryColor,
              //   height: 1,
              // ),
              // ListTile(
              //   leading: Icon(
              //     Icons.verified_user_sharp,
              //     size: _drawerIconSize,
              //     color: Theme.of(context).colorScheme.secondary,
              //   ),
              //   title: Text(
              //     'Verification Page',
              //     style: TextStyle(
              //         fontSize: _drawerFontSize,
              //         color: Theme.of(context).colorScheme.secondary),
              //   ),
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => ForgotPasswordVerificationPage(
              //               email: email, code: code)),
              //     );
              //   },
              // ),
              Divider(
                color: Theme.of(context).primaryColor,
                height: 1,
              ),
              ListTile(
                leading: Icon(
                  Icons.logout_rounded,
                  size: _drawerIconSize,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                      fontSize: _drawerFontSize,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                onTap: () {
                  AuthService().signOut();
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: Card(
                margin: EdgeInsets.zero,
                color: Colors.black,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.to(() => const NewProductScreen());
                      },
                      icon: const Icon(Icons.add_circle, color: Colors.white),
                    ),
                    const Text(
                      'Add a New Product',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: productController.products.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 380,
                      child: ProductCard(
                        product: productController.products[index],
                        index: index,
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  final Product product;
  final int index;

  const ProductCard({
    Key? key,
    required this.product,
    required this.index,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final ProductController productController = Get.find();

  String cate = "Main";

  Notify n = Notify();

  void notifyOnChange() {
    print('before notify');
    n.productNotification(
        title: widget.product.name + " meal changed",
        body: "Admin updated meal's information, check it out");
    print('after notify');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(top: 10),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.product.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(widget.product.category,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(
                height: 10,
              ),
              Text(widget.product.description,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  )),
              Row(
                children: [
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: Image.network(
                      widget.product.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 90,
                            child: Text(
                              'Category',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            child: DropdownButton<String>(
                              value: cate,
                              elevation: 16,
                              style: const TextStyle(color: Colors.orange),
                              underline: Container(
                                height: 2,
                                color: Colors.orange,
                              ),
                              onChanged: (value) {
                                productController.updateProductCategory(
                                  widget.index,
                                  widget.product,
                                  value!,
                                );
                                productController.saveNewProductCategory(
                                    widget.product, 'category', value);
                                setState(() {
                                  notifyOnChange();
                                });
                              },
                              items: <String>[
                                'Main',
                                'Appetizers',
                                'Desserts'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              // onSaved: (value) {
                              //   secondNameController.text = value!;
                              // },
                            ),
                            decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        children: [
                          const SizedBox(
                            width: 90,
                            child: Text(
                              'Description',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 175,
                            child: TextField(
                              onChanged: (value) {
                                productController.updateProductDescription(
                                  widget.index,
                                  widget.product,
                                  value,
                                );
                                productController.saveNewProductDescription(
                                    widget.product, 'description', value);
                                setState(() {
                                  notifyOnChange();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        children: [
                          const SizedBox(
                            width: 50,
                            child: Text(
                              'Price',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 175,
                            child: Slider(
                              value: widget.product.price.toDouble(),
                              min: 0,
                              max: 25,
                              divisions: 10,
                              onChanged: (value) {
                                productController.updateProductPrice(
                                  widget.index,
                                  widget.product,
                                  value,
                                );
                              },
                              onChangeEnd: (value) {
                                productController.saveNewProductPrice(
                                    widget.product, 'price', value);
                                setState(() {
                                  notifyOnChange();
                                });
                              },
                            ),
                          ),
                          Text(
                            '\$${widget.product.price.toStringAsFixed(1)}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 50,
                            child: Text(
                              'Size: ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 175,
                            child: Slider(
                              value: widget.product.quantity.toDouble(),
                              min: 0,
                              max: 30,
                              divisions: 5,
                              activeColor: Colors.black,
                              inactiveColor: Colors.black12,
                              onChanged: (value) {
                                productController.updateProductQuantity(
                                    widget.index,
                                    widget.product,
                                    value.toInt());
                              },
                              onChangeEnd: (value) {
                                productController.saveNewProductQuantity(
                                    widget.product, 'quantity', value.toInt());
                                setState(() {
                                  notifyOnChange();
                                });
                              },
                            ),
                          ),
                          Text(
                            '${widget.product.quantity.toInt()}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 180,
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        alignment: Alignment.topRight,
                        padding: const EdgeInsets.only(right: 20.0),
                        primary: Colors.red,
                        minimumSize: const Size(40, 40),
                        side: const BorderSide(
                          width: 2,
                          color: Colors.red,
                        )),
                    child: const Icon(
                      Icons.delete_sweep_outlined,
                      size: 40,
                    ),
                    onPressed: () {
                      final docProduct = FirebaseFirestore.instance
                          .collection('products')
                          .where('id', isEqualTo: widget.product.id)
                          .get()
                          .then((querySnapshot) =>
                              {querySnapshot.docs.first.reference.delete()});
                      Fluttertoast.showToast(
                        msg: 'Dish deleted successfully!',
                        fontSize: 18,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
