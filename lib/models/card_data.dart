class CardModel {
  String image;
  String price;
  String description;

  CardModel(
      {required this.price,
        required this.image,
        required this.description});
}

List<CardModel> myCards = [
  CardModel(
      price: '\$149,00',
      image: 'assets/21.jpeg',
      description:
          'Leather finished hanging poles With and rust and noise free'),
  CardModel(
      price: '\$129,00',
      image: 'assets/18.jpg',
      description:
          'Leather finished hanging poles With and rust and noise free'),
  CardModel(
      price: '\$149,00',
      image: 'assets/21.jpeg',
      description:
          'Leather finished hanging poles With and rust and noise free'),
  CardModel(
      price: '\$129,00',
      image: 'assets/18.jpg',
      description:
          'Leather finished hanging poles With and rust and noise free'),
];




class CartModel {
  String image;
  double price;
  String totalPrice;
  String description;

  CartModel(
      {required this.price,
      required this.totalPrice,
      required this.image,
      required this.description});
}

List<CartModel> myCarts = [
  CartModel(
      price: 12,
      image: 'assets/21.jpeg',
      description:
          'Leather finished hanging poles With and rust and noise free',
      totalPrice: '\$400.00'),
  CartModel(
      price: 60,
      image: 'assets/18.jpg',
      description:
          'Leather finished hanging poles With and rust and noise free',
      totalPrice: '\$290.00'),
  CartModel(
      price: 2,
      image: 'assets/21.jpeg',
      description:
          'Leather finished hanging poles With and rust and noise free',
      totalPrice: '\$890.00'),
  CartModel(
      price: 900,
      image: 'assets/18.jpg',
      description:
          'Leather finished hanging poles With and rust and noise free',
      totalPrice: '\$240.00'),
];


/// customer cart
List<CartModel> _cart = [];


///  getter methods
List<CartModel> get  cartMenu => myCarts;
List<CartModel> get  cart => _cart;



/// add to cart



/// remove from cart









































