import 'dart:math';
import 'package:car_pool/services/twilio_services.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  final TwilioService _twilioService = TwilioService();
  String _generatedOtp = '';

  String generateOTP() {
    var rng = Random();
    _generatedOtp = (rng.nextInt(900000) + 100000).toString();
    print('otp generated ');
    return _generatedOtp;
  }

  Future<void> sendOTP(String phoneNumber) async {
    String otp = generateOTP();
    await _twilioService.sendOTP(phoneNumber, otp);
  }

  bool verifyOTP(String enteredOtp) {
    return enteredOtp == _generatedOtp;
  }
}
