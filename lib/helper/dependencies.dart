import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/controllers/recommended_product_controller.dart';
import 'package:food_delivery_app/data/api/api_client.dart';
import 'package:food_delivery_app/data/repository/cart_repo.dart';
import 'package:food_delivery_app/data/repository/popular_product.dart';
import 'package:food_delivery_app/data/repository/recommended_product.dart';
import 'package:food_delivery_app/utlis/app_constant.dart';
import 'package:get/get.dart';
Future<void> init() async{

  //api client
Get.lazyPut(() => ApiClient(appBaseUrl: "https://mvs.bslmeiyu.com"));

//repos
Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
Get.lazyPut(() => CartRepo());


//controller
Get.lazyPut(() => PopularProductConroller(popularProductRepo: Get.find()));
Get.lazyPut(() => RecommendedProductConroller(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));


}