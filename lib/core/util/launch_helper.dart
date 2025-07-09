import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';

class LaunchHelper {
  static Future<void> launchMobileNumber({required String number}) async {
    final Uri uri = Uri(scheme: 'tel', path: number);

    try {
      final bool launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        throw 'Could not launch $uri';
      }
    } catch (e) {
      log('Error launching phone number: $e');
      rethrow;
    }
  }
}
