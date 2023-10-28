import 'package:flutter/material.dart';


class CartItem {
  String? image;
  double? price;
  String? totalPrice;
  String? description;
  CartItem? product;
  int quantity;

  CartItem(
      {this.product,
      this.quantity = 1,
      this.price,
      this.totalPrice,
      this.image,
      this.description});
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  List<CartItem> myCartItems = [
    CartItem(
        price: 12,
        image: 'assets/21.jpeg',
        description:
            'Leather finished hanging poles With and rust and noise free',
        totalPrice: '\$400.00'),
    CartItem(
        price: 60,
        image: 'assets/18.jpg',
        description:
            'Leather finished hanging poles With and rust and noise free',
        totalPrice: '\$290.00'),
    CartItem(
        price: 2,
        image: 'assets/21.jpeg',
        description:
            'Leather finished hanging poles With and rust and noise free',
        totalPrice: '\$890.00'),
    CartItem(
        price: 900,
        image: 'assets/18.jpg',
        description:
            'Leather finished hanging poles With and rust and noise free',
        totalPrice: '\$240.00'),
  ];

  void addToCart(CartItem product) {
    for (var item in _cartItems) {
      if (item.product == product) {
        item.quantity++;
        notifyListeners();
        return;
      }
    }

    _cartItems.add(CartItem(
        product: product,
        price: product.price,
        image: product.image,
        description: product.description,
        totalPrice: product.totalPrice,
        quantity: product.quantity));
    notifyListeners();
  }



  void removeFromCart(CartItem product) {
    for (var item in _cartItems) {
      if (item.product == product) {
        if (item.quantity > 1) {
          item.quantity--;
        } else {
          _cartItems.remove(item);
        }
        notifyListeners();
        return;
      }
    }
  }

  // void removeFromCart(CartItem product) {
  //   List<CartItem> itemsToRemove = [];
  //   for (var item in _cartItems) {
  //     if (item.product == product) {
  //       if (item.quantity > 1) {
  //         item.quantity--;
  //       } else {
  //         itemsToRemove.add(item);
  //       }
  //     }
  //   }
  //
  //   // Remove the items from the cart
  //   _cartItems.removeWhere((item) => itemsToRemove.contains(item));
  //
  //   notifyListeners();
  // }


  double getTotalPrice() {
    double totalPrice = 0.0;
    for (var item in _cartItems) {
      totalPrice += (item.product!.price! * item.quantity)!;
    }
    return totalPrice;
  }
}

