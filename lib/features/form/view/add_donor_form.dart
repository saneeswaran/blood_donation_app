import 'package:blood_donation/features/widgets/custom_text_formfield.dart';
import 'package:flutter/material.dart';

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
}


// name 
// location
// blood group
// mobile number
// gmail 
