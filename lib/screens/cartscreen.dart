import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:orevahardware/models/card_data.dart';

import '../constants/kcolors.dart';
import '../widgets/customgrid_card.dart';
import 'ProductDetailScreen.dart';

class CartScreen extends StatefulWidget {
  final ZoomDrawerController zoomController; // Add this line
  final CardModel? card;


  const CartScreen({Key? key, required this.zoomController, this.card}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
               Navigator.pop(context);// Open the drawer
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
                      )),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50,),
                Text('Your cart is empty', style: AppTextStyles.headerTextStyle,), SizedBox(height: 30,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            // DashBoard(zoomController: widget.zoomController, instagramUrl: 'https://www.instagram.com/orevahardware/related_profiles/',),
                        ProductDetail(
                          zoomController: widget.zoomController,selectedProduct: widget.card,
                          )
                      ),);
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
                Text('Have an account?', style: AppTextStyles.secondaryTextStyle,), SizedBox(height: 10,),
                Text('Log in to check out faster.', style: AppTextStyles.descriptionTextStyle,),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
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
                  SizedBox(height: 10,),
                  Divider(color: Kcolor.secondaryColor,),
                  SizedBox(height: 20,),
                  Container(
                    // height: 500,
                    child: ListView.builder(
                        itemCount: myCarts.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index){
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: CustomCartProductDisplay(cart: myCarts[index],),
                          );

                        })
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}