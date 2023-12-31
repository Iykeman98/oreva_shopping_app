import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:orevahardware/global/common/toast.dart';
import 'package:orevahardware/screens/cartscreen.dart';
import 'package:orevahardware/screens/sign_in_screen.dart';
import 'package:orevahardware/screens/sign_up_screen.dart';
import 'package:orevahardware/widgets/customgrid_card.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/kcolors.dart';
import '../models/cart_items.dart';
import 'information_screen.dart';

class DashBoard extends StatefulWidget {
  final ZoomDrawerController? zoomController;
  final String? instagramUrl;

  const DashBoard({Key? key,  this.instagramUrl,  this.zoomController}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  late String? instagramUrl;
  int productCount = 0;
   List<CartItem>? searchResults;
    CartProvider? cartProvider;




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //initialize the Instagram url when it is created
    instagramUrl = widget.instagramUrl;

   cartProvider != null ? searchResults = List<CartItem>.from(cartProvider!.myCartItems): print('object'); // Initialize searchResults
    cartProvider = Provider.of<CartProvider>(context, listen: false);
    // cartProvider = CartProvider();  // Initialize the cartProvider
    // cartProvider = Provider.of<CartProvider>(context, listen: false);

  }


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

  void _handleKeyEvent(RawKeyEvent event) {
    if (event is RawKeyUpEvent) {
      if (event.logicalKey == LogicalKeyboardKey.enter) {
        // When the Enter key is pressed, initiate the search
        performSearch(searchController.text);
      }
    }
  }
  void performSearch(String query) {
    List<Map<String, dynamic>> filteredItems = [];
    if (query.isEmpty) {
      // If the query is empty, reset the productCount and show all items
      setState(() {
        productCount = 0;
      });
     final filteredItems = cartProvider!.myCartItems;
    } else {
      // Filter items that match the search query
      final filteredItems = cartProvider!.myCartItems
          .where((item) => item.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    setState(() {
      productCount = filteredItems.length;
      // Update the productCount and reassign the filtered items to the grid
      searchResults = filteredItems.cast<CartItem>();
    });
  }



  void launchInstagram() async {
    final instagramUri = Uri.parse(widget.instagramUrl!);

    if (await canLaunchUrl(instagramUri)) {
      await launchUrl(instagramUri.toString() as Uri);
      print('Instagram launched successfully');

    } else {
      print('Could not launch Instagram');
      throw 'Could not launch Instagram';

    }
  }

  final zoomController = ZoomDrawerController();


  @override
  Widget build(BuildContext context) {
    final cartProvider =  Provider.of<CartProvider>(context);
    return ZoomDrawer(
      menuScreen: MyDrawer(zoomController: zoomController),
      mainScreen: Scaffold(
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
                    Icons.menu,
                    color: Kcolor.secondaryColor,
                  ),
                  onPressed: () {
                    widget.zoomController?.toggle!(); // Open the drawer
                  },
                ),
          backgroundColor: Kcolor.primaryColor,
          centerTitle: true,
          title: isSearching
              ? RawKeyboardListener(
                  focusNode: FocusNode(),
                  onKey: _handleKeyEvent,
                  child: TextField(
                    onChanged: (value) => performSearch(value),
                    style: TextStyle(color: Colors.white),
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
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.search,
                        color: Kcolor.secondaryColor, size: 25),
                    onPressed: startSearch,
                  ),
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
                                      CartScreen(zoomController: widget.zoomController),
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
                                padding: EdgeInsets.all(5),
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
            ),
          ],
        ),
        body: SafeArea(
            child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30, left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Products',
                    style: AppTextStyles.headerTextStyle,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(
                              Icons.keyboard_double_arrow_down,
                              color: Kcolor.secondaryTextColor,
                            ),
                            Text(
                              "Filter and Sort",
                              style: AppTextStyles.secondaryTextStyle,
                            )
                          ],
                        ),
                      ),
                      Text(
                        "$productCount Products",
                        style: AppTextStyles.secondaryTextStyle,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 700,
                    child: GridView.builder(
                        shrinkWrap: false,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        // itemCount: cartProvider.myCartItems.length,
                        itemCount: cartProvider.myCartItems.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 320,
                          crossAxisSpacing: 5,
                        ),
                        itemBuilder: (context, index) {
                          productCount++;
                          return CustomProductDisplayCard(

                              key: UniqueKey(),
                              card: cartProvider.myCartItems[index]
                          );
                        }),
                  ),
                ],
              ),
            )
          ],
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
          },
          backgroundColor: Kcolor.primaryColor,
          foregroundColor: Kcolor.secondaryColor,
          child: Icon(FontAwesomeIcons.solidMessage),
        ),
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  final VoidCallback? launchInstagram;
  final ZoomDrawerController zoomController;
  MyDrawer({ this.launchInstagram, required this.zoomController});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.height * 0.8,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Kcolor.primaryColor,
            ),
            child: Text(
              'OrevaHardware',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: Kcolor.secondaryColor),
            title: Text(
              'Home',
              style: AppTextStyles.secondaryTextStyle,
            ),
            onTap: () {
              // Handle the Home item click
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Kcolor.secondaryColor),
            title: Text(
              'Shop',
              style: AppTextStyles.secondaryTextStyle,
            ),
            onTap: () {
              // Handle the Settings item click
            },
          ),
          ListTile(
            leading: Icon(Icons.home, color: Kcolor.secondaryColor),
            title: Text(
              'Best Seller',
              style: AppTextStyles.secondaryTextStyle,
            ),
            onTap: () {
              // Handle the Home item click
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Kcolor.secondaryColor),
            title: Text(
              'Settings',
              style: AppTextStyles.secondaryTextStyle,
            ),
            onTap: () {
              // Handle the Settings item click
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.info, color: Kcolor.secondaryColor),
            title: Text(
              'Info',
              style: AppTextStyles.secondaryTextStyle,
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>InfoScreen(zoomController: zoomController)));
            },
          ),
          SizedBox(
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.supervised_user_circle_rounded),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> SignInScreen()));
                  },
                ),
                GestureDetector(
                  onTap: (){
                    FirebaseAuth.instance.signOut();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> SignInScreen()));
                    successShowToast(message: "Successfully signed out");
                  },
                  child: Text(
                    'Sign out',
                    style: AppTextStyles.headerTextStyle,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 40,
            color: Kcolor.primaryColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.facebook,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.instagram,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    launchInstagram!();
                    print('ig');
                  },
                ),
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.youtube,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}


MyInstagramButton({instagramUrl = 'https://www.instagram.com/orevahardware/related_profiles/'}) {
  // TODO: implement MyInstagramButton
  throw UnimplementedError();
}