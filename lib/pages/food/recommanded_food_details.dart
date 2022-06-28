import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/controllers/recommended_product_controller.dart';
import 'package:food_delivery_app/pages/cart/cart_page.dart';
import 'package:food_delivery_app/routs/routs_helper.dart';
import 'package:food_delivery_app/utlis/app_constant.dart';
import 'package:food_delivery_app/utlis/colors.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';

class RecommandedFoodDetails extends StatelessWidget {

  int pageId;
   RecommandedFoodDetails({Key? key , required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product= Get.find<RecommendedProductConroller>().recommendedProductList[pageId];
    Get.find<PopularProductConroller>().initProduct(product,Get.find<CartController>());

    print('pageId: '+pageId.toString());
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 80.h,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: (){
                      Get.toNamed(RoutesHelper.getInitial());
                    }
                    ,child: AppIcon(iconSize:16.r,icon: Icons.clear, sizeH: 40.h, sizeW: 40.w)),
             //   AppIcon(iconSize:16.r,icon: Icons.shopping_cart_outlined, sizeH: 40.h, sizeW: 40.w)
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
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20.h),
                child:Container(
                //  color: Colors.white,
                  child: Center(child: BigText(size:26.sp,text:product.name!)),
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: 5.h,bottom: 10.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),

                    )
                  ),
                ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300.h,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.UPLOAD+product.img!
                ,width: double.maxFinite,
                fit: BoxFit.cover
                ,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child:Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20.w,right: 20.w),
                  child: ExpandapleTextWidgwet(
                    text: product.description!
                  ),
                )
              ],
            )
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductConroller>(builder: (controller){
        return Column(
          mainAxisSize:MainAxisSize.min ,
          children: [
            Container(
              padding: EdgeInsets.only(left: 20.w*2.5,
                  right: 20.w*2.5 ,
                  top: 10.h,
                  bottom: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(onTap: (){
                    print('I am tapped');
                    controller.setQuantity(false);
                  },
                      child: AppIcon(iconSize:24.r,icon: Icons.remove, sizeH: 40.h, sizeW: 40.w,backgroundColor: AppColors.mainColor,iconColor: Colors.white)),
                  BigText(text: "\$${product.price} X ${controller.inCartItem}",color: AppColors.mainBlackColor,size: 26.sp,),
                  InkWell(onTap: (){
                    print('I am tapped');
                    controller.setQuantity(true);
                    },
                      child: AppIcon(iconSize:24.r,icon: Icons.add, sizeH: 40.h, sizeW: 40.w,backgroundColor: AppColors.mainColor,iconColor: Colors.white)),

                ],
              ),
            ),
            Container(
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
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.mainColor,
                      )
                  ),
                  InkWell(
                    onTap: (){
                      controller.addItem(product);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20.r),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: AppColors.mainColor
                      ),
                      child: BigText(text:"\$${product.price!} | Add to cart" ,color: Colors.white,),
                    ),
                  )
                ],
              ),
            ),

          ],
        ) ;
      },)
    );
  }
}
