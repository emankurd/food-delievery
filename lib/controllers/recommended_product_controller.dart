import 'dart:convert';
import 'package:food_delivery_app/data/modules/products_module.dart';
import 'package:food_delivery_app/data/repository/popular_product.dart';
import 'package:food_delivery_app/data/repository/recommended_product.dart';
import 'package:food_delivery_app/utlis/app_constant.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class RecommendedProductConroller extends GetxController{

  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductConroller({required this.recommendedProductRepo});
  List<ProductModel> _recommendedProductList=[];
  List<ProductModel> get recommendedProductList => _recommendedProductList;
  bool _isLoading=false;
  bool get isLoading => _isLoading;
  Future<void> getRecommendedProductList() async{

    var url=Uri.parse(AppConstants.RECOMMENDED_PRODUCT_URL);
    var response = await http.get(url) ;
    print('status code: ${response.statusCode}');
    var body= jsonDecode(response.body);

    if(response.statusCode == 200){
      print("get products recommended");
      _recommendedProductList=[];
      _recommendedProductList.addAll(Product.fromJson(body).products);
      _isLoading=true;
      update();
    }else {
      print('faild');
    }
  }


}