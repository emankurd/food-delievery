import 'package:flutter/cupertino.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double sizeH;
  final double sizeW;
  final double iconSize;

  AppIcon({required this.icon, this.backgroundColor=const Color(0xFFfcf4e4), this.iconColor=const Color(0xFF756d54), required this.sizeH, required this.sizeW, this.iconSize=16});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizeW,
      height: sizeH,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(sizeH/2),
        color: backgroundColor,

      ),
      child: Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),

    );
  }
}
