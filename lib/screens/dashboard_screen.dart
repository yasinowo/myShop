//https://www.figma.com/design/9Ks2QQdQNR16k8aPn6gOMM/apple-shop?node-id=0-1&node-type=canvas&t=51WMFEKdT7nqdRNG-0
import 'dart:ui';

import 'package:aplle_shop_pj/constants/color.dart';
import 'package:aplle_shop_pj/data/bloc/carItem.dart/cardItem_bloc.dart';
import 'package:aplle_shop_pj/data/bloc/carItem.dart/cardItem_event.dart';
import 'package:aplle_shop_pj/data/bloc/category/category_bloc.dart';
import 'package:aplle_shop_pj/data/bloc/home/home_bloc.dart';
import 'package:aplle_shop_pj/data/bloc/home/home_event.dart';
import 'package:aplle_shop_pj/di/di.dart';
import 'package:aplle_shop_pj/screens/card_screen.dart';
import 'package:aplle_shop_pj/screens/category_sreen.dart';
import 'package:aplle_shop_pj/screens/home_screen.dart';
import 'package:aplle_shop_pj/screens/login2_screen.dart';
import 'package:aplle_shop_pj/screens/profile_screen.dart';
import 'package:aplle_shop_pj/util/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hive_flutter/adapters.dart';

void main() async {
  runApp(const DashboardScreen());
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
            child: BottomNavigationBar(
              onTap: (int value) {
                setState(() {
                  selectedIndex = value;
                });
              },
              type: BottomNavigationBarType.fixed,
              currentIndex: selectedIndex,
              elevation: 0,
              backgroundColor: Colors.transparent,
              unselectedLabelStyle: const TextStyle(
                  color: Colors.black, fontFamily: 'sb', fontSize: 12),
              selectedLabelStyle: const TextStyle(
                  color: CustomColor.blue, fontFamily: 'sb', fontSize: 12),
              items: [
                BottomNavigationBarItem(
                  label: 'حساب کاربری',
                  icon: Image.asset('assets/images/icon_profile.png'),
                  activeIcon:
                      Image.asset('assets/images/icon_profile_active.png'),
                ),
                BottomNavigationBarItem(
                  activeIcon:
                      Image.asset('assets/images/icon_basket_active.png'),
                  label: 'سبد خرید',
                  icon: Image.asset('assets/images/icon_basket.png'),
                ),
                BottomNavigationBarItem(
                  activeIcon:
                      Image.asset('assets/images/icon_category_active.png'),
                  label: 'دسته بندی',
                  icon: Image.asset('assets/images/icon_category.png'),
                ),
                BottomNavigationBarItem(
                  activeIcon: Image.asset('assets/images/icon_home_active.png'),
                  label: 'خانه',
                  icon: Image.asset('assets/images/icon_home.png'),
                ),
              ],
            ),
          ),
        ),
        drawer: SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Drawer(
              backgroundColor: Colors.white,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Text(
                      'my shop',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout_outlined),
                    title: const Text(
                      'lougout',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      AuthManager.logout();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return const LoginScreen2();
                          },
                        ),
                      );
                    },
                  ),

                  // ListTile(
                  //   title: const Text('Item 1'),
                  //   onTap: () {
                  //     // Update the state of the app.
                  //     // ...
                  //   },
                  // ),
                ],
              )),
        ),
        body: IndexedStack(
          index: selectedIndex,
          children: getScreens(),
        ),
        // BlocProvider(
        //   create: (context) => AuthBloc(),
        //   child: LoginScreen(),
        // )
      ),
    );
  }

  List<Widget> getScreens() {
    return <Widget>[
      const ProfileScreen(),
      BlocProvider(
        create: (context) {
          var bloc = locator.get<CardItemBloc>();
          bloc.add(CarItemFetchFromHiveEvent());
          return bloc;
        },
        child: const CardScreen(),
      ),
      BlocProvider(
        create: (context) => CategoryBloc(),
        child: const CategoryScreen(),
      ),
      Directionality(
          textDirection: TextDirection.rtl,
          child: BlocProvider(
              create: (context) {
                var block = HomeBloc();
                block.add(HomeGetInitializeData());
                return block;
              },
              child: const HomeScreen()))
    ];
  }
}
