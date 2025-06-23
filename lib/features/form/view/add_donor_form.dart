import 'package:blood_donation/features/form/view%20model/donor_repo.dart';
import 'package:blood_donation/features/widgets/custom_text_formfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDonorForm extends StatefulWidget {
  const AddDonorForm({super.key});

  @override
  State<AddDonorForm> createState() => _AddDonorFormState();
}

class _AddDonorFormState extends State<AddDonorForm> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final gmailController = TextEditingController();
  final mobileNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Become a Donor",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              CustomTextFormfield(hintText: "Name", controller: nameController),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bloodType() {
    return Consumer<DonorRepo>(
      builder: (context, provider, child) {
        final items = provider.bloodTypes
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList();
        return DropdownButtonFormField(
          items: items,
          onChanged: (value) => provider.setBloodType(value!),
        );
      },
    );
  }
}


  // final String name;
  // final String? id;
  // final String bloodType;
  // final String donorId;
  // final int age;
  // final String gender;
  // final DateTime dob;
  // final String bloodGroup;
  // final String phone;
  // final String email;
  // final String address;
  // final String city;
  // final String state;
  // final String pinCode;
  // final bool hasChronicDisease;
  // final bool acceptedTerms;
