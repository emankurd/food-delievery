import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/modules/cart_models.dart';
import 'package:food_delivery_app/data/modules/products_module.dart';
import 'package:food_delivery_app/data/repository/cart_repo.dart';
import 'package:food_delivery_app/utlis/colors.dart';
import 'package:get/get.dart';
class CartController extends GetxController{
final CartRepo cartRepo;
CartController({required this.cartRepo});

Map<int , CartModel> _items={};
Map<int , CartModel> get items => _items;

void addItem(ProductModel product , int quantity){
  var totalQuantity=0;
  // print("length of items ${_items.length.toString()}");
  // print('product: ${product.id} , quantity: $quantity');
 if(_items.containsKey(product.id)){
   _items.update(product.id, (value) {
     totalQuantity=value.quantity!+quantity;
     return CartModel(
         id : value.id,
         name : value.name,
         price : value.price,
         img : value.img,
         quantity : value.quantity!+quantity,
         isExist : true,
         time : DateTime.now().toString()
     );
   });
   if(totalQuantity<=0){
     _items.remove(product.id);
   }
 }else{
   if(quantity>0){
     _items.putIfAbsent(product.id, () {
       print('****** 3\n');
       _items.forEach((key, value) {
         print('quantity:'+value.quantity.toString());
       });
       print('adding item to the cart '+product.id.toString() +" quantity"+quantity.toString());
       return CartModel(
           id : product.id,
           name : product.name,
           price : product.price,
           img : product.img,
           quantity : quantity,
           isExist : true,
           time : DateTime.now().toString()
       );



     });
   }else
     {
           Get.snackbar('Item count', 'You should at least add an item in the cart' , backgroundColor: AppColors.mainColor , colorText: Colors.white);

     }

       }}

bool existInCart(ProductModel product){
  if(_items.containsKey(product.id)){
    return true;
  }
  return false;
}

int getQuantity(ProductModel product){
  var quantity=0;
  if(_items.containsKey(product.id)){
    _items.forEach((key, value) {
      if(key == product.id){
        quantity=value.quantity!;
      }
    });
  }
  return quantity;
}

int get totalItems{
  var totalQuantity= 0;
  _items.forEach((key, value) {
    totalQuantity+=value.quantity!;
  });
  return totalQuantity;
}

List<CartModel> get getItems{
  return _items.entries.map((e) {
    return e.value;}
  ).toList();
}

}