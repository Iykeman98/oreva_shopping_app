import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:orevahardware/constants/kcolors.dart';
import 'package:provider/provider.dart';

import '../models/cart_items.dart';
import '../screens/ProductDetailScreen.dart';

class CustomProductDisplayCard extends StatefulWidget {
  const CustomProductDisplayCard({Key? key, required this.card,   this.zoomController}) : super(key: key);
  final CartItem card;
  final ZoomDrawerController? zoomController;

  @override
  State<CustomProductDisplayCard> createState() => _CustomProductDisplayCardState();
}

class _CustomProductDisplayCardState extends State<CustomProductDisplayCard> {
  @override
  Widget build(BuildContext context) {

    return  GestureDetector(
      onTap: () {
        // Navigate to the ProductDetail screen and pass the selected product details
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetail(
              selectedProduct: widget.card, // Pass the selected product here
            ),
          ),
        );
      },
      child: Container(
          height:  MediaQuery.of(context).size.height * 1,
          width: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Image(image: AssetImage(widget.card.image!)),
          SizedBox(height: 10,),
          Text(widget.card.name!, style:AppTextStyles.descriptionTextStyle3 ,),
          Text(widget.card.description!, style: AppTextStyles.descriptionTextStyle,maxLines: 2,),
            SizedBox(height: 10,),
            Row(
              children: [
                Text('\₦',style: AppTextStyles.descriptionTextStyle3,),
                Text(widget.card.price.toString(),style: AppTextStyles.secondaryTextStyle,),
              ],
            ),
          ],
      ),),
    );
  }
}




class CustomCartProductDisplay extends StatefulWidget {
  const CustomCartProductDisplay({Key? key, required this.cart,}) : super(key: key);
  final CartItem cart;



  @override
  State<CustomCartProductDisplay> createState() => _CustomCartProductDisplayState();
}


class _CustomCartProductDisplayState extends State<CustomCartProductDisplay> {


  int quantity = 1; // State variable to track the quantity
  double totalAmount  = 0.0;

  // Function to increment the quantity
  void incrementQuantity() {
    setState(() {
      quantity++;
      updateTotalAmount();
    });
  }


  // Function to decrement the quantity
  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        updateTotalAmount();
      });
    }
  }

  void updateTotalAmount() {
    setState(() {
      totalAmount = quantity * widget.cart.price!.toDouble();
    });
  }


  @override
  void initState() {
    super.initState();
    updateTotalAmount(); // Initialize totalAmount
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return  Container(
      color: Colors.grey[200],
      padding: EdgeInsets.all(10),
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image(image: AssetImage(widget.cart.image ?? ""),
                    // height: 140,
                    fit: BoxFit.contain,),
                  // Text(widget.cart.totalPrice ?? '',style: AppTextStyles.descriptionTextStyle2,),
                  Row(
                    children: [
                      Text('\₦',style: AppTextStyles.descriptionTextStyle3,),
                      Text(widget.cart.price.toString(),style: AppTextStyles.descriptionTextStyle2,),
                    ],
                  ),

                ],
              ),
            ),
          ),
          SizedBox(width: 10,),
          Expanded(
            flex: 2,
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(widget.cart.name ?? "N/A",style: AppTextStyles.descriptionTextStyle3,),
                Text(widget.cart.name ?? "N/A",style: AppTextStyles.descriptionTextStyle3,),
                Expanded(child: Container(child: Text(widget.cart.description ?? "N/A",style: AppTextStyles.descriptionTextStyle4,),width: 150,)),
                // Expanded(child: Container(child: width: 150,)),
                // Text(widget.selectedProduct!.name!, style:AppTextStyles.descriptionTextStyle3 ,),

                Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Kcolor.secondaryColor,
                    // border: Border.all(
                    //   color: Kcolor.primaryColor,
                    // )
                  ),
                  width: 80,
                  child: Padding(
                    padding: const EdgeInsets.only(top:3.0, bottom: 3, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: decrementQuantity,
                          child: Text(
                            '-',
                            style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold ),
                          ),
                        ),
                        Text(
                          '$quantity', // Display the current quantity
                          style: TextStyle(fontSize: 15, color: Kcolor.primaryColor,fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: incrementQuantity,
                          child: Text(
                            '+',
                            style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                )

              ],
            ),
          ),

          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                'Total: \₦${totalAmount.toStringAsFixed(2)}', style: TextStyle(fontSize: 12),),
                IconButton(onPressed: (){
                  cartProvider.removeFromCart(widget.cart);
                  print("Delete button pressed for item: ${widget.cart.description}");
                }, icon: Icon(FontAwesomeIcons.trash,size: 15, color: Colors.red[400],),)

                  ],
            ),
          )
        ],
      ),
    );
  }
}
