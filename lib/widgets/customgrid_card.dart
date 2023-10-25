import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:orevahardware/constants/kcolors.dart';
import 'package:orevahardware/models/card_data.dart';

import '../screens/ProductDetailScreen.dart';

class CustomProductDisplayCard extends StatefulWidget {
  const CustomProductDisplayCard({Key? key, required this.card,  required this.zoomController}) : super(key: key);
  final CardModel card;
  final ZoomDrawerController zoomController;

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
              zoomController: widget.zoomController,
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
          Image(image: AssetImage(widget.card.image)),
          SizedBox(height: 20,),
          Text(widget.card.description, style: AppTextStyles.descriptionTextStyle,maxLines: 2,),
            SizedBox(height: 10,),
            Text(widget.card.price,style: AppTextStyles.secondaryTextStyle,),
          ],
      ),),
    );
  }
}




class CustomCartProductDisplay extends StatefulWidget {
  const CustomCartProductDisplay({Key? key, required this.cart}) : super(key: key);
  final CartModel cart;

  @override
  State<CustomCartProductDisplay> createState() => _CustomCartProductDisplayState();
}


class _CustomCartProductDisplayState extends State<CustomCartProductDisplay> {


  int quantity = 1; // State variable to track the quantity
  double totalAmount  = 0.0;


  //fu
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
      totalAmount = quantity * widget.cart.price;
    });
  }


  @override
  void initState() {
    super.initState();
    updateTotalAmount(); // Initialize totalAmount
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image(image: AssetImage(widget.cart.image), height: 140,),
              Text(widget.cart.totalPrice,style: AppTextStyles.descriptionTextStyle2,),
            ],
          ),
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(child: Text(widget.cart.description),width: 150,),
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Kcolor.primaryColor,
                  )
                ),
                width: 140,
                child: Padding(
                  padding: const EdgeInsets.only(top:3.0, bottom: 3, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: decrementQuantity,
                        child: Text(
                          '-',
                          style: TextStyle(fontSize: 25, color: Kcolor.secondaryColor, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        '$quantity', // Display the current quantity
                        style: TextStyle(fontSize: 22, color: Kcolor.primaryColor, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: incrementQuantity,
                        child: Text(
                          '+',
                          style: TextStyle(fontSize: 25, color: Kcolor.secondaryColor, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              )

            ],
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
              'Total: \$${totalAmount.toStringAsFixed(2)}', style: TextStyle(fontSize: 12),),
              IconButton(onPressed: (){}, icon: Icon(FontAwesomeIcons.trash,size: 15,),)

                ],
          )
        ],
      ),
    );
  }
}
