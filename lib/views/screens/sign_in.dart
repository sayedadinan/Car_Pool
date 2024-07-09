import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:car_pool/views/screens/login_screen.dart';
import 'package:car_pool/views/screens/map_screen.dart';
import 'package:car_pool/viewmodels/auth_viewmodal.dart';
import 'package:car_pool/utils/constant/app_button.dart';
import 'package:car_pool/utils/constant/app_logo_text.dart';
import 'package:car_pool/utils/app_sizedbox.dart';
import 'package:car_pool/utils/constant/app_text.dart';
import 'package:car_pool/utils/app_textfield.dart';
import 'package:car_pool/utils/mediaquery.dart';

final TextEditingController phoneController = TextEditingController();
final TextEditingController otpController = TextEditingController();
final TextEditingController nameController = TextEditingController();
final TextEditingController emailController = TextEditingController();

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final _formKey = GlobalKey<FormState>();

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
        child: Form(
          key: _formKey,
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your mobile number.';
                  } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                    return 'Please enter a valid 10-digit mobile number.';
                  }
                  return null;
                },
              ),
              AppTextField(
                hintText: 'Full Name',
                controller: nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your full name.';
                  }
                  return null;
                },
              ),
              AppTextField(
                hintText: 'Email',
                controller: emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email address.';
                  } else if (!value.endsWith('@gmail.com')) {
                    return 'Please enter a valid Gmail address.';
                  }
                  return null;
                },
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
                  if (_formKey.currentState!.validate()) {
                    // Form is valid, proceed with OTP sending
                    String phoneNumber = phoneController.text;
                    String formattedPhoneNumber = '+91$phoneNumber';
                    try {
                      await Provider.of<AuthViewModel>(context, listen: false)
                          .sendOTP(formattedPhoneNumber);
                      _showModal(
                          context); // Show OTP entry modal on successful OTP send
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'Failed to send OTP. Please check your network connection.')),
                      );
                    }
                  }
                },
              ),
              const CustomSizedBoxHeight(0.02),
              Padding(
                padding: EdgeInsets.only(left: mediaquerywidth(0.05, context)),
                child: Row(
                  children: [
                    const Text(
                      'Already You have a Account? ',
                      style: TextStyle(fontSize: 17),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(const LoginScreen());
                      },
                      child: const CustomText(
                        text: 'Login',
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
    );
  }
}
