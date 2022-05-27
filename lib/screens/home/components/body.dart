import 'package:flutter/material.dart';
import 'package:flutter_login_ui/constants.dart';
import 'package:flutter_login_ui/controllers/product_controller.dart';
import 'package:flutter_login_ui/models/product_model.dart';
import 'package:flutter_login_ui/screens/details/details_screen.dart';
import 'package:get/get.dart';

import 'categorries.dart';
import 'item_card.dart';

class Body extends StatelessWidget {
  static int idx = 0;
  static setIdx(int index) {
    idx = index;
  }

  @override
  Widget build(BuildContext context) {
    const categories = const Categories(setIdx);
    List<String> categoryList = ["Main", "Appetizers", "Desserts"];
    final ProductController productController = Get.put(ProductController());
    print(productController);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
          child: Text(
            "Menu",
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        categories,
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: GridView.builder(
                itemCount: productController.products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: kDefaultPaddin,
                  crossAxisSpacing: kDefaultPaddin,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) => ItemCard(
                      product: productController.products[index],
                      press: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                              product: productController.products[index],
                            ),
                          )),
                    )),
          ),
        ),
      ],
    );
  }
}
