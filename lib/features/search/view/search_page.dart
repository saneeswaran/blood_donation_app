import 'package:animations/animations.dart';
import 'package:blood_donation/core/color/appcolor.dart';
import 'package:blood_donation/features/form/view%20model/donor_repo.dart';
import 'package:blood_donation/features/search/view/widget/user_list_template.dart';
import 'package:blood_donation/features/search/widget/filter/view/filter_donors.dart';
import 'package:blood_donation/features/widgets/custom_text_formfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<DonorRepo>().getAllDonors(context: context);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Appcolor.scaffoldBackgroundColor,
        centerTitle: true,
        title: const Text(
          "Find Donor",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          spacing: 8,
          children: [
            _searchAndFilter(size),
            const Expanded(child: UserListTemplate()),
          ],
        ),
      ),
    );
  }

  Row _searchAndFilter(Size size) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: size.height * 0.07,
            width: size.width * 1,
            child: CustomTextFormfield(
              hintText: "Search",
              controller: searchController,
              prefixIcon: const Icon(Icons.search, color: Appcolor.grey),
            ),
          ),
        ),
        const SizedBox(width: 15),
        SizedBox(
          height: size.height * 0.07,
          width: size.width * 0.13,
          child: OpenContainer(
            transitionType: ContainerTransitionType.fadeThrough,
            transitionDuration: const Duration(milliseconds: 400),
            closedElevation: 0.0,
            closedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            openBuilder: (context, closedContainer) => const FilterDonors(),
            closedBuilder: (context, openContainer) {
              return IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: Appcolor.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(12),
                  ),
                ),
                onPressed: openContainer,
                icon: const Icon(
                  Icons.format_list_bulleted_sharp,
                  color: Colors.white,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
