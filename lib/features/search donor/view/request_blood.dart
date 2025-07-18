import 'package:blood_donation/features/form/controller/donor_ui_controller.dart';
import 'package:blood_donation/features/form/controller/google_map_provider.dart';
import 'package:blood_donation/features/form/view%20model/state_district_provider.dart';
import 'package:blood_donation/features/search%20donor/view%20model/request_blood_repo.dart';
import 'package:blood_donation/features/widgets/custom_elevated_button.dart';
import 'package:blood_donation/features/widgets/custom_text_formfield.dart';
import 'package:blood_donation/features/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestBlood extends StatefulWidget {
  const RequestBlood({super.key});

  @override
  State<RequestBlood> createState() => _RequestBloodState();
}

class _RequestBloodState extends State<RequestBlood> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final googleMap = context.read<GoogleMapProvider>();
    googleMap.getCurrentLocation().then((_) {
      addressController.text = googleMap.address;
    });
    context.read<StateDistrictProvider>().loadStateDistrictData();
  }

  @override
  Widget build(BuildContext context) {
    final donorUiController = context.read<DonorUiController>();
    final stateController = context.read<StateDistrictProvider>();
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: size.height * 0.02,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Blood Request",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(),
            CustomTextFormfield(hintText: "Name", controller: nameController),
            CustomTextFormfield(hintText: "Phone", controller: phoneController),
            CustomTextFormfield(hintText: "Email", controller: emailController),
            CustomTextFormfield(
              hintText: "Address",
              controller: addressController,
            ),
            donorUiController.bloodType(),
            stateController.stateDropDownButton(),
            stateController.district(),

            SizedBox(
              height: size.height * 0.07,
              width: size.width * 1,
              child: CustomElevatedButton(
                onPressed: () {},
                child: const Text(
                  "Get Location",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.07,
              width: size.width * 1,
              child: Consumer<RequestBloodRepo>(
                builder: (context, value, child) {
                  final isLoading = value.isLoading;
                  return CustomElevatedButton(
                    onPressed: () {},
                    child: isLoading
                        ? const Loader()
                        : const Text(
                            "Submit Request",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
