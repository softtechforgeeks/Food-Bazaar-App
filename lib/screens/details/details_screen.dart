import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_login_ui/constants.dart';
import 'package:flutter_login_ui/models/product_model.dart';
import 'package:flutter_login_ui/screens/details/components/Single_item_body.dart';

class DetailsScreen extends StatelessWidget {
  final Product? product;

  const DetailsScreen({Key? key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(product!.id);
    return Scaffold(
      // each product have a color
      backgroundColor: (product!.isRecommended == true)
          ? const Color.fromARGB(255, 255, 124, 17)
          : const Color.fromARGB(255, 41, 41, 41),
      appBar: buildAppBar(context),
      body: SingleItemBody(product: product),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: (product!.isRecommended == true)
          ? const Color.fromARGB(255, 255, 124, 17)
          : const Color.fromARGB(255, 41, 41, 41),
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/back.svg',
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset("assets/icons/search.svg"),
          onPressed: () {},
        ),
        IconButton(
          icon: SvgPicture.asset("assets/icons/cart.svg"),
          onPressed: () {},
        ),
        const SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }
}
