import 'package:car_pool/utils/mediaquery.dart';
import 'package:flutter/material.dart';

class LogoText extends StatelessWidget {
  const LogoText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Car',
            style: TextStyle(
              fontSize: mediaquerywidth(0.12, context),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          TextSpan(
            text: 'Pool',
            style: TextStyle(
              fontSize: mediaquerywidth(0.12, context),
              fontWeight: FontWeight.bold,
              color: Colors.yellow,
            ),
          ),
        ],
      ),
    );
  }
}
