import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../constants/kcolors.dart';
import '../models/cart_items.dart';
import '../widgets/customgrid_card.dart';

class CartScreen extends StatefulWidget {
  final ZoomDrawerController? zoomController; // Add this line
  final CartItem? card;


  const CartScreen({Key? key,  this.zoomController, this.card}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {


  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  void startSearch() {
    setState(() {
      isSearching = true;
    });
  }

  void endSearch() {
    setState(() {
      isSearching = false;
    });
    searchController.clear();
  }

  void performSearch(String query) {
    //search logic here
  }
  void _handleKeyEvent(RawKeyEvent event) {
    if (event is RawKeyUpEvent) {
      if (event.logicalKey == LogicalKeyboardKey.enter) {
        // When the Enter key is pressed, initiate the search
        performSearch(searchController.text);
      }
    }
  }

  void removeFromCart(CartItem product, BuildContext context){
    final cartProvider = Provider.of<CartProvider>(context);
  cartProvider.removeFromCart(product);
  }

  @override
  Widget build(BuildContext context) {
    // final cartProvider = Provider.of<CartProvider>(context);

    return Consumer<CartProvider>(
        builder: (context, cartProvider, child) =>

          Scaffold(
          appBar: AppBar(
            leading: isSearching
                ? IconButton(
                    icon: Icon(
                      FontAwesomeIcons.xmark,
                      color: Colors.white,
                    ),
                    onPressed: endSearch,
                  )
                : IconButton(
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
            title: isSearching
                ? RawKeyboardListener(
                    focusNode: FocusNode(),
                    onKey: _handleKeyEvent,
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),),
                    ),
                  )
                : Text("OrevaHardware", style: AppTextStyles.appBarTextStyle),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child:
                    IconButton(
                      icon: Icon(Icons.search,
                          color: Kcolor.secondaryColor, size: 25),
                      onPressed: startSearch,
                    ),
              ),
            ],
          ),

          body: SafeArea(
            child: ListView(
              children: [
                cartProvider.cartItems.isEmpty
               ? Container(
                  child:       Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 50,),
                      Text('Your cart is empty', style: AppTextStyles.headerTextStyle,), SizedBox(height: 30,),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(color: Kcolor.primaryColor,
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Center(
                            child:  Text('Continue shopping', style: AppTextStyles.textButtonTextStyle,),
                          ),
                        ),
                      ),
                      SizedBox(height: 50,),
                      // Text('Have an account?', style: AppTextStyles.secondaryTextStyle,), SizedBox(height: 10,),
                      // Text('Log in to check out faster.', style: AppTextStyles.descriptionTextStyle,),

                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Your cart', style: AppTextStyles.headerTextStyle,),
                                Text(
                                  'Continue shopping',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,

                                      color: Kcolor.secondaryTextColor,
                                      letterSpacing: 2,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Product', style: AppTextStyles.descriptionTextStyle,),
                                Text(
                                  'Total',
                                  style: TextStyle(
                                      color: Kcolor.secondaryTextColor,
                                      letterSpacing: 2,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
  ]
                )
          )

                     : SizedBox(height: 5,),
                Container(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: cartProvider.cartItems.length,
                          itemBuilder: (ctx, index) {
                            final cartItem = cartProvider.cartItems[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: CustomCartProductDisplay(cart: cartItem,),
                            );
                          },
                        )

                      ),
                    ],
                  ),
                )
            ),
    );
  }
}
