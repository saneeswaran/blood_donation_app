import 'package:blood_donation/features/auth/view%20model/auth_repo.dart';
import 'package:blood_donation/features/form/view%20model/donor_repo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.wait([
      context.read<DonorRepo>().getCurrentUserData(context: context),
      context.read<AuthRepo>().checkUserBecomeDonor(context: context),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("Home Page")));
  }
}
