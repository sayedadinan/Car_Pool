import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class TwilioService {
  late TwilioFlutter twilioFlutter;

  TwilioService() {
    twilioFlutter = TwilioFlutter(
      accountSid: dotenv.env['TWILIO_ACCOUNT_SID']!,
      authToken: dotenv.env['TWILIO_AUTH_TOKEN']!,
      twilioNumber: dotenv.env['TWILIO_NUMBER']!,
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
