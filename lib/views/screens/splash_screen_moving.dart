import 'package:car_pool/views/screens/boarding_screen.dart';
import 'package:car_pool/utils/constant/app_logo_text.dart';
import 'package:car_pool/utils/app_sizedbox.dart';
import 'package:car_pool/utils/constant/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreenMoving extends StatefulWidget {
  const SplashScreenMoving({super.key});

  @override
  _SplashScreenMovingState createState() => _SplashScreenMovingState();
}

class _SplashScreenMovingState extends State<SplashScreenMoving>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 0.6),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Navigate to the next screen after the animation completes
        Get.to(
          curve: Curves.easeInOut,
          const BoardingScreen(),
          transition: Transition.downToUp,
          duration: const Duration(seconds: 1),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: _startAnimation,
        child: Scaffold(
          body: Center(
            child: Column(
              children: [
                const Spacer(flex: 2),
                SlideTransition(
                  position: _offsetAnimation,
                  child: const LogoText(),
                ),
                const CustomSizedBoxHeight(0.02),
                const CustomText(text: 'Get a new experience', fontSize: 0.05),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
