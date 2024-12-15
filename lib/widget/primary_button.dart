import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_app/widget/primary_text.dart';

import '../resource/app_colors.dart';
import '../resource/app_dimension.dart';
import '../resource/app_font.dart';

Widget PrimaryButton({required String btnText,required GestureTapCallback onTap,String leadingIcon = '',bool isLeadingVisible = false}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      alignment: AlignmentDirectional.center,
      width: double.infinity,
      decoration: const BoxDecoration(
          color: AppColors.buttonColor,
          borderRadius: BorderRadius.all(Radius.circular(8))
      ),
       padding: const  EdgeInsets.symmetric(vertical: 16),
      child: PrimaryText(
        text: btnText,
        color: AppColors.whiteTextColor,
        weight: AppFont.semiBold,
        size: AppDimen.textSize20,
      ),
    ),
  );
}

Widget PrimaryButtonLight({required String btnText,required GestureTapCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.whiteTextColor,width: 1.5),
          borderRadius: const BorderRadius.all(Radius.circular(8))
      ),
      width: double.infinity,
      padding: const  EdgeInsets.symmetric(vertical: 16),
      child: PrimaryText(
        text: btnText,
        color: AppColors.whiteTextColor,
        weight: AppFont.semiBold,
        size: AppDimen.textSize16,
      ),
    ),
  );
}
