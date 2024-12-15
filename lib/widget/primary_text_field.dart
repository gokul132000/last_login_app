import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:my_app/resource/app_dimension.dart';
import 'package:my_app/widget/primary_text.dart';

import '../resource/app_colors.dart';

Widget PrimaryTextField({
  required TextEditingController controller,
  required String hint,
  TextInputType inputType = TextInputType.number,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      PrimaryText(
        text: hint,
        color: AppColors.whiteTextColor,
        size: AppDimen.textSize18,
      ),
      const SizedBox(
        height: 20,
      ),
      TextFormField(
        autofocus: false,
        controller: controller,
        keyboardType: inputType,
        cursorColor: AppColors.whiteTextColor,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.primaryColor,
          border: outlineInputBorder(),
          enabledBorder: outlineInputBorder(),
          focusedBorder: outlineInputBorder(),
        ),
        style: const TextStyle(color: AppColors.whiteTextColor), // Text color
      ),
      const SizedBox(
        height: 40,
      ),
    ],
  );
}

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: const BorderSide(
      color: AppColors.primaryColor, // Border color when enabled
      width: 2.0,
    ),
  );
}
