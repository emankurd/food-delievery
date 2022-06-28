import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/controllers/recommended_product_controller.dart';
import 'package:food_delivery_app/data/modules/products_module.dart';
import 'package:food_delivery_app/pages/food/popular_food_details.dart';
import 'package:food_delivery_app/routs/routs_helper.dart';
import 'package:food_delivery_app/utlis/app_constant.dart';
import 'package:food_delivery_app/utlis/colors.dart';
import 'package:food_delivery_app/utlis/dimentions.dart';
import 'package:food_delivery_app/widgets/app_column.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/icon_and_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  _FoodPageBodyState createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  var _curPageValue=0.0;
  double _height=Dimentions.pageViewController;
  double _scaleFactor=0.8;
  PageController pageController=PageController(viewportFraction: 0.85);


 @override
 void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _curPageValue=pageController.page!;
        //print('current page value: ${_curPageValue.toString()}}');
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }


 @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //slider section
         GetBuilder<PopularProductConroller>(builder: (popularProducts){
           return  popularProducts.isLoading?Container(
             // color: Colors.red,
             height: Dimentions.pageView,
               child: PageView.builder(
                   controller: pageController,
                   itemCount:popularProducts.popularProductList.isEmpty?1:popularProducts.popularProductList.length,
                   //popularProducts.popularProductList.length,
                   itemBuilder: (context , position){
                     return _buildPageItem(position , popularProducts.popularProductList[position]);
                   }),

           ):
           CircularProgressIndicator(color: AppColors.mainColor,);
         }),
          //dots
          GetBuilder<PopularProductConroller>(builder: (popularProducts){
            return  DotsIndicator(
              dotsCount: popularProducts.popularProductList.isEmpty?1:popularProducts.popularProductList.length,
              position: _curPageValue,
              decorator: DotsDecorator(
                activeColor: AppColors.mainColor,
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
            );
          },
          ),
          SizedBox(height: 30.h,),
          Container(
            margin: EdgeInsets.only(left: 30.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                BigText(text: 'Recommended',),
                SizedBox(width: 10.w,),
                Container(
                  margin: const EdgeInsetsDirectional.only(bottom: 3),
                  child: BigText(text: '.',color: Colors.black26,),
                ),
                SizedBox(width: 10.w,),
                Container(
                  margin: const EdgeInsetsDirectional.only(bottom: 2),
                  child: SmallText(text: 'Recommended',color: Colors.black26,),
                ),


              ],
            ),
          ),
          //list of food and images
          GetBuilder<RecommendedProductConroller>(builder: (recommendedProduct){
            return recommendedProduct.isLoading?ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: recommendedProduct.recommendedProductList.length,
                itemBuilder: (context, index){
                  return GestureDetector(
                    onTap: (){
                      Get.toNamed(RoutesHelper.getRecommendedPopularFood(index));
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 20.w, right: 20.w , bottom:10.h),
                      child: Row(
                        children: [
                          //image section
                          Container(
                            width:120.w,
                            height:120.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                color: Colors.white38,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      //  "assets/images/food1.png"
                                        AppConstants.UPLOAD+recommendedProduct.recommendedProductList[index].img!
                                    )
                                )

                            ),
                          ),
                          //text container
                          Expanded(

                            child: Container(
                              height: 100.h,

                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(20.r) , bottomRight: Radius.circular(20.r)),
                                  color: Colors.white
                              ),
                              child:Padding(
                                padding: EdgeInsets.only(left: 10.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BigText(text: recommendedProduct.recommendedProductList[index].name!),
                                    SizedBox(height: 10.h,),
                                    SmallText(text: 'with chinese char'),
                                    SizedBox(height: 10.h,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconAndTextWidget(icon: Icons.circle_sharp,
                                            text: 'Normal',
                                            iconColor: AppColors.iconColor1),
                                        IconAndTextWidget(icon: Icons.location_on,
                                            text: '1.7km',
                                            iconColor: AppColors.mainColor),
                                        IconAndTextWidget(icon: Icons.access_time_rounded,
                                            text: '32min',
                                            iconColor: AppColors.iconColor2)

                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),

                    ),
                  );
                }):CircularProgressIndicator(
              color: AppColors.mainColor,
            );
          },)



        ],
      ),
    );
  }
  Widget _buildPageItem(int index,ProductModel productModel){
    Matrix4 matrix=new Matrix4.identity();
    if(index ==_curPageValue.floor())
      {
        var currScale=1-(_curPageValue-index)*(1-_scaleFactor);
        var currTrans=_height=(1-currScale)/2;
        matrix=Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0,currTrans, 0);
      }
    else if(index == _curPageValue.floor()+1){
      var currScale=_scaleFactor+(_curPageValue-index+1)*(1-_scaleFactor);
      var currTrans=_height=(1-currScale)/2;
      matrix=Matrix4.diagonal3Values(1, currScale, 1);
      matrix=Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0,currTrans, 0);

    }
    else if(index == _curPageValue.floor()-1){
      var currScale=1-(_curPageValue-index)*(1-_scaleFactor);
      var currTrans=_height=(1-currScale)/2;
      matrix=Matrix4.diagonal3Values(1, currScale, 1);
      matrix=Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0,currTrans, 0);

    }
    else
      {
        var currScale=0.8; 
        matrix=Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height*(1-_scaleFactor)/2, 1);
      }
      return Transform(
        transform: matrix,
        child: Stack(
          children: [
            GestureDetector(
            onTap: (){
              print('index $index');
          Get.toNamed(RoutesHelper.getPopularFood(index));
                        },
              child: Container(
                height: Dimentions.pageViewController,
                margin: EdgeInsets.only(left: 10.w,right: 10.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                    color: index.isEven?Color(0xFF69c5df):Color(0xFF9294cc),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          //  "assets/images/food1.png"
                            AppConstants.UPLOAD+productModel.img!
                        )
                    )
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: Dimentions.pageViewTextController,
                margin: EdgeInsets.only(left: 25.w,right: 25.w,bottom: 25.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.r,
                      offset: Offset(0,5),

                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5,0),

                    ),
                    BoxShadow(
                      color: Colors.white,
                    //  blurRadius: 5.0,
                      offset: Offset(5,0),

                    )
                  ]

                ),
                child: Container(
                  padding: EdgeInsets.only(top: 15.h , left: 15.w ,right: 15.w),
                  child: AppColumn(text:productModel.name!,),
                ),
              ),
            ),
          ],
        ),
      );
  }

}



