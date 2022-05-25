import 'package:flutter/material.dart';

class Product {
  final String? image, title, description;
  final int? price, size, id;
  final Color? color;
  Product({
    this.id,
    this.image,
    this.title,
    this.price,
    this.description,
    this.size,
    this.color,
  });
}

List<Product> products = [
  Product(
      id: 1,
      title: "Nasi Lemak",
      price: 10,
      size: 12,
      description: dummyText,
      image: "assets/images/food1.png",
      color: const Color.fromARGB(255, 41, 41, 41)),
  Product(
      id: 2,
      title: "MY Pizza",
      price: 14,
      size: 8,
      description: dummyText,
      image: "assets/images/food2.png",
      color: const Color.fromARGB(255, 255, 124, 17)),
  Product(
      id: 3,
      title: "Laksa",
      price: 8,
      size: 10,
      description: dummyText,
      image: "assets/images/food3.png",
      color: const Color.fromARGB(255, 255, 124, 17)),
  Product(
      id: 4,
      title: "Satay",
      price: 8,
      size: 11,
      description: dummyText,
      image: "assets/images/food4.png",
      color: const Color.fromARGB(255, 41, 41, 41)),
  Product(
      id: 5,
      title: "Roti Canai",
      price: 5,
      size: 12,
      description: dummyText,
      image: "assets/images/food5.png",
      color: const Color.fromARGB(255, 41, 41, 41)),
  Product(
    id: 6,
    title: "Keropok Lekor",
    price: 12,
    size: 12,
    description: dummyText,
    image: "assets/images/food6.png",
    color: const Color.fromARGB(255, 255, 124, 17),
  ),
];

String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
