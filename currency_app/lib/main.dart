import 'package:currency_app/provider/CryptoDataProvider.dart';
import 'package:currency_app/provider/DataProvider.dart';
import 'package:currency_app/provider/MarketViewProvider.dart';
import 'package:currency_app/screen/DrawerMenu.dart';
import 'package:currency_app/screen/home_screen.dart';
import 'package:currency_app/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ChangeTheme>(
          create: (context) => ChangeTheme(),
        ),
        ChangeNotifierProvider<CryptoDataProvider>(
          create: (context) => CryptoDataProvider(),
        ),
        ChangeNotifierProvider<MarketViewProvider>(
          create: (context) => MarketViewProvider(),
        ),
      ],
      child: const MainCurrency(),
    ),
  );
}

class MainCurrency extends StatelessWidget {
  const MainCurrency({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MyCustomWidget(),
      ),
    );
  }
}
