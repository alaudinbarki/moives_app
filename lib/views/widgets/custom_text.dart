import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final double? letterSpacing;
  final TextAlign? textAlign;

  const CustomText(
      {super.key,
      required this.text,
      this.color = AppColors.black,
      this.fontSize = 15,
      this.fontWeight = FontWeight.normal,
      this.fontStyle = FontStyle.normal,
      this.textAlign,
      this.letterSpacing});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: Theme.of(context).textTheme.bodyLarge!.merge(TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          letterSpacing: letterSpacing,
          height: 1.5)),
    );
  }
}
