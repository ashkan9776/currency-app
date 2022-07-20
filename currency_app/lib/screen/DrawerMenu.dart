import 'package:currency_app/Menu_Item.dart';
import 'package:currency_app/screen/MenuPage.dart';
import 'package:currency_app/screen/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  menuItem currentItem = MenuItems.payment;
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      menuScreen: MenuPage(
          currentItem: currentItem,
          onSelectedItem: (item) {
            setState(() {
              currentItem = item;
            });
          }),
      mainScreen: HomeScreen(),
      style: DrawerStyle.defaultStyle,
      angle: -10,
      slideWidth: MediaQuery.of(context).size.width * 0.5,
      borderRadius: 40,
      menuBackgroundColor: Colors.blue,
      drawerShadowsBackgroundColor: Color(0xffffffffff),
      shadowLayer1Color: Color(0xffffffffff),
      shadowLayer2Color: Color(0xffffffffff),
    );
  }
}
