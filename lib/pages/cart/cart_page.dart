import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/pages/home/main_food_page.dart';
import 'package:food_delivery_app/utlis/app_constant.dart';
import 'package:food_delivery_app/utlis/colors.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';


class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 60.h,
              left: 20.w,
              right: 20.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(icon: Icons.arrow_back_ios, sizeH: 40.h, sizeW: 40.w,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: 24.r,
                  ),
                  SizedBox(width: 100.w,),
                  GestureDetector(
                    onTap:(){Get.to(()=>MainFoodPage( ));},

                    child: AppIcon(icon: Icons.home_outlined, sizeH: 40.h, sizeW: 40.w,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: 24.r,
                    ),
                  ),
                  AppIcon(icon: Icons.shopping_cart, sizeH: 40.h, sizeW: 40.w,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: 24.r,
                  ),
                ],
          )),
          Positioned(
              top:100.h,
             right: 20.w,
             left: 20.w,
              bottom:0,
              child: Container(
            margin: EdgeInsets.only(top: 15.h),
         //   color: Colors.red,
              child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: GetBuilder<CartController>(builder: (cartController){
                var _cartList=cartController.getItems;
                return ListView.builder(
                    itemCount: _cartList.length,
                    itemBuilder: (_,index){
                      return Container(
                        height: 100.h,
                        width: double.maxFinite,
                     //   color: Colors.blue,
                       // margin: EdgeInsets.only(bottom: 10.h),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 10.h),
                              height: 100.h,
                              width: 100.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  color: Colors.white,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          AppConstants.UPLOAD+cartController.getItems[index].img!
                                      )
                                  )

                              ),
                            ),
                            SizedBox(width: 10.w,),
                            Expanded(child: Container(
                              height: 100.h,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  BigText(text:cartController.getItems[index].name!, color: Colors.black54,),
                                  SmallText(text: 'Spicy'),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      BigText(text: cartController.getItems[index].price.toString(), color: Colors.redAccent,),
                                      Container(
                                        padding: EdgeInsets.all(10.r),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20.r),
                                            color: Colors.white
                                        ),
                                        child: Row(
                                          children: [
                                            InkWell(
                                                onTap:(){
                                                  // popularProduct.setQuantity(false);
                                                },
                                                child: Icon(Icons.remove, color: AppColors.signColor,)
                                            ),
                                            SizedBox(width: 5.w,),
                                            BigText(text: _cartList[index].quantity.toString()),//popularProduct.inCartItem.toString()),
                                            SizedBox(width: 5.w,),
                                            InkWell(
                                                onTap:(){
                                                  //   popularProduct.setQuantity(true);
                                                },
                                                child: Icon(Icons.add, color: AppColors.signColor,))
                                          ],
                                        ),
                                      ),

                                    ],
                                  )

                                ],
                              ),
                            ))
                          ],
                        ),
                      );
                    });
              },),
            ),
          ),
          ),

        ],
      ),
    );
  }
}
