import 'package:car_pool/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:car_pool/utils/app_button.dart';
import 'package:car_pool/utils/app_logo_text.dart';
import 'package:car_pool/utils/app_sizedbox.dart';
import 'package:car_pool/utils/app_text.dart';
import 'package:car_pool/utils/app_textfield.dart';
import 'package:car_pool/utils/mediaquery.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  // Method to show the modal dialog
  void _showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Verify your Mobile',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: mediaquerywidth(0.05, context),
                      fontWeight: FontWeight.w500),
                ),
                const Text(
                  'Verification code has been sent to your\n   registered mobile XXX XXX 565',
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 10),
                const AppTextFieldForModal(hintText: '          Enter OTP'),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          // print('hello' * 3);
                          Get.to(MapScreen());
                        },
                        child: Text(
                          'Resend Code',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: mediaquerywidth(0.04, context),
                              color: const Color.fromARGB(255, 2, 64, 116)),
                        ))
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomSizedBoxHeight(0.12),
            const LogoText(),
            const CustomSizedBoxHeight(0.04),
            const AppTextField(
              hintText: 'Mobile Number',
              prefixIcon: Icons.call_outlined,
              suffixIcon: Icons.remove_circle_outline,
            ),
            const AppTextField(hintText: 'Full Name'),
            const AppTextField(hintText: 'Email'),
            Padding(
              padding: EdgeInsets.only(left: mediaquerywidth(0.05, context)),
              child: const Row(
                children: [
                  CustomText(
                    text:
                        'By clicking continue, you agree to our \nTerms of Service & Privacy Policy',
                    fontSize: 0.04,
                  ),
                ],
              ),
            ),
            const CustomSizedBoxHeight(0.02),
            AppButton(
              onPressed: () {
                _showModal(context); // Call method to show modal
              },
            ),
            const CustomSizedBoxHeight(0.05),
          ],
        ),
      ),
    );
  }
}
