import 'package:car_pool/screens/map_screen.dart';
import 'package:car_pool/screens/sign_in.dart';
import 'package:car_pool/utils/app_button.dart';
import 'package:car_pool/utils/app_logo_text.dart';
import 'package:car_pool/utils/app_sizedbox.dart';
import 'package:car_pool/utils/app_text.dart';
import 'package:car_pool/utils/app_textfield.dart';
import 'package:car_pool/utils/mediaquery.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

TextEditingController loginPhone = TextEditingController();

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine if the keyboard is open
    // final bottomInset = MediaQuery.of(context).bottom;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: mediaqueryheight(0.6, context),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image:
                      AssetImage('assets/car_top_image-removebg-blurred.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 320),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: mediaqueryheight(0.1, context)),
                  Column(
                    children: [
                      const LogoText(),
                      AppTextField(
                        hintText: 'Enter your phone',
                        controller: loginPhone,
                      ),
                    ],
                  ),
                  SizedBox(height: mediaqueryheight(0.3, context)),
                  AppButton(
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      String? phoneNumber = prefs.getString('phoneNumber');
                      String companyNumber = '9895000111';
                      if (phoneNumber == loginPhone.text ||
                          companyNumber == loginPhone.text) {
                        Get.to(const MapScreen());
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: CustomText(
                              text: 'Your phone number is not verified',
                              fontSize: 0.03,
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                  ),
                  const CustomSizedBoxHeight(0.02),
                  Padding(
                    padding:
                        EdgeInsets.only(left: mediaquerywidth(0.07, context)),
                    child: Row(
                      children: [
                        const Text(
                          'Dont you have account ? ',
                          style: TextStyle(fontSize: 17),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(SignInScreen());
                          },
                          child: const CustomText(
                            text: 'Sign In',
                            fontSize: 0.04,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
