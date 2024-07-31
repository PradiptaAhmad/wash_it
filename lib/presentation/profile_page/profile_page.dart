import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';
import 'package:wash_it/presentation/profile_page/profile_change_page.dart';
import 'package:wash_it/widget/common/content_title_widget.dart';
import 'package:wash_it/widget/common/mainpage_appbar_widget.dart';
import 'controllers/profile_page.controller.dart';

class ProfilePage extends GetView<ProfileController> {
  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            controller.fetchUserData();
            controller.updatePhotoProfile();
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(defaultMargin),
            child: Column(
              children: [
                ContentTitleWidget(
                  title: "Profil Saya",
                  lefttextSize: tsTitleSmallMedium(black),
                ),
                SizedBox(height: 10),
                Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return MainProfileWidget();
                  }
                }),
                SizedBox(height: 5),
                Divider(color: lightGrey, thickness: 1),
                ContentTitleWidget(
                  title: "Info Profil",
                  lefttextSize: tsBodyMediumMedium(black),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Username', style: tsBodySmallRegular(darkGrey)),
                    InkWell(
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
                      child: Row(
                        children: [
                          Text('${controller.userData['username']}',
                              overflow: TextOverflow.ellipsis,
                              style: tsBodySmallRegular(black)),
                          SizedBox(width: 20),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: darkGrey,
                            size: 15,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Email', style: tsBodySmallRegular(darkGrey)),
                    InkWell(
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
                      child: Row(
                        children: [
                          Text('${controller.userData['email']}',
                              style: tsBodySmallRegular(black)),
                          SizedBox(width: 20),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: darkGrey,
                            size: 15,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Nomor Hp', style: tsBodySmallRegular(darkGrey)),
                    InkWell(
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
                      child: Row(
                        children: [
                          Text('${controller.userData['phone']}',
                              style: tsBodySmallRegular(black)),
                          SizedBox(width: 20),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: darkGrey,
                            size: 15,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                ContentTitleWidget(
                  title: "Info Profil",
                  lefttextSize: tsBodyMediumMedium(black),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          'Hapus akun',
                          style: tsBodySmallRegular(warningColor),
                        ),
                      ),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () =>
                            controller.showExitConfirmationDialog(context),
                        child: Text('Keluar akun',
                            style: tsBodySmallRegular(black)),
                      ),
                    ],
                  ),
                )
                // ListTileButton(
                //   label: 'Ganti Password',
                //   onTap: () => Get.to(
                //     ProfileChangePage(
                //       title: 'Password',
                //       // validator: (newValue) {
                //       //   controller.updateEmail(newValue);
                //       //   return null;
                //       // },
                //     ),
                //   ),
                // ),
                // Divider(color: lightGrey, thickness: 1),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
                //   child: ContentTitleWidget(
                //     title: 'Pengaturan Akun',
                //     lefttextSize: tsBodyMediumMedium(black),
                //   ),
                // ),
                // ListTile(
                //     dense: true,
                //     title: Text('Nonaktifkan Akun',
                //         style: tsBodySmallRegular(warningColor)),
                //     onTap: () {}),
                // Padding(
                //   padding: const EdgeInsets.all(5),
                //   child: Divider(color: Color(0xFFDEDEDE), thickness: 1),
                // ),
                // ListTile(
                //     title:
                //         Text('Logout', style: tsBodyMediumMedium(warningColor)),
                //     onTap: () {
                //       controller.logout();
                //     }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MainProfileWidget extends GetView<ProfileController> {
  const MainProfileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: grey,
          backgroundImage: NetworkImage(controller.userData['image_path'] ==
                  null
              ? 'https://ui-avatars.com/api/?name=${controller.userData['username']}&background=random&size=128'
              : 'https://pradiptaahmad.tech/image/${controller.userData['image_path']}'),
        ),
        SizedBox(height: 5),
        InkWell(
          onTap: () {
            controller.pickImage();
          },
          child: Text(
            "Ubah foto profil",
            style: tsBodySmallSemibold(successColor),
          ),
        ),
        /* Stack(
          children: [

            Positioned(
                bottom: 0,
                right: 4,
                child: GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.edit,
                          size: 15,
                          color: Colors.black,
                        )))),
          ],
        ),*/
        // Text(
        //   controller.userData['username'] ?? "default Username",
        //   style: tsBodyMediumMedium(black),
        // ),
        // Text(
        //   controller.userData['email'] ?? "default Email",
        //   style: tsBodySmallMedium(black),
        // ),
      ],
    );
  }
}
