import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/data/modules/cart_models.dart';
import 'package:food_delivery_app/data/modules/products_module.dart';
import 'package:food_delivery_app/data/repository/popular_product.dart';
import 'package:food_delivery_app/utlis/app_constant.dart';
import 'package:food_delivery_app/utlis/colors.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class PopularProductConroller extends GetxController{

  final PopularProductRepo popularProductRepo;
  PopularProductConroller({required this.popularProductRepo});
  List<ProductModel> _popularProductList=[];
  List<ProductModel> get popularProductList => _popularProductList;
  bool _isLoading=false;

  int _quantity=0;
  int _inCartItem=0;
  late CartController _cart;

  int get inCartItem =>_inCartItem+_quantity;

  int get quantity=>_quantity;
  bool get isLoading => _isLoading;

  Future<void> getPopularProductList() async{
    var url=Uri.parse(AppConstants.POPULAR_PRODUCT_URL);
    var response = await http.get(url) ;
    print('status code: ${response.statusCode}');
    var body= jsonDecode(response.body);

    if(response.statusCode == 200){
      print("get products");
      _popularProductList=[];
      _popularProductList.addAll(Product.fromJson(body).products);
      _isLoading=true;
      update();
    }else {
      print('faild');
    }
  }

  void setQuantity(bool isIncrement){
    if(isIncrement){
      _quantity=checkQuantity(_quantity+1);
      print("nu of quantity $quantity");

    }else
      {
        print("dis  $quantity");
        _quantity=checkQuantity(_quantity-1);

      }
    update();
  }

  int checkQuantity(int quantity){
    if((_inCartItem+quantity)<0){
      Get.snackbar(
          'Item count', 'You can\'t reduce more !',
        colorText: Colors.white,
        backgroundColor: AppColors.mainColor
      );
      if(_inCartItem>0){
        _quantity=-_inCartItem;
        return _quantity;
      }
      return 0;
    }else if((_inCartItem+quantity)>20){
      Get.snackbar(
          'Item count', 'You can\'t add more !',
          colorText: Colors.white,
          backgroundColor: AppColors.mainColor
      );
      return 20;
    }else
      {
        return quantity;
      }
  }

  void initProduct(ProductModel product,CartController cartController){
    _quantity=0;
    _inCartItem=0;
    _cart=cartController;
    var exist=false;
    exist=_cart.existInCart(product);
    print('exist or not'+exist.toString());
    if(exist){
      _inCartItem=_cart.getQuantity(product);
    }
    print('the quanitity is'+_inCartItem.toString());

  }

  void addItem(ProductModel product){
    print('****** 2');
    // if(quantity>0){
      _cart.addItem(product, _quantity);
      _quantity=0;
      _inCartItem=_cart.getQuantity(product);
      _cart.items.forEach((key, value) {
        print('the id is : ${value.id}'); });

  update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems{
    return _cart.getItems;
  }

}