import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/pages/cart/cart_page.dart';
import 'package:food_delivery_app/pages/home/main_food_page.dart';
import 'package:food_delivery_app/utlis/app_constant.dart';
import 'package:food_delivery_app/utlis/colors.dart';
import 'package:food_delivery_app/widgets/app_column.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/expandable_text_widget.dart';
import 'package:food_delivery_app/widgets/icon_and_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';


class PopularFoodDetails extends StatelessWidget {
  int pageId;
  PopularFoodDetails({Key? key , required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product= Get.find<PopularProductConroller>().popularProductList[pageId];
    Get.find<PopularProductConroller>().initProduct(product,Get.find<CartController>());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //background image
          Positioned(
              left: 0.w,
              right: 0.w,
              child: Container(
                width: double.maxFinite,
                height: 350.h,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          AppConstants.UPLOAD+product.img!
                        )
                    )
                ),
              )),
          //icon widget
          Positioned(
              top: 45.h,
              left: 20.w,
              right: 20.w,
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap:(){
                        Get.to(()=>MainFoodPage());
                      },
                      child: AppIcon(icon: Icons.arrow_back_ios, sizeH: 40.h,sizeW: 40.w,)),

                  GetBuilder<PopularProductConroller>(builder: (controller){
                    return Stack(
                      children: [
                        AppIcon(icon: Icons.shopping_cart_outlined, sizeH: 40.h, sizeW: 40.w),
                        Get.find<PopularProductConroller>().totalItems>=1?
                        Positioned(
                            right: 0, top: 0,
                          child: GestureDetector(
                              onTap:(){Get.to(()=>CartPage());},
                              child: AppIcon(icon: Icons.circle, sizeH: 16.h, sizeW: 16.w,iconColor: Colors.transparent,backgroundColor: AppColors.mainColor,)),
                        ):Container(),
                        Get.find<PopularProductConroller>().totalItems>=1?
                        Positioned(
                            right: 3, top: 3,
                            child: BigText(text: Get.find<PopularProductConroller>().totalItems.toString(),size: 10.sp,color: Colors.white,)
                        ):Container(),

                      ],
                    );
                  }),

                ],
              )),
          //introduction of food
          Positioned(
            top: 330.h,
            left: 0.w,
            right: 0.w,
            bottom: 0.h,
            child: Container(
                padding: EdgeInsets.only(left: 20.w , right: 20.w ,top: 20.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.r),
                    topLeft: Radius.circular(20.r),

                  ),
                  color: Colors.white,

                ),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text:product.name! ,fontSize: 26.sp,),
                    SizedBox(height: 20.h,),
                    BigText(text: 'Introduce'),
                    Expanded(child: SingleChildScrollView(child: ExpandapleTextWidgwet(text: product.description!)))


                  ],
                )
            ),

          ),
          //expandable text widget

        ],
      ),
      bottomNavigationBar:GetBuilder<PopularProductConroller>(builder: (popularProduct){
        return Container(
          height: 120.h,
          padding:EdgeInsets.only(top: 30.h, bottom: 30.h, left: 20.w, right: 20.w) ,
          decoration: BoxDecoration(
              color: AppColors.buttonBackGroundColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40.r),
                topLeft: Radius.circular(40.r),
              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: Colors.white
                ),
                child: Row(
                  children: [
                    InkWell(
                        onTap:(){
                          popularProduct.setQuantity(false);
                        },
                        child: Icon(Icons.remove, color: AppColors.signColor,)
                    ),
                    SizedBox(width: 5.w,),
                    BigText(text: popularProduct.inCartItem.toString()),
                    SizedBox(width: 5.w,),
                    InkWell(
                        onTap:(){
                          popularProduct.setQuantity(true);
                        },
                        child: Icon(Icons.add, color: AppColors.signColor,))
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  print('****** 1');
                  popularProduct.addItem(product);
                },
                child: Container(
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: AppColors.mainColor
                  ),
                  child: BigText(text:"\$${product.price} | Add to cart" ,color: Colors.white,),
                ),
              )
            ],
          ),
        );
      },),
    );
  }

  }

