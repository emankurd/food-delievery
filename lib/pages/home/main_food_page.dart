import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/home/food_page_body.dart';
import 'package:food_delivery_app/utlis/colors.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  _MainFoodPageState createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
   print("current height is"+MediaQuery.of(context).size.height.toString());
   print("current width is"+MediaQuery.of(context).size.width.toString());

   return Scaffold(
      body: Column(
        children: [
          Container(
            child: Container(
        margin: EdgeInsets.only(top: 45.h,bottom: 15.h),
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Column(
                      children: [
                       BigText(text: 'Palestine',color: AppColors.mainColor,size: 30.sp,),
                        Row(
                          children: [
                            SmallText(text: 'Gaza' , color: Colors.black54,size: 12.sp,),
                            Icon(Icons.arrow_drop_down_rounded)
                          ],
                        )
                      ],
                    ),
                    Center(
                      child: Container(
                        width: 45.w,
                        height: 45.h,
                        child: Icon(Icons.search, color: Colors.white,),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            color: AppColors.mainColor
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(child:SingleChildScrollView(
          child: FoodPageBody(),
          ) )
        ],
      ),
    );
  }
}
