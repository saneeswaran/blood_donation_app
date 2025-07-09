import 'dart:developer';

import 'package:blood_donation/core/color/appcolor.dart';
import 'package:blood_donation/core/util/util.dart';
import 'package:blood_donation/features/form/controller/donor_ui_controller.dart';
import 'package:blood_donation/features/form/model/donor_model.dart';
import 'package:blood_donation/features/form/view%20model/donor_repo.dart';
import 'package:blood_donation/features/form/view%20model/state_district_provider.dart';
import 'package:blood_donation/features/search/widget/filter/view/filter_data_donor.dart';
import 'package:blood_donation/features/widgets/custom_elevated_button.dart';
import 'package:blood_donation/features/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterDonors extends StatefulWidget {
  const FilterDonors({super.key});

  @override
  State<FilterDonors> createState() => _FilterDonorsState();
}

class _FilterDonorsState extends State<FilterDonors> {
  @override
  void initState() {
    super.initState();
    context.read<StateDistrictProvider>().loadStateDistrictData();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        height: size.height * 1,
        width: size.width * 1,
        child: Column(
          spacing: size.height * 0.02,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Select Blood Group",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Consumer<DonorUiController>(
              builder: (context, provider, child) {
                final bloodTypes = provider.bloodTypes;
                return Wrap(
                  spacing: size.width * 0.02,
                  runSpacing: size.width * 0.02,
                  children: List.generate(bloodTypes.length, (index) {
                    final bloodType = bloodTypes[index];
                    final isSelected = provider.selectedBloodTypeIndex == index;
                    return GestureDetector(
                      onTap: () {
                        provider.setSelectedBloodTypeIndex(index);
                        provider.setBloodType(bloodTypes[index]);
                      },
                      child: Container(
                        height: size.height * 0.1,
                        width: size.width * 0.2,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Appcolor.lightGrey,
                          border: Border.all(
                            color: isSelected
                                ? Appcolor.primaryColor
                                : Appcolor.lightGrey,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            bloodType,
                            style: TextStyle(
                              color: isSelected
                                  ? Appcolor.primaryColor
                                  : Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
            const Text(
              "Select Location",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Consumer<StateDistrictProvider>(
              builder: (context, provider, child) {
                return provider.stateDropDownButton();
              },
            ),
            const Text(
              "Select District",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Consumer<StateDistrictProvider>(
              builder: (context, provider, child) {
                return provider.district();
              },
            ),
            const Spacer(),
            SizedBox(
              height: size.height * 0.07,
              width: size.width * 1,
              child:
                  Consumer3<
                    DonorRepo,
                    StateDistrictProvider,
                    DonorUiController
                  >(
                    builder: (context, donorRepo, state, uiController, child) {
                      return CustomElevatedButton(
                        onPressed: () {
                          log(
                            "Selected Blood Type: ${uiController.bloodTypeValue}",
                          );
                          log("Selected State: ${state.selectedState}");
                          log("Selected District: ${state.selectedDistrict}");
                          if (uiController.bloodTypeValue == null ||
                              state.selectedState == null ||
                              state.selectedDistrict == null) {
                            failedSnackBar(
                              message: "Please select all fields",
                              context: context,
                            );
                            return;
                          }
                          final DonorModel donorModel = DonorModel(
                            donorId: '',
                            name: '',
                            age: 0,
                            gender: '',
                            dob: DateTime.now(),
                            bloodGroup: uiController.bloodTypeValue!,
                            phone: '',
                            email: '',
                            address: '',
                            city: state.selectedDistrict!,
                            state: state.selectedState!,
                            acceptedTerms: false,
                            imageUrl: '',
                          );

                          // Filter the donors
                          final filteredDonors = donorRepo
                              .filterWithRestricedByModel(donor: donorModel);

                          // Navigate to new screen to show results
                          justNavigate(
                            context: context,
                            route: FilterDataDonor(donor: filteredDonors),
                          );
                        },
                        child: const Text(
                          "Filter",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
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
