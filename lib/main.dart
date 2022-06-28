import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/controllers/recommended_product_controller.dart';
import 'package:food_delivery_app/pages/cart/cart_page.dart';
import 'package:food_delivery_app/pages/food/popular_food_details.dart';
import 'package:food_delivery_app/pages/food/recommanded_food_details.dart';
import 'package:food_delivery_app/pages/home/food_page_body.dart';
import 'package:food_delivery_app/pages/home/main_food_page.dart';
import 'package:food_delivery_app/routs/routs_helper.dart';
import 'package:get/get.dart';
import 'helper/dependencies.dart' as dep;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Get.put(PopularProductConroller);
    Get.find<PopularProductConroller>().getPopularProductList();
    Get.find<RecommendedProductConroller>().getRecommendedProductList();
    Get.find<CartController>();
    return ScreenUtilInit(
      designSize: Size(411 , 820),
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          home: MainFoodPage(),
            initialRoute: RoutesHelper.getInitial(),
            getPages: RoutesHelper.routes,
        );
      },

    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
