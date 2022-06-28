import 'package:flutter/material.dart';
import 'package:food_delivery_app/utlis/colors.dart';
import 'package:food_delivery_app/widgets/small_text.dart';

import 'big_text.dart';
import 'icon_and_text.dart';
class AppColumn extends StatelessWidget {
  final String text;
  final double fontSize;

  AppColumn({required this.text, this.fontSize=20});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text,size: fontSize,),
        SizedBox(height: 10,),
        Row(
          children: [
            Wrap(
              children:List.generate(5, (index) => Icon(Icons.star , color: AppColors.mainColor,size: 15,)),
            ),
            SizedBox(width: 10,),
            SmallText(text: '4.5',),
            SizedBox(width: 10,),
            SmallText(text: '1287',),
            SizedBox(width: 10,),
            SmallText(text: 'Comments',),

          ],
        ),
        SizedBox(height: 10,),
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
    ) ;
  }
}
