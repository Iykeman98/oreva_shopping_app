import 'package:flutter/material.dart';

class CartItem {
  String? image;
  String? name;
  double? price;
  String? totalPrice;
  String? description;
  CartItem? product;
  int quantity;

  CartItem(
      {this.product,
        this.name,
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
      name:"Pole",
        price: 120000,
        image: 'assets/21.jpeg',
        description:
            'Leather finished hanging poles With and rust and noise free',
        totalPrice: '\$400.00'),
    CartItem(
        name:"Bolts",
        price: 60,
        image: 'assets/18.jpg',
        description:
            'Leather finished hanging poles With and rust and noise free',
        totalPrice: '\$290.00'),
    CartItem(
        name:"Sinks",
        price: 2,
        image: 'assets/21.jpeg',
        description:
            'Leather finished hanging poles With and rust and noise free',
        totalPrice: '\$890.00'),
    CartItem(
        name:"Drawer",
        price: 900,
        image: 'assets/18.jpg',
        description:
            'Leather finished hanging poles With and rust and noise free',
        totalPrice: '\$240.00'), CartItem(
      name:"Pole",
        price: 120000,
        image: 'assets/21.jpeg',
        description:
            'Leather finished hanging poles With and rust and noise free',
        totalPrice: '\$400.00'),
    CartItem(
        name:"Bolts",
        price: 60,
        image: 'assets/18.jpg',
        description:
            'Leather finished hanging poles With and rust and noise free',
        totalPrice: '\$290.00'),
    CartItem(
        name:"Sinks",
        price: 2,
        image: 'assets/21.jpeg',
        description:
            'Leather finished hanging poles With and rust and noise free',
        totalPrice: '\$890.00'),
    CartItem(
        name:"Drawer",
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

    final newCartItem = CartItem(
      product: product,
      price: product.price,
      name: product.name,
      image: product.image,
      description: product.description,
      totalPrice: product.totalPrice,
      quantity: 1, // Start with a quantity of 1 for a new item
    );
    _cartItems.add(newCartItem);
    notifyListeners(); // Notify the UI that the cart has been updated
  }

  // void removeFromCart(CartItem product) {
  //   for (var item in _cartItems) {
  //     if (item.product == product) {
  //       if (item.quantity > 1) {
  //         item.quantity--;
  //       } else {
  //         _cartItems.remove(item);
  //       }
  //       notifyListeners();
  //       return;
  //     }
  //   }
  // }

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

  void removeFromCart(CartItem product) {
    for (var item in _cartItems) {
      if (item.product == product) {
        if (item.quantity > 1) {
          item.quantity--;
        } else {
          _cartItems.remove(item);
        }
        notifyListeners(); // Notify the UI that the cart has been updated
        return;
      }

    }
  }
  double getTotalPrice() {
    double totalPrice = 0.0;
    for (var item in _cartItems) {
      totalPrice += (item.product!.price! * item.quantity)!;
    }
    return totalPrice;
  }

}
