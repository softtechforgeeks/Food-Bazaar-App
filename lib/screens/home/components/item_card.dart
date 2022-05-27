import 'package:flutter/material.dart';
import 'package:flutter_login_ui/models/product_model.dart';

import '../../../constants.dart';

class ItemCard extends StatelessWidget {
  final Product? product;
  final Function? press;
  const ItemCard({
    Key? key,
    this.product,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press as void Function()?,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(kDefaultPaddin),
              // For  demo we use fixed height  and width
              // Now we dont need them
              // height: 180,
              // width: 160,
              decoration: BoxDecoration(
                color: (product!.isRecommended == true)
                    ? const Color.fromARGB(255, 255, 124, 17)
                    : const Color.fromARGB(255, 41, 41, 41),
                borderRadius: BorderRadius.circular(16),
              ),
              child: SizedBox(
                height: 200,
                child: Image.network(
                  product!.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
            child: Text(
              // products is out demo list
              product!.name,
              style: const TextStyle(color: kTextLightColor),
            ),
          ),
          Text(
            "\$${product!.price}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
