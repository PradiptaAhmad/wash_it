import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';
import 'package:wash_it/presentation/profile_page/profile_change_page.dart';
import 'package:wash_it/widgets/common/content_title_widget.dart';
import 'package:wash_it/widgets/shimmer/shimmer_widget.dart';
import 'controllers/profile_page.controller.dart';

class ProfilePage extends GetView<ProfileController> {
  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => await controller.fetchUserData(),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Center(child: MainProfileWidget()),
                SizedBox(height: 5),
                Divider(color: lightGrey, thickness: 1),
                SizedBox(height: 10),
                Obx(
                  () => !controller.isLoading.value
                      ? ContentTitleWidget(
                          margin: 0,
                          title: "Info Profil",
                          lefttextSize: tsBodyMediumMedium(black),
                        )
                      : ShimmerWidget(
                          radius: 10,
                          width: 80,
                          height: 21,
                        ),
                ),
                SizedBox(height: 20),
                Obx(
                  () => !controller.isLoading.value
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Username',
                                style: tsBodySmallRegular(darkGrey)),
                            InkWell(
                              onTap: () => Get.to(
                                ProfileChangePage(
                                  title: 'Username',
                                  hintText: controller.userData['username'],
                                  validator: (newValue) {
                                    controller.userName.value = newValue;
                                    return null;
                                  },
                                  onTap: () => controller.updateUserNameData(),
                                ),
                              )!
                                  .then((value) {
                                controller.fetchUserData();
                              }),
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
                        )
                      : shimmerInfoList(),
                ),
                SizedBox(height: 20),
                Obx(
                  () => !controller.isLoading.value
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Email', style: tsBodySmallRegular(darkGrey)),
                            InkWell(
                              onTap: () async {
                                await Get.to(ProfileChangePage(
                                  title: 'Email',
                                  hintText: controller.userData['email'],
                                  validator: (newValue) {
                                    controller.email.value = newValue;
                                    return null;
                                  },
                                  onTap: () => controller.updateEmailData(),
                                ))!
                                    .then((value) {
                                  controller.fetchUserData();
                                });
                              },
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
                        )
                      : shimmerInfoList(),
                ),
                SizedBox(height: 20),
                Obx(
                  () => !controller.isLoading.value
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Nomor Hp',
                                style: tsBodySmallRegular(darkGrey)),
                            InkWell(
                              onTap: () => Get.to(
                                ProfileChangePage(
                                  title: 'Nomor Telepon',
                                  hintText: controller.userData['phone'],
                                  validator: (newValue) {
                                    controller.phoneNumber.value = newValue;
                                    return null;
                                  },
                                  onTap: () => controller.updateUserPhoneData(),
                                ),
                              )!
                                  .then((value) {
                                controller.fetchUserData();
                              }),
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
                        )
                      : shimmerInfoList(),
                ),
                SizedBox(height: 20),
                Obx(
                  () => !controller.isLoading.value
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Ubah Password',
                                style: tsBodySmallRegular(darkGrey)),
                            InkWell(
                              onTap: () => Get.to(
                                ProfileChangePage(
                                  title: 'Password',
                                  hintText: '********',
                                  validator: (newValue) {
                                    controller.password.value = newValue;
                                    return null;
                                  },
                                  onTap: () => controller.updatePasswordData(),
                                ),
                              )!
                                  .then((value) {
                                controller.fetchUserData();
                              }),
                              child: Row(
                                children: [
                                  Text('', style: tsBodySmallRegular(black)),
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
                        )
                      : shimmerInfoList(),
                ),
                SizedBox(height: 20),
                Obx(
                  () => !controller.isLoading.value
                      ? ContentTitleWidget(
                          margin: 0,
                          title: "Lainnya",
                          lefttextSize: tsBodyMediumMedium(black),
                        )
                      : ShimmerWidget(
                          radius: 10,
                          width: 80,
                          height: 22,
                        ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Obx(
                        () => !controller.isLoading.value
                            ? InkWell(
                                onTap: () {},
                                child: Text(
                                  'Hapus akun',
                                  style: tsBodySmallRegular(black),
                                ),
                              )
                            : ShimmerWidget(
                                radius: 8,
                                width: 100,
                                height: 20,
                              ),
                      ),
                      SizedBox(height: 20),
                      Obx(
                        () => !controller.isLoading.value
                            ? InkWell(
                                onTap: () => controller
                                    .showExitConfirmationDialog(context),
                                child: Text('Keluar akun',
                                    style: tsBodySmallRegular(warningColor)),
                              )
                            : ShimmerWidget(
                                radius: 8,
                                width: 100,
                                height: 20,
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget shimmerInfoList() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      ShimmerWidget(
        radius: 8,
        width: 100,
        height: 18,
      ),
      ShimmerWidget(
        radius: 8,
        width: 200,
        height: 18,
      ),
    ],
  );
}

class MainProfileWidget extends GetView<ProfileController> {
  const MainProfileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => !controller.isLoading.value
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: grey,
                  backgroundImage: NetworkImage(controller
                              .userData['image_path'] ==
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
                SizedBox(height: 10),
                Text(
                  controller.userData['username'] ?? "default Username",
                  style: tsBodySmallSemibold(black),
                ),
                Text(
                  controller.userData['email'] ?? "default Email",
                  style: tsLabelLargeMedium(black),
                ),
              ],
            )
          : Column(
              children: [
                ShimmerWidget(
                  radius: 40,
                  width: 80,
                  height: 80,
                ),
                SizedBox(height: 5),
                ShimmerWidget(
                  radius: 20,
                  width: 100,
                  height: 20,
                ),
                SizedBox(height: 5),
                ShimmerWidget(
                  radius: 20,
                  width: 160,
                  height: 20,
                ),
                SizedBox(height: 5),
                ShimmerWidget(
                  radius: 10,
                  width: 200,
                  height: 15,
                ),
              ],
            ),
    );
  }
}
