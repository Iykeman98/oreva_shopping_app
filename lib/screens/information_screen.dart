import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/kcolors.dart';

class InfoScreen extends StatefulWidget {
  final ZoomDrawerController zoomController;

  const InfoScreen({Key? key,required this.zoomController}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Kcolor.secondaryColor,
          ),
          onPressed: () {
            widget.zoomController.toggle!(); // Open the drawer
          },
        ),
        backgroundColor: Kcolor.primaryColor,
        centerTitle: true,
        title: Text("OrevaHardware", style: AppTextStyles.appBarTextStyle),
      ),
      body: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Divider(
                      color: Kcolor.secondaryColor,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Info',
                      style: AppTextStyles.headerTextStyle,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'About us',
                      style: AppTextStyles.secondaryTextStyle,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Return & Refund',
                      style: AppTextStyles.secondaryTextStyle,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Shipping Policy',
                      style: AppTextStyles.secondaryTextStyle,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Privacy Policy',
                      style: AppTextStyles.secondaryTextStyle,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Terms of Service',
                      style: AppTextStyles.secondaryTextStyle,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Do not Sell My Personal Information',
                      style: AppTextStyles.secondaryTextStyle,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Quick links',
                      style: AppTextStyles.headerTextStyle,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'FAQ',
                      style: AppTextStyles.secondaryTextStyle,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Installation',
                      style: AppTextStyles.secondaryTextStyle,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Track Your Order',
                      style: AppTextStyles.secondaryTextStyle,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Contact Us',
                      style: AppTextStyles.secondaryTextStyle,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Our mission',
                      style: AppTextStyles.headerTextStyle,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Our unwavering dedication is to supply you with premium kitchen and bathroom products that not only enhance the functionality of your spaces but also enrich your daily life',
                      style: AppTextStyles.descriptionTextStyle,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            FontAwesomeIcons.facebook,
                            color: Kcolor.primaryColor,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(
                            FontAwesomeIcons.instagram,
                            color: Kcolor.primaryColor,
                          ),
                          onPressed: () {
                            print('ig');
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            FontAwesomeIcons.youtube,
                            color: Kcolor.primaryColor,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Divider(
                      color: Kcolor.secondaryColor,
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}


class MyDrawer extends StatelessWidget {
  final VoidCallback launchInstagram;

  MyDrawer({required this.launchInstagram});

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

          SizedBox(
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.supervised_user_circle_rounded),
                  onPressed: () {},
                ),
                Text(
                  'Log in',
                  style: AppTextStyles.headerTextStyle,
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
                    launchInstagram();
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

