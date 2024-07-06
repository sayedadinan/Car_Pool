import 'dart:developer';

import 'package:twilio_flutter/twilio_flutter.dart';

class TwilioService {
  late TwilioFlutter twilioFlutter;

  TwilioService() {
    twilioFlutter = TwilioFlutter(
      accountSid: 'AC9e12f6b756d78512edd8f088d74534f9',
      authToken: 'ed8be8f7da80b752f09f9b9c21764dec',
      twilioNumber: '+13342125850',
    );
  }

  Future<void> sendOTP(String phoneNumber, String otp) async {
    log(phoneNumber);
    try {
      await twilioFlutter.sendSMS(
        toNumber: phoneNumber,
        messageBody: 'Your OTP code is: $otp',
      );
      log('OTP sent successfully to $phoneNumber');
    } catch (e) {
      print('Error sending OTP: $e');
      throw Exception('Failed to send OTP. Please try again later.');
    }
  }
}
