import 'package:car_pool/views/screens/map_screen.dart';
import 'package:car_pool/views/screens/sign_in.dart';
import 'package:car_pool/utils/constant/app_logo_text.dart';
import 'package:car_pool/utils/app_sizedbox.dart';
import 'package:car_pool/utils/mediaquery.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BoardingScreen extends StatelessWidget {
  const BoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            String? phone = prefs.getString('phoneNumber');
            if (phone == null) {
              Get.to(SignInScreen(),
                  transition: Transition.fadeIn,
                  duration: const Duration(seconds: 5));
            } else {
              Get.to(const MapScreen(),
                  transition: Transition.fadeIn,
                  duration: const Duration(seconds: 5));
            }
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
