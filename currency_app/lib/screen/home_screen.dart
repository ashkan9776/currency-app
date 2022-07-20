import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:currency_app/decimalRonder.dart';
import 'package:currency_app/provider/DataProvider.dart';
import 'package:currency_app/screen/DrawerMenu.dart';
import 'package:currency_app/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../data/CryptoData.dart';
import '../data/ResponseModel.dart';
import '../provider/CryptoDataProvider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  var defaultChoiceIndex = 0;
  late Timer? timer;
  final List<String> _choicesList = ['Top Market', 'Top Gainers', 'Top Losers'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final cryptoProvider =
        Provider.of<CryptoDataProvider>(context, listen: false);
    cryptoProvider.getTopMarketCapData();
  }

  @override
  void dispose() {
    timer!.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final changeTheme = Provider.of<ChangeTheme>(context);
    final postData = Provider.of<CryptoDataProvider>(context);
    var hi = MediaQuery.of(context).size.height;

    var SwitchIcon =
        Icon(changeTheme.isDarkMode ? Icons.nightlight_sharp : Icons.sunny);
    return Consumer<ChangeTheme>(
      builder: ((context, value, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: changeTheme.themeMode,
          darkTheme: MyTheme().darkTheme,
          theme: MyTheme().lightTheme,
          home: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                leading: IconButton(
                    icon: SvgPicture.asset(
                      "assets/images/icon_menu.svg",
                      color: changeTheme.isDarkMode
                          ? Colors.white
                          : Colors.grey[800],
                    ),
                    onPressed: () {
                      ZoomDrawer.of(context)!.toggle();
                    }),
                title: Text(
                  "Currency App",
                  style: TextStyle(
                      fontFamily: GoogleFonts.lato().fontFamily,
                      color:
                          changeTheme.isDarkMode ? Colors.white : Colors.black),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: IconButton(
                        color: changeTheme.isDarkMode
                            ? Colors.white
                            : Colors.grey[800],
                        icon: SwitchIcon,
                        onPressed: () {
                          changeTheme.toggleTheme();
                        }),
                  ),
                ],
              ),
              body: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      // PageView
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10.0, left: 5, right: 5),
                        child: SizedBox(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 10,
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                  ),
                                ]),
                          ),
                          height: 210,
                          width: 370,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        width: double.infinity,
                        child: Marquee(
                          text: '🔊 Today is   ',
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5, left: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Wrap(
                              spacing: 40,
                              children:
                                  List.generate(_choicesList.length, (index) {
                                return ChoiceChip(
                                    elevation: 5,
                                    label: Text(
                                      _choicesList[index],
                                    ),
                                    selected: defaultChoiceIndex == index,
                                    selectedColor: Colors.blue,
                                    onSelected: (value) {
                                      setState(() {
                                        defaultChoiceIndex =
                                            value ? index : defaultChoiceIndex;
                                        switch (index) {
                                          case 0:
                                            postData.getTopMarketCapData();

                                            break;
                                          case 1:
                                            postData.getTopGainersData();

                                            break;
                                          case 2:
                                            postData.getTopLosersData();

                                            break;
                                        }
                                      });
                                    });
                              }),
                            )
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 490,
                        child: Consumer<CryptoDataProvider>(
                            builder: (context, cryptoDataProvider, child) {
                          switch (cryptoDataProvider.state.status) {
                            case Status.LOADING:
                              return SizedBox(
                                height: 80,
                                child: Shimmer.fromColors(
                                    child: ListView.builder(
                                        itemCount: 10,
                                        itemBuilder: (context, index) {
                                          return Row(
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    top: 8.0,
                                                    bottom: 8,
                                                    left: 8),
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  radius: 30,
                                                  child: Icon(Icons.add),
                                                ),
                                              ),
                                              Flexible(
                                                fit: FlexFit.tight,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0, left: 8),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: 50,
                                                        height: 15,
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 8.0),
                                                        child: SizedBox(
                                                          width: 25,
                                                          height: 15,
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                fit: FlexFit.tight,
                                                child: SizedBox(
                                                  width: 70,
                                                  height: 40,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                fit: FlexFit.tight,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      SizedBox(
                                                        width: 50,
                                                        height: 15,
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 8.0),
                                                        child: SizedBox(
                                                          width: 25,
                                                          height: 15,
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                    baseColor: Colors.grey.shade400,
                                    highlightColor: Colors.white),
                              );
                            case Status.COMPLETED:
                              List<CryptoData>? model = cryptoDataProvider
                                  .dataFuture.data!.cryptoCurrencyList;

                              // print(model![0].symbol);
                              return ListView.separated(
                                  itemBuilder: (context, index) {
                                    var number = index + 1;
                                    var tokenId = model![index].id;

                                    MaterialColor filterColor =
                                        DecimalRounder.setColorFilter(
                                            model[index]
                                                .quotes![0]
                                                .percentChange24h);

                                    var finalPrice =
                                        DecimalRounder.removePriceDecimals(
                                            model[index].quotes![0].price);

                                    // percent change setup decimals and colors
                                    var percentChange =
                                        DecimalRounder.removePercentDecimals(
                                            model[index]
                                                .quotes![0]
                                                .percentChange24h);

                                    Color percentColor =
                                        DecimalRounder.setPercentChangesColor(
                                            model[index]
                                                .quotes![0]
                                                .percentChange24h);
                                    Icon percentIcon =
                                        DecimalRounder.setPercentChangesIcon(
                                            model[index]
                                                .quotes![0]
                                                .percentChange24h);

                                    return SizedBox(
                                      height: hi * 0.075,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: Text(
                                              number.toString(),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, right: 15),
                                            child: CachedNetworkImage(
                                                fadeInDuration: const Duration(
                                                    milliseconds: 500),
                                                height: 32,
                                                width: 32,
                                                imageUrl:
                                                    "https://s2.coinmarketcap.com/static/img/coins/32x32/$tokenId.png",
                                                placeholder: (context, url) =>
                                                    const CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) {
                                                  return const Icon(
                                                      Icons.error);
                                                }),
                                          ),
                                          Flexible(
                                            fit: FlexFit.tight,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  model[index].name!,
                                                ),
                                                Text(
                                                  model[index].symbol!,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            fit: FlexFit.tight,
                                            child: ColorFiltered(
                                                colorFilter: ColorFilter.mode(
                                                    filterColor,
                                                    BlendMode.srcATop),
                                                child: SvgPicture.network(
                                                    "https://s3.coinmarketcap.com/generated/sparklines/web/1d/2781/$tokenId.svg")),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "\$$finalPrice",
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      percentIcon,
                                                      Text(
                                                        percentChange + "%",
                                                        style:
                                                            GoogleFonts.ubuntu(
                                                                color:
                                                                    percentColor,
                                                                fontSize: 13),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const Divider();
                                  },
                                  itemCount: 10);
                            case Status.ERROR:
                              return Text(cryptoDataProvider.state.message);
                            default:
                              return Container();
                          }
                        }),
                      ),
                    ],
                  ),
                ),
              )),
        );
      }),
    );
  }
}

class MyDrawerController extends GetxController {
  final zoomDrawerController = ZoomDrawerController();

  void toggleDrawer() {
    print("Toggle drawer");
    zoomDrawerController.toggle?.call();
    update();
  }
}
