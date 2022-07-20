import 'package:currency_app/Menu_Item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MenuItems {
  static const payment = menuItem('Payment', Icons.payment);
  static const promos = menuItem('Promos', Icons.card_giftcard);
  static const notification = menuItem('Notification', Icons.notification_add);
  static const help = menuItem('Help', Icons.help);
  static const aboutUs = menuItem('About Us', Icons.info_outline);
  static const rateUs = menuItem('Rate Us', Icons.star_border);

  static const all = <menuItem>[
    payment,
    promos,
    notification,
    help,
    aboutUs,
    rateUs,
  ];
}

class MenuPage extends StatelessWidget {
  final menuItem currentItem;
  final ValueChanged<menuItem> onSelectedItem;

  const MenuPage(
      {Key? key, required this.currentItem, required this.onSelectedItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            ...MenuItems.all.map(buildMenuItem).toList(),
            Spacer(
              flex: 2,
            ),
          ],
        )),
      ),
    );
  }

  Widget buildMenuItem(menuItem item) => ListTileTheme(
        selectedColor: Colors.white,
        child: ListTile(
          selectedTileColor: Colors.black26,
          selected: currentItem == item,
          minLeadingWidth: 20,
          leading: Icon(item.icon),
          title: Text(item.title),
          onTap: () =>onSelectedItem(item),
        ),
      );
}
