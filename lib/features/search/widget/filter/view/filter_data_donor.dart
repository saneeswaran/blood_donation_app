import 'package:blood_donation/core/color/appcolor.dart';
import 'package:blood_donation/core/util/photo_viewer.dart';
import 'package:blood_donation/core/util/util.dart';
import 'package:blood_donation/features/form/model/donor_model.dart';
import 'package:blood_donation/features/search/view/widget/view_user_template.dart';
import 'package:blood_donation/features/widgets/custom_text_formfield.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FilterDataDonor extends StatefulWidget {
  final List<DonorModel> donor;
  const FilterDataDonor({super.key, required this.donor});

  @override
  State<FilterDataDonor> createState() => _FilterDataDonorState();
}

class _FilterDataDonorState extends State<FilterDataDonor> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          top: 40,
          left: 20,
          right: 20,
          bottom: 20,
        ),
        height: size.height * 1,
        width: size.width * 1,
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.07,
              width: size.width * 1,
              child: CustomTextFormfield(
                hintText: "Search",
                controller: searchController,
                prefixIcon: const Icon(Icons.search, color: Appcolor.grey),
              ),
            ),
            ListView.builder(
              itemCount: widget.donor.length,
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final donors = widget.donor[index];
                //outline border
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: size.height * 0.09,
                  width: size.width * 1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Appcolor.lightGrey,
                  ),
                  child: ListTile(
                    onTap: () =>
                        navigateTo(context, ViewUserTemplate(donor: donors)),
                    leading: GestureDetector(
                      onTap: () => justNavigate(
                        context: context,
                        route: PhotoViewer(imageUrl: donors.imageUrl),
                      ),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: CachedNetworkImageProvider(
                          donors.imageUrl,
                        ),
                      ),
                    ),
                    title: Text(
                      donors.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: Appcolor.primaryColor,
                        ),
                        Text(
                          "${donors.state}, ${donors.city}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    trailing: const Icon(
                      Icons.bloodtype,
                      color: Appcolor.primaryColor,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
