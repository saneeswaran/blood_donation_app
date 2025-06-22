// ignore_for_file: deprecated_member_use

import 'package:blood_donation/core/color/appcolor.dart';
import 'package:blood_donation/features/search/view%20model/search_repo.dart';
import 'package:blood_donation/features/search/view/widget/user_list_template.dart';
import 'package:blood_donation/features/widgets/custom_elevated_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewUserTemplate extends StatefulWidget {
  const ViewUserTemplate({super.key});

  @override
  State<ViewUserTemplate> createState() => _ViewUserTemplateState();
}

class _ViewUserTemplateState extends State<ViewUserTemplate> {
  @override
  void initState() {
    super.initState();
    context.read<SearchRepo>().hideScrollBar();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Consumer<SearchRepo>(
        builder: (context, provider, child) {
          final isShowBottom = provider.isShowBottom;
          return SingleChildScrollView(
            controller: provider.scrollController,
            child: isShowBottom
                ? Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    height: size.height * 0.1,
                    width: size.width * 1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Appcolor.scaffoldBackgroundColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 4,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: size.height * 0.07,
                          width: size.width * 0.4,
                          child: CustomElevatedButton(
                            onPressed: () {},
                            child: const Text(
                              "Call",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.07,
                          width: size.width * 0.4,
                          child: CustomElevatedButton(
                            onPressed: () {},
                            backgroundColor: Appcolor.scaffoldBackgroundColor,
                            child: const Text(
                              "Request",
                              style: TextStyle(color: Appcolor.primaryColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          );
        },
      ),
      appBar: AppBar(
        backgroundColor: Appcolor.scaffoldBackgroundColor,
        centerTitle: true,
        title: const Text(
          "UserName",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        spacing: 12,
        children: [
          //image
          const Center(
            child: CircleAvatar(
              radius: 60,
              backgroundImage: CachedNetworkImageProvider(
                "https://cdn.hero.page/pfp/8ff73a9f-2f4b-4b7e-b5c2-bcf085d192f6-chibi-anime-girl-portrait-cute-anime-profile-pictures-for-girls-1.png",
              ),
            ),
          ),
          const Center(
            child: Text(
              "UserName",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          const Center(
            child: Text(
              "Last Donation : December, 2024",
              style: TextStyle(fontSize: 18, color: Appcolor.mediaiuGrey),
            ),
          ),
          const SizedBox(height: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _customContainer(size: size, title: "Donated", value: "06"),
              _customContainer(size: size, title: "Blood Type", value: "A-"),
              _customContainer(size: size, title: "Age", value: "20"),
            ],
          ),
          Expanded(
            child: SizedBox(
              height: size.height * 0.7,
              width: size.width * 1,
              child: const UserListTemplate(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _customContainer({
    required Size size,
    required String title,
    required String value,
  }) {
    return Container(
      height: size.height * 0.1,
      width: size.width * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Appcolor.lightGrey,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, color: Appcolor.grey),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
