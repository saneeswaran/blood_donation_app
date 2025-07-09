import 'package:blood_donation/core/color/appcolor.dart';
import 'package:blood_donation/features/form/controller/donor_ui_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterDonors extends StatelessWidget {
  const FilterDonors({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        height: size.height * 1,
        width: size.width * 1,
        child: Column(
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
                    return Container(
                      height: size.height * 0.1,
                      width: size.width * 0.2,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? Appcolor.primaryColor
                            : Appcolor.lightGrey,
                      ),
                      child: Center(
                        child: Text(
                          bloodType,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
