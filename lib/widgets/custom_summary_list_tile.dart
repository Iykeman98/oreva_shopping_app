import 'package:flutter/material.dart';
import 'package:orevahardware/models/cart_items.dart';

import '../constants/kcolors.dart';
import '../models/card_data.dart';

class OrderSummaryListTile extends StatefulWidget {
  // final String title;
  // final String subTitle;
  // final String leading;
  // final double trailing;
  final CartModel cart;

  const OrderSummaryListTile({
  // super.key, required this.title, required this.subTitle, required this.leading, required this.trailing,
  required this.cart,
  });

  @override
  State<OrderSummaryListTile> createState() => _OrderSummaryListTileState();
}

class _OrderSummaryListTileState extends State<OrderSummaryListTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(top: 10),
      child: Container(
        color: Colors.grey[200],
        child: ListTile(
          leading: Stack(
            children: [
              Image(image: AssetImage(widget.cart.image ?? ''),),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    // quantity.toString(),
                    // style: TextStyle(color: Colors.white),
                    ""
                  ),
                ),
              ),            ],
          ),
          title: Text(widget.cart.description?? "N/A"),
          subtitle: Text(widget.cart.price.toString(), style: AppTextStyles.descriptionTextStyle2,),
          trailing: Text(widget.cart.totalPrice?? ""),
        ),
      ),
    );
  }
}
