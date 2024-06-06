import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';
import 'package:wash_it/presentation/profile_page/profile_change_page.dart';
import 'package:wash_it/widget/common/content_title_widget.dart';
import 'controllers/profile_page.controller.dart';

class ProfilePage extends GetView<ProfileController> {
  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Profile', style: tsTitleSmallMedium(black))),
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(defaultMargin),
          child: Column(
            children: [
              Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return MainProfileWidget(controller: controller);
                }
              }),
              SizedBox(height: 10),
              Divider(color: lightGrey, thickness: 1),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
                child: ContentTitleWidget(
                  title: "Pengaturan Edit Profile",
                  lefttextSize: tsBodyMediumMedium(black),
                ),
              ),
              ListTileButton(
                label: 'Username',
                onTap: () => Get.to(
                  ProfileChangePage(
                    title: 'Username',
                    hintText: controller.userData['username'],
                    validator: (newValue) {
                      controller.updateUserName(newValue);
                      return null;
                    },
                    onTap: () => controller.updateUserNameData(),
                  ),
                ),
              ),
              ListTileButton(
                label: 'Email',
                onTap: () => Get.to(
                  ProfileChangePage(
                    title: 'Email',
                    hintText: controller.userData['email'],
                    validator: (newValue) {
                      controller.updateEmail(newValue);
                      return null;
                    },
                    onTap: () => controller.updateEmailData(),
                  ),
                ),
              ),
              ListTileButton(
                label: 'Nomor Telepon',
                onTap: () => Get.to(
                  ProfileChangePage(
                    title: 'Nomor Telepon',
                    hintText: controller.userData['phone'],
                    validator: (newValue) {
                      controller.updatePhoneNumber(newValue);
                      return null;
                    },
                    onTap: () => controller.updateUserPhoneData(),
                  ),
                ),
              ),
              ListTileButton(
                label: 'Ganti Password',
                onTap: () => Get.to(
                  ProfileChangePage(
                    title: 'Password',
                    // validator: (newValue) {
                    //   controller.updateEmail(newValue);
                    //   return null;
                    // },
                  ),
                ),
              ),
              Divider(color: lightGrey, thickness: 1),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
                child: ContentTitleWidget(
                  title: 'Pengaturan Akun',
                  lefttextSize: tsBodyMediumMedium(black),
                ),
              ),
              ListTile(
                  dense: true,
                  title: Text('Nonaktifkan Akun',
                      style: tsBodySmallRegular(warningColor)),
                  onTap: () {}),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Divider(color: Color(0xFFDEDEDE), thickness: 1),
              ),
              ListTile(
                  title:
                      Text('Logout', style: tsBodyMediumMedium(warningColor)),
                  onTap: () {
                    controller.logout();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class MainProfileWidget extends StatelessWidget {
  const MainProfileWidget({
    super.key,
    required this.controller,
  });

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: grey,
              backgroundImage: NetworkImage(controller.userData['image_path'] ??
                  // "https://www.pradiptaahmad.tech/image/${controller.userData['image_path']}" ??
                  'https://via.placeholder.com/150'),
            ),
            Positioned(
                bottom: 0,
                right: 4,
                child: GestureDetector(
                    onTap: () {
                      // Handle profile picture change
                    },
                    child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.edit,
                          size: 15,
                          color: Colors.black,
                        )))),
          ],
        ),
        Text(
          controller.userData['username'],
          style: tsBodyMediumMedium(black),
        ),
        Text(
          controller.userData['email'],
          style: tsBodySmallMedium(black),
        ),
      ],
    );
  }
}

class ListTileButton extends StatelessWidget {
  ListTileButton({
    super.key,
    this.label,
    required this.onTap,
  });

  final String? label;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text('$label', style: tsBodySmallRegular(darkBlue)),
      trailing: Icon(Iconsax.arrow_right_3, size: 16),
      onTap: onTap,
    );
  }
}
