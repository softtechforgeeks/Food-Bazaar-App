import 'package:flutter/material.dart';
import 'package:flutter_login_ui/constants.dart';
import 'package:flutter_login_ui/controllers/product_controller.dart';
import 'package:flutter_login_ui/screens/details/details_screen.dart';
import 'package:get/get.dart';

import 'item_card.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int idx = 0;
  List<String> categoryList = ["All", "Main", "Appetizers", "Desserts"];
  ProductController productController = Get.put(ProductController(type: 'All'));

  @override
  Widget build(BuildContext context) {
    var products = productController.products;

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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
          child: SizedBox(
            height: 25,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryList.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  setState(() {
                    products =
                        RxList(productController.onUpdate(categoryList[index]));
                    // print(index);
                    idx = index;
                    // productController.onUpdate(categoryList[idx]);
                    // print(categoryList[idx]);
                    // print('set state');
                    // print(products.length);
                  });
                  setState(() {});
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        categoryList[index],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: idx == index ? kTextColor : kTextLightColor,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            top: kDefaultPaddin / 4), //top padding 5
                        height: 2,
                        width: 30,
                        color: idx == index ? Colors.black : Colors.transparent,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: GridView.builder(
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: kDefaultPaddin,
                  crossAxisSpacing: kDefaultPaddin,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) => ItemCard(
                      product: products[index],
                      press: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                              product: products[index],
                            ),
                          )),
                    )),
          ),
        ),
      ],
    );
  }
}
