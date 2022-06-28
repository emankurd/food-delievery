import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/utlis/app_constant.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiClient extends GetConnect implements GetxService{
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHelpers;

  ApiClient({
    required this.appBaseUrl,
}){
    baseUrl=appBaseUrl;
    timeout=Duration(seconds: 30);
    token="";
    _mainHelpers={
      'Content-type': 'application/json; charset=utf-8',
      'Authorization':'Bearer $token',
    };
  }

  Future<void> getData(String uri) async{
    try{
      var url=Uri.parse(AppConstants.POPULAR_PRODUCT_URL);
      var response = await( http.get(url)) as Response;
      print('status code: ${response.statusCode}');
      var body= jsonDecode(response.body);
     // return response;
    }catch(e){
      //  return Response(statusCode: 1,statusText: e.toString());

    }
  }
  // Future<Response> getData(String uri) async{
  //   try{
  //   Response response= await get(uri);
  //   print('status code: ${response.statusCode}');
  //   return response;
  //   }catch(e){
  //     return Response(statusCode: 1,statusText: e.toString());
  //   }
  // }

}