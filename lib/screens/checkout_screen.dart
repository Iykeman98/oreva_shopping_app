import 'package:expandable/expandable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/src/drawer_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:orevahardware/widgets/custom_flat_button.dart';
import 'package:orevahardware/widgets/dismissKeyboardOnTap.dart';
import 'package:orevahardware/widgets/formfield.dart';

import '../constants/kcolors.dart';
import '../models/card_data.dart';
import '../widgets/custom_summary_list_tile.dart';

class CheckOut extends StatefulWidget {
  final CartModel? selectedProduct;
  final ZoomDrawerController? zoomController;

  const CheckOut({Key? key, this.selectedProduct,  this.zoomController}) : super(key: key);

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  ExpandableController _controller = ExpandableController();
  bool isChecked = false;
  bool showOrderSummary = false;



  void toggleCheckbox(bool value) {
    setState(() {
      isChecked = value;
    });
  }


  void toggleOrderSummary() {
    setState(() {
      showOrderSummary = !showOrderSummary;
    });
  }
  @override
  void initState() {
    super.initState();
    _controller.expanded = true;
  }

  bool isUserAuthenticated = FirebaseAuth.instance.currentUser != null;

      @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DismissKeyboardOnTap(
        child: CustomScrollView(
          slivers: <Widget>[
            // Add SliverAppBar here
            SliverAppBar(
              // Customize the SliverAppBar properties
              expandedHeight: 100.0, // Adjust as needed
              floating: false, // Set to true if you want the app bar to remain visible when scrolling
              pinned: true, // Set to true if you want the app bar to collapse and remain pinned at the top when scrolling
              flexibleSpace: FlexibleSpaceBar(
                title: Text('CheckOut', style: AppTextStyles.appBarTextStyle),
                centerTitle: true,
              ),
              leading:  IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Kcolor.secondaryColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
                   SliverToBoxAdapter(
                     child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(right: 20,left: 20),
                          color: Kcolor.secondaryColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text('Show order summary', style: AppTextStyles.descriptionTextStyle2,),
                                  IconButton(
                                      onPressed:toggleOrderSummary,
                                      icon: Icon(
                                      showOrderSummary
                                      ? FontAwesomeIcons.chevronUp
                                      : FontAwesomeIcons.chevronDown,
                                      size:13,color:Kcolor.primaryColor),
                                  )
                                ],
                              ),
                              Text('\$148.99', style: AppTextStyles.formFieldHintTextStyle,),
                            ],
                          ),

                          height: 70,
                        ),
                        showOrderSummary
                            ? Container(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Container(
                                // height: 200,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: myCarts.length,
                                    itemBuilder: (BuildContext context, int index){

                                      final myCartss = myCarts[index];

                                      return OrderSummaryListTile(cart: myCartss);
                                    }),
                              ),
                              SizedBox(height: 10),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.height * 0.35,
                                    child: TextField(
                                      style: AppTextStyles.formFieldTextStyle,
                                      decoration: InputDecoration(
                                        label: Text(
                                          "Discount code",
                                        ),
                                        labelStyle: TextStyle(
                                          color: Kcolor.secondaryTextColor,
                                          letterSpacing: 1,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                        hintText: "Discount code",
                                        hintStyle: AppTextStyles.formFieldHintTextStyle,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5.0),
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(

                                    child: Container(
                                      height: 51,
                                      width: 65,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                        child: Text('Apply', style: AppTextStyles.descriptionTextStyle,),
                                      ),
                                    ),
                                  )
                                ],
                              ),                          SizedBox(height: 30),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Subtotal', style: AppTextStyles.descriptionTextStyle,),
                                  Text('\$598.00', style: AppTextStyles.addToTextStyle,),
                                ],
                              ),                         SizedBox(height: 10),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Shipping', style: AppTextStyles.descriptionTextStyle,),
                                  Text('Enter shipping address', style: AppTextStyles.descriptionTextStyle,),
                                ],
                              ),                     SizedBox(height: 10),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Shipping', style: AppTextStyles.descriptionTextStyle,),
                                  Row(
                                    children: [
                                      Text('USD', style: AppTextStyles.descriptionTextStyle,),
                                      Text('\$598.00', style: AppTextStyles.addToTextStyle,),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ): SizedBox(height: 8,),
                        Padding(padding: EdgeInsets.only(right: 20,left: 20,top: 10),
                        child: Column(
                          children: [
                            Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Express CheckOut', style: AppTextStyles.descriptionTextStyle,),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomFlatButton(text: "PayPal", width: 180,),
                                CustomFlatButton(text: "@ Pay", width: 180,),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(child: Divider( color: Colors.grey, )),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('OR', style: AppTextStyles.descriptionTextStyle,),
                                ),
                                Expanded(child: Divider( color: Colors.grey, )),
                              ],
                            ),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Contact', style: AppTextStyles.headerTextStyle,),
                                Row(
                                  children: [
                                    Text('Have an account?', style: AppTextStyles.descriptionTextStyle,),
                                    Text('Log in', style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Kcolor.primaryColor,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,)),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            CustomFormField(onTap: null, label: "Email", hintText: 'Email'),
                            Row(mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(

                                  checkColor: Kcolor.primaryColor,
                                  // fillColor: Kcolor.secondaryColor,
                                  value: isChecked,
                                  onChanged:  (bool? value) {
                                    toggleCheckbox(value ?? false); // Use the value with null safety
                                  },
                                ),
                                Text('Wish to receive newsletter?', style: AppTextStyles.descriptionTextStyle,),

                              ],
                            ),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                        ),
                        Divider(thickness: 10, color: Kcolor.secondaryColor,),
                        Padding(padding: EdgeInsets.only(right: 20,left: 20,top: 20,bottom: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Contact', style: AppTextStyles.headerTextStyle,),
                            CustomFormField(onTap: (){}, label: 'First name', hintText: 'First name'),
                            CustomFormField(onTap: (){}, label: 'Last name', hintText: 'Last name'),
                            CustomFormField(onTap: (){}, label: 'Company (optional)', hintText: 'Company (optional)'),
                            CustomFormField(onTap: (){}, label: 'Address', hintText: 'Address', suffixIcon: FontAwesomeIcons.magnifyingGlass, ),
                            SizedBox(height: 10,),
                            Row(mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(FontAwesomeIcons.plus,size: 12,color: Kcolor.primaryColor,),SizedBox(width: 2,),
                                Text('Add apartment,suite, etc', style: AppTextStyles.descriptionTextStyle2,),
                              ],
                            ),
                            SizedBox(height: 10,),
                            CustomFormField(onTap: (){}, label: 'Company (optional)', hintText: 'Company (optional)'),
                            CustomFormField(onTap: (){}, label: 'Address', hintText: 'Address', suffixIcon: FontAwesomeIcons.chevronDown, ),
                            CustomFormField(onTap: (){}, label: 'Company (optional)', hintText: 'Company (optional)'),
                            CustomFormField(onTap: (){}, label: 'Address', hintText: 'Address', suffixIcon: FontAwesomeIcons.circleQuestion, ),
                            Row(mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(

                                  checkColor: Kcolor.primaryColor,
                                  // fillColor: Kcolor.secondaryColor,
                                  value: isChecked,
                                  onChanged:  (bool? value) {
                                    toggleCheckbox(value ?? false); // Use the value with null safety
                                  },
                                ),
                                Text('Save this information for next time', style: AppTextStyles.descriptionTextStyle,),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Text('Shipping method', style: AppTextStyles.headerTextStyle,),
                            SizedBox(height: 10,),
                            Container(
                              color: Colors.grey[200],
                              height: 65,
                              child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Center(child: Text('Enter your shipping address to view available shipping methods', style: AppTextStyles.descriptionTextStyle,))),
                            )
                          ],
                        ),
                        ),
                        Divider(thickness: 10, color: Kcolor.secondaryColor,),
                        Padding(
                          padding: EdgeInsets.only(right: 20,left: 20,top: 10),
                          child:Column(

                            children: [
                              Container(
                                child: ExpandablePanel(
                                  collapsed: Container(
                                    // height: 200,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: myCarts.length,
                                        itemBuilder: (BuildContext context, int index){
                                          final myCartss = myCarts[index];

                                          return OrderSummaryListTile(cart: myCartss);
                                        }),
                                  ),
                                  expanded: Text(''),
                                  controller: _controller,
                                  header: Text('Order summary', style: AppTextStyles.headerTextStyle,),
                                ),
                              ),                          SizedBox(height: 10),

                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.height * 0.35,
                                    child: TextField(
                                      style: AppTextStyles.formFieldTextStyle,
                                      decoration: InputDecoration(
                                          label: Text(
                                            "Discount code",
                                          ),
                                          labelStyle: TextStyle(
                                            color: Kcolor.secondaryTextColor,
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                          ),
                                          hintText: "Discount code",
                                          hintStyle: AppTextStyles.formFieldHintTextStyle,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5.0),
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(

                                    child: Container(
                                      height: 51,
                                      width: 65,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                        child: Text('Apply', style: AppTextStyles.descriptionTextStyle,),
                                      ),
                                    ),
                                  )
                                ],
                              ),                          SizedBox(height: 30),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Subtotal', style: AppTextStyles.descriptionTextStyle,),
                                  Text('\$598.00', style: AppTextStyles.addToTextStyle,),
                                ],
                              ),                         SizedBox(height: 10),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Shipping', style: AppTextStyles.descriptionTextStyle,),
                                  Text('Enter shipping address', style: AppTextStyles.descriptionTextStyle,),
                                ],
                              ),                     SizedBox(height: 10),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Shipping', style: AppTextStyles.descriptionTextStyle,),
                                  Row(
                                    children: [
                                      Text('USD', style: AppTextStyles.descriptionTextStyle,),
                                      Text('\$598.00', style: AppTextStyles.addToTextStyle,),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              CustomFlatButton(text: "Pay now",
                                  width: MediaQuery.of(context).size.height * 1,
                                  onTap: (){
                                if(isUserAuthenticated){
                                  print('user is checked in');
                                }else{
                                  print('please log  in');
                                }
                              }),
                              SizedBox(height: 20),

                            ],
                          ),
                        ),
                        Divider()
                      ],
                  ),
                   ),




          ],
        ),
      ),
    );

  }
}

