//https://www.figma.com/design/9Ks2QQdQNR16k8aPn6gOMM/apple-shop?node-id=0-1&node-type=canvas&t=51WMFEKdT7nqdRNG-0

import 'package:aplle_shop_pj/data/model/card_item.dart';
import 'package:aplle_shop_pj/di/di.dart';
import 'package:aplle_shop_pj/screens/dashboard_screen.dart';
import 'package:aplle_shop_pj/screens/login2_screen.dart';
import 'package:aplle_shop_pj/util/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:hive_flutter/adapters.dart';

GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(CardItemAdapter());
  await Hive.openBox<CardItem>('cardBox');
  await getItInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: globalKey,
          title: 'First Method',
          // You can use the library anywhere in the app even in theme
          theme: ThemeData.from(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromRGBO(32, 63, 129, 1.0),
            ),
            // theme: ThemeData(
            //   primarySwatch: Colors.blue,
            //   textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
            //   colorScheme: ColorScheme.fromSeed(
            //     seedColor: const Color.fromRGBO(32, 63, 129, 1.0),
            //   ),
            // ),
          ),
          home: child,
        );
      },
      child: // MapScreen()
          (AuthManager.readAuth().isEmpty)
              ? const LoginScreen2()
              : const DashboardScreen(),
    );
  }
}
