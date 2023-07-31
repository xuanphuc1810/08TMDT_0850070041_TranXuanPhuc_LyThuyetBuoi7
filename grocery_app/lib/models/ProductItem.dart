// ignore_for_file: file_names

import 'Product.dart';

class ProductItem {
  int quantity;
  final Product? product;

  ProductItem({this.quantity = 1, required this.product});

  void increment() {
    quantity++;
  }

  // void add() {}

  // void substract() {}
}
