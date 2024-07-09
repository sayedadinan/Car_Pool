import 'package:car_pool/utils/mediaquery.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;

  const CustomText({
    super.key,
    required this.text,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: mediaquerywidth(fontSize, context),
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
