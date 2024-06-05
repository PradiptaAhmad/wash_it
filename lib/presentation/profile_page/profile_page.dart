import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';
import 'package:wash_it/widget/common/button_widget.dart';
import 'package:wash_it/widget/common/content_title_widget.dart';
import 'controllers/profile_page.controller.dart';

class ProfilePage extends GetView<ProfileController> {
  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Profile', style: tsTitleSmallMedium(black))),
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
        child: Obx(() {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(defaultMargin),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: grey,
                          backgroundImage: NetworkImage(controller
                                  .userData['image_path'] ??
                              "https://www.pradiptaahmad.tech/image/${controller.userData['image_path']}"
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
                      controller.userName.value,
                      style: tsBodyMediumMedium(black),
                    ),
                    Text(
                      controller.email.value,
                      style: tsBodySmallMedium(black),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Divider(color: lightGrey, thickness: 1),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: ContentTitleWidget(
                    title: "Pengaturan Edit Profile",
                    lefttextSize: tsBodyMediumMedium(black),
                  ),
                ),
                ListTileButton(
                    context: context,
                    label: 'Nama Lengkap',
                    value: controller.isLoading.value
                        ? 'Loading...'
                        : controller.userData['username'],
                    editTitle: 'Ganti Username',
                    onSave: (newVal) {
                      controller.updateUserName(newVal);
                    }),
                ListTileButton(
                    context: context,
                    label: 'Email',
                    value: controller.isLoading.value
                        ? 'Loading...'
                        : controller.userData['email'],
                    editTitle: 'Ganti Email',
                    onSave: (newVal) {
                      controller.updateEmail(newVal);
                    }),
                ListTileButton(
                  context: context,
                  label: 'Nomor Telepon',
                  value: controller.isLoading.value
                      ? 'Loading...'
                      : controller.userData['phone'],
                  editTitle: 'Ganti Nomor Telepon',
                  onSave: (newVal) {
                    controller.updatePhoneNumber(newVal);
                  },
                ),
                ListTileButton(
                  context: context,
                  label: 'Ganti Password',
                  value: '',
                  editTitle: 'Ganti Password',
                  onSave: (newVal) {
                    controller.updatePassword(newVal);
                  },
                ),
                Divider(color: lightGrey, thickness: 1),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultMargin),
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
                    onTap: () {}),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class ListTileButton extends StatelessWidget {
  ListTileButton(
      {super.key,
      required this.context,
      this.label,
      this.value,
      this.editTitle,
      this.onSave});

  final BuildContext context;
  final String? label, value, editTitle;
  final Function(String)? onSave;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text('$label', style: tsBodySmallRegular(darkBlue)),
      trailing: Icon(Iconsax.arrow_right_3, size: 16),
      onTap: () {
        showDialogFunction(context, editTitle!, value!, onSave!);
      },
    );
  }
}

void showDialogFunction(BuildContext context, String headTitle,
    String currentValue, Function(String) onSave) {
  TextEditingController _textController =
      TextEditingController(text: currentValue);

  showDialog(
    useSafeArea: true,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(headTitle, style: tsBodyMediumMedium(black)),
        content: TextField(
          controller: _textController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: lightGrey, width: 2),
            ),
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actionsOverflowDirection: VerticalDirection.down,
        actions: <Widget>[
          ButtonWidget(
              text: 'Batal',
              onPressed: () {
                Get.back();
              },
              child: Padding(
                  padding: const EdgeInsets.all(defaultMargin),
                  child: Text(
                    'Batal',
                    style: tsBodySmallMedium(black),
                  ))),
          SizedBox(height: 10),
          ButtonWidget(
              backgroundColor: secondaryColor,
              onPressed: () {
                Get.back();
              },
              child: Padding(
                  padding: const EdgeInsets.all(defaultMargin),
                  child: Text(
                    'Konfirmasi',
                    style: tsBodySmallMedium(primaryColor),
                  ))),
        ],
      );
    },
  );
}
