import 'package:car_pool/screens/login_screen.dart';
import 'package:car_pool/utils/app_logo_text.dart';
import 'package:car_pool/utils/app_sizedbox.dart';
import 'package:car_pool/utils/mediaquery.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class BoardingScreen extends StatelessWidget {
  const BoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            Get.to(const LoginScreen(),
                transition: Transition.fadeIn,
                duration: const Duration(seconds: 5));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomSizedBoxHeight(0.05),
              const LogoText(),
              SizedBox(
                  height: mediaqueryheight(0.7, context),
                  child:
                      Image.asset('assets/car_top_image-removebg-blurred.png')),
            ],
          ),
        ),
      ),
    );
  }
}
