import 'package:car_pool/screens/map_screen.dart';
import 'package:car_pool/viewmodals/auth_viewmodal.dart';
import 'package:flutter/material.dart';
import 'package:car_pool/utils/app_button.dart';
import 'package:car_pool/utils/app_logo_text.dart';
import 'package:car_pool/utils/app_sizedbox.dart';
import 'package:car_pool/utils/app_text.dart';
import 'package:car_pool/utils/app_textfield.dart';
import 'package:car_pool/utils/mediaquery.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final TextEditingController phoneController = TextEditingController();
final TextEditingController otpController = TextEditingController();
final TextEditingController nameController = TextEditingController();
final TextEditingController emailController = TextEditingController();

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
                AppTextFieldForModal(
                  controller: otpController,
                  hintText: '          Enter OTP',
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () async {
                          String enteredOtp = otpController.text;
                          if (Provider.of<AuthViewModel>(context, listen: false)
                              .verifyOTP(enteredOtp)) {
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            await preferences.setString(
                                'phoneNumber', phoneController.text);
                            Get.off(const MapScreen());
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Invalid OTP'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        child: Text(
                          'Verify Code',
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
            AppTextField(
              keyboardType: TextInputType.phone,
              controller: phoneController,
              hintText: 'Mobile Number',
              prefixIcon: Icons.call_outlined,
              suffixIcon: Icons.remove_circle_outline,
            ),
            AppTextField(
              hintText: 'Full Name',
              controller: nameController,
            ),
            AppTextField(
              hintText: 'Email',
              controller: emailController,
            ),
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
              onPressed: () async {
                String phoneNumber = phoneController.text;
                try {
                  // Ensure the phone number is formatted correctly
                  // String formattedPhoneNumber = '+91$phoneNumber';
                  await Provider.of<AuthViewModel>(context, listen: false)
                      .sendOTP(phoneNumber);
                  _showModal(
                      context); // Show OTP entry modal on successful OTP send
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'Failed to send OTP. Please check your network connection.')),
                  );
                }
              },
            ),
            const CustomSizedBoxHeight(0.05),
          ],
        ),
      ),
    );
  }
}
