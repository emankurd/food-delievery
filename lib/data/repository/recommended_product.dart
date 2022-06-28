import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/api/api_client.dart';
import 'package:food_delivery_app/utlis/app_constant.dart';
import 'package:get/get.dart';

class RecommendedProductRepo extends GetxService{
  final ApiClient apiClient;
  RecommendedProductRepo({
    required this.apiClient
});
  Future<void> getRecommendedProductList() async{
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URL);
  }

  // Future<Response> getPopularProductList() async{
  //   return await apiClient.getData("/api/v1/products/popular");
  // }
}