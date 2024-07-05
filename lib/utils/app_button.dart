import 'package:car_pool/utils/app_text.dart';
import 'package:car_pool/utils/mediaquery.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Function onPressed;
  const AppButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        height: mediaqueryheight(0.07, context),
        width: mediaquerywidth(0.9, context),
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 37, 184, 42),
            borderRadius: BorderRadius.circular(9)),
        child: Center(
          child: SizedBox(
            width: mediaquerywidth(0.7, context),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: 'Login', fontSize: 0.04),
                Icon(Icons.arrow_forward)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
