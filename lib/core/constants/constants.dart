class Constants {
  static const String onboardPath = "assets/images";
  static const String vectorPath = "assets/svg";
}

class AppImages {
  static const String google = "${Constants.vectorPath}/google.svg";
  static const String onboard1 = "${Constants.onboardPath}/onboard1.jpg";
  static const String onboard2 = "${Constants.onboardPath}/onboard2.jpg";
  static const String onboard3 = "${Constants.onboardPath}/onboard3.jpg";
}

class AppData {
  static const String states = "assets/state/states-and-districts.json";
}

class AppText {
  static const String donorTermsAndConditions = '''
By registering as a donor in the Blood Donation App, you agree to the following terms and conditions:

1. ELIGIBILITY
- You confirm that you are at least 18 years of age and in good health.
- You must meet the basic health and eligibility criteria for blood donation as per national health guidelines.

2. CONSENT FOR CONTACT
- You agree to be contacted by patients, hospitals, blood banks, or the app team for urgent donation requests.
- Communication may be through phone calls, SMS, WhatsApp, email, or app notifications.

3. AVAILABILITY
- You may be contacted at any time, including during emergencies.
- You are not obligated to donate each time you're contacted, but your willingness is appreciated.

4. INFORMATION USAGE
- Your name, blood group, location (city/state), and contact details may be shared with verified blood requesters.
- Your data will not be sold, misused, or published publicly.

5. MEDICAL RESPONSIBILITY
- The app does not take responsibility for any health issues arising due to blood donation.
- You are advised to consult with a healthcare provider before donating.

6. VOLUNTARY PARTICIPATION
- You are registering voluntarily, and you may request to remove your donor profile at any time.

7. DATA PRIVACY
- We are committed to protecting your data in accordance with applicable privacy laws.
- You can view or update your information anytime through your profile.

8. APP LIABILITY
- The app acts only as a platform to connect donors and recipients and is not responsible for the outcome of donations or medical events.
''';
}
