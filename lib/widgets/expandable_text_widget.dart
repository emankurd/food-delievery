import 'package:flutter/material.dart';
import 'package:food_delivery_app/utlis/colors.dart';
import 'package:food_delivery_app/utlis/dimentions.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
class ExpandapleTextWidgwet extends StatefulWidget {
  final String text;
  ExpandapleTextWidgwet({required this.text});

  @override
  State<ExpandapleTextWidgwet> createState() => _ExpandapleTextWidgwetState();
}

class _ExpandapleTextWidgwetState extends State<ExpandapleTextWidgwet> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText= true;
  double textHeight=Dimentions.screenHeight/5;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.text.length>textHeight){
      firstHalf=widget.text.substring(0,textHeight.toInt());
      secondHalf=widget.text.substring(textHeight.toInt()+1,widget.text.length);
    }
    else  
      {
       firstHalf=widget.text;
       secondHalf="";
      }
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty? SmallText(color:AppColors.paraColor,text: firstHalf,):Column(
        children: [
          SmallText(height:1.8,color:AppColors.paraColor,text: hiddenText?(firstHalf+"...."):(firstHalf+secondHalf)),
          InkWell(
            onTap: (){
              setState(() {
                hiddenText=!hiddenText;
              });
            },
            child: Row(
              children: [
                SmallText(text: "show more",color: AppColors.mainColor,),
                Icon(Icons.arrow_drop_down,color: AppColors.mainColor, )
              ],
            ),
          )
        ],
      ),
    );
  }
}
