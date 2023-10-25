import 'package:flutter/material.dart';

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
          leading: Image(image: AssetImage(widget.cart.image),),
          title: Text(widget.cart.description),
          subtitle: Text(widget.cart.price.toString(), style: AppTextStyles.descriptionTextStyle2,),
          trailing: Text(widget.cart.totalPrice),
        ),
      ),
    );
  }
}
