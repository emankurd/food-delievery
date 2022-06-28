import 'package:food_delivery_app/pages/food/popular_food_details.dart';
import 'package:food_delivery_app/pages/food/recommanded_food_details.dart';
import 'package:food_delivery_app/pages/home/main_food_page.dart';
import 'package:get/get.dart';

class RoutesHelper{
  static const initial="/";
  static String getInitial()=> '$initial';

  static const String popularFood="/popular-food";
  static String getPopularFood(int pageId) => '$popularFood?pageId=$pageId';

  static const String recommendedPopularFood="/recommended-popular-food";
  static String getRecommendedPopularFood(int pageId) => '$recommendedPopularFood?pageId=$pageId';

  static List<GetPage> routes=[
    GetPage(name: initial, page: ()=>MainFoodPage()),
    GetPage(name: popularFood, page: (){
      print('popular food get called');
      var pageId=Get.parameters['pageId'];
      print('pageId: '+pageId.toString());
     return PopularFoodDetails( pageId: int.parse(pageId!),);
    },
      //Transition.circularReveal
      transition: Transition.fadeIn,

    ),
    GetPage(name: recommendedPopularFood, page: (){
      print('recommended food get called');
      var pageId=Get.parameters['pageId'];
      print('pageId: '+pageId.toString());
      return RecommandedFoodDetails( pageId: int.parse(pageId!));
    },
      //Transition.circularReveal
      transition: Transition.fadeIn,

    )


  ];
}