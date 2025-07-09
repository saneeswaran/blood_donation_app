import 'package:blood_donation/core/color/appcolor.dart';
import 'package:blood_donation/core/util/photo_viewer.dart';
import 'package:blood_donation/core/util/util.dart';
import 'package:blood_donation/features/form/view%20model/donor_repo.dart';
import 'package:blood_donation/features/search/view/widget/view_user_template.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class UserListTemplate extends StatelessWidget {
  const UserListTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Consumer<DonorRepo>(
      builder: (context, provider, child) {
        final isLoading = provider.isLoading;
        return isLoading
            ? Skeletonizer(
                child: ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const CircleAvatar(),
                      title: Text("Donor Name $index"),
                      subtitle: const Text("State, City"),
                      trailing: const Icon(Icons.bloodtype),
                    );
                  },
                ),
              )
            : ListView.builder(
                itemCount: provider.filterDonor.length,
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final donors = provider.filterDonor[index];
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
              );
      },
    );
  }
}
