import 'package:blood_donation/features/auth/view%20model/auth_repo.dart';
import 'package:blood_donation/features/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomElevatedButton(
        onPressed: () {
          final authProvider = Provider.of<AuthRepo>(context, listen: false);
          authProvider.logout();
        },
        child: const Text("Signout"),
      ),
    );
  }
}
