import 'package:blood_donation/core/color/appcolor.dart';
import 'package:blood_donation/core/util/util.dart';
import 'package:blood_donation/features/search/view/widget/view_user_template.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserListTemplate extends StatelessWidget {
  const UserListTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: 9,
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
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
            onTap: () => navigateTo(context, const ViewUserTemplate()),
            leading: const CircleAvatar(
              radius: 30,
              backgroundImage: CachedNetworkImageProvider(
                "https://cdn.hero.page/pfp/8ff73a9f-2f4b-4b7e-b5c2-bcf085d192f6-chibi-anime-girl-portrait-cute-anime-profile-pictures-for-girls-1.png",
              ),
            ),
            title: const Text(
              "name",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.location_on_outlined, color: Appcolor.primaryColor),
                Text("Location"),
              ],
            ),
            trailing: const Icon(Icons.bloodtype, color: Appcolor.primaryColor),
          ),
        );
      },
    );
  }
}
