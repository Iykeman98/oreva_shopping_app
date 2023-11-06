
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:orevahardware/screens/checkout_screen.dart';
import 'package:provider/provider.dart';

import '../constants/kcolors.dart';
import '../models/card_data.dart';
import '../models/cart_items.dart';
import '../widgets/custom_flat_button.dart';
import 'cartscreen.dart';

class ProductDetail extends StatefulWidget {
  final ZoomDrawerController? zoomController;
  final CartItem? selectedProduct;
  final CartModel? selectedcart;

  const ProductDetail(
      {Key? key,  this.zoomController, this.selectedProduct, this.selectedcart})
      : super(key: key);



  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int imageIndex = 0;
  TextEditingController searchController = TextEditingController();
  PageController _pageController = PageController();
  bool selected = false;
  Color containerColor = Kcolor.secondaryColor;
  Color? textColor;
  Color borderColor = Kcolor.primaryColor;

  String selectedCategory = "S";

  void onContainerTapped() {
    setState(() {
      selected = !selected;
      if (selected) {
        containerColor = Kcolor.primaryColor;
        textColor = Colors.white;
        borderColor = Kcolor.primaryColor;
      } else {
        containerColor = Kcolor.secondaryColor;
        textColor = Colors.black;
        borderColor = Kcolor.primaryColor;
      }
    });
  }

  int quantity = 0;

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    setState(() {
      quantity--;
    });
  }

  void nextPage() {
    if (imageIndex < myCards.length - 1) {
      _pageController.animateToPage(imageIndex + 1,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    }
  }

  void previousPage() {
    if (imageIndex > 0) {
      _pageController.animateToPage(imageIndex - 1,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: imageIndex,
      viewportFraction: 0.8,
    );
  }



  Future<void> showCartPrompt(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: IconButton(
            icon: Icon(
              FontAwesomeIcons.xmark,
              color: Colors.red,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Kcolor.secondaryColor,
          title: Text('\$5 products added to cart'),
          content: Text('What would you like to do?'),
          actions: <Widget>[
            TextButton(
              child: Text('View Cart',style: TextStyle(
            decoration: TextDecoration.underline
        ),),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen()));
              },
            ),
            TextButton(
              child: Text('Checkout',style: TextStyle(
        decoration: TextDecoration.underline
        ),),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckOut()));
              },
            ),
            TextButton(
              child: Text('Continue Shopping', style: TextStyle(
                decoration: TextDecoration.underline
              ),),
              onPressed: () {
                // Add the action for continuing shopping here
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Kcolor.secondaryColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Kcolor.primaryColor,
            centerTitle: true,
            title: Text("OrevaHardware", style: AppTextStyles.appBarTextStyle),
            actions: [
              Consumer<CartProvider>(
                builder: (context, cartProvider, child) {
                  int cartItemCount = cartProvider.cartItems.length;
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CartScreen(),
                            ),
                          );
                        },
                        icon: Icon(Icons.shopping_bag_sharp,
                            color: Kcolor.secondaryColor, size: 25),
                      ),
                      if (cartItemCount > 0)
                        Positioned(
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                            constraints: BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              cartItemCount.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
            body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 280,
                              child: PageView(
                                controller: _pageController,
                                scrollDirection: Axis.horizontal,
                                onPageChanged: (index) {
                                  setState(() {
                                    imageIndex = index;
                                  });
                                },
                                children:  cartProvider.myCartItems.map((card) {
                                  return Image.asset(
                                    card.image!,
                                  );
                                }).toList(),
                              ),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.arrow_left,
                                    size: 20,
                                  ),
                                  onPressed: previousPage,
                                ),
                                Text(" ${imageIndex + 1} / ${myCards.length}"),
                                IconButton(
                                  icon: Icon(
                                    Icons.arrow_right,
                                    size: 20,
                                  ),
                                  onPressed: nextPage,
                                ),
                              ],
                            ),
                            // SizedBox(height: 10,),
                            Text(widget.selectedProduct!.name!, style:AppTextStyles.descriptionTextStyle3 ,),

                            Text(
                              widget.selectedProduct!.description!,
                              style: AppTextStyles.headerTextStyle,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    for (int i = 0; i < 5; i++)
                                      Container(
                                        width: 25,
                                        child: Icon(
                                          FontAwesomeIcons.solidStar,
                                          size: 16,
                                          color: Color(0xFFFBC02D),
                                        ),
                                      )
                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "2 Reviews",
                                  style: AppTextStyles.secondaryTextStyle,
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                Text('\₦',style: AppTextStyles.descriptionTextStyle3,),
                                Text(
                                  widget.selectedProduct!.price.toString(),
                                  style: AppTextStyles.secondaryTextStyle,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Colors",
                              style: AppTextStyles.descriptionTextStyle,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedCategory = "S";
                                    });
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      color: selectedCategory == 'S'
                                          ? Kcolor.primaryColor
                                          : containerColor,
                                      border: Border.all(
                                        color: containerColor,
                                      ),
                                      borderRadius: BorderRadius.circular(00),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Silver",
                                        style: TextStyle(
                                          letterSpacing: 2,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: selectedCategory == 'S'
                                              ? Kcolor.primaryTextColor
                                              : Kcolor.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedCategory = "M";
                                    });
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      color: selectedCategory == 'M'
                                          ? Kcolor.primaryColor
                                          : containerColor,
                                      border: Border.all(
                                        color: containerColor,
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Orange",
                                        style: TextStyle(
                                          letterSpacing: 2,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: selectedCategory == 'M'
                                              ? Kcolor.primaryTextColor
                                              : Kcolor.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedCategory = "L";
                                    });
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      color: selectedCategory == 'L'
                                          ? Kcolor.primaryColor
                                          : containerColor,
                                      border: Border.all(
                                        color: containerColor,
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Black",
                                        style: TextStyle(
                                          letterSpacing: 2,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: selectedCategory == 'L'
                                              ? Kcolor.primaryTextColor
                                              : Kcolor.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Quantity",
                              style: AppTextStyles.descriptionTextStyle,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                    color: Kcolor.primaryColor,
                                  )),
                                  width: 100,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 1.0, bottom: 1, left: 10, right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: decrementQuantity,
                                          child: Text(
                                            '-',
                                            style: TextStyle(
                                                fontSize: 25,
                                                color: Kcolor.secondaryColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text(
                                          '$quantity', // Display the current quantity
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Kcolor.primaryColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        GestureDetector(
                                          onTap: incrementQuantity,
                                          child: Text(
                                            '+',
                                            style: TextStyle(
                                                fontSize: 25,
                                                color: Kcolor.secondaryColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    final cartProvider = Provider.of<CartProvider>(context, listen: false);

                                    cartProvider.addToCart(widget.selectedProduct!);
                                    showCartPrompt(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Kcolor.primaryColor,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Add to cart',
                                        style: AppTextStyles.addToTextStyle,
                                      ),
                                    ),
                                    width: 95,
                                    height: 44,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomFlatButton(
                              text: 'Check out',
                              width: MediaQuery.of(context).size.height * .5, zoomController: widget.zoomController,
                              // onTap: () => Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => SignInScreen(zoomController:widget.zoomController),
                              //   ),
                              // ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
