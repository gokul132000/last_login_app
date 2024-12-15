import 'package:flutter/material.dart';
import 'package:my_app/resource/app_colors.dart';
import 'package:my_app/resource/app_dimension.dart';
import 'package:my_app/resource/app_font.dart';

class PrimaryText extends StatelessWidget {
  String text;
  double size;
  Color? color;
  FontWeight? weight;

  PrimaryText(
      {super.key,
      required this.text,
      this.size = AppDimen.textSize16,
      this.color = AppColors.textColor,
      this.weight = AppFont.regular});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: weight,
        fontFamily: AppFont.font,
      ),
    );
  }
}
