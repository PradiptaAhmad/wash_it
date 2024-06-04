import 'package:get/get.dart';

class ProfileController extends GetxController {
  var userName = 'Nama Pengguna'.obs;
  var email = 'email@example.com'.obs;
  var phoneNumber = '081234567890'.obs;

  void updateUserName(String newUserName) {
    userName.value = newUserName;
  }

  void updateEmail(String newEmail) {
    email.value = newEmail;
  }

  void updatePhoneNumber(String newPhoneNumber) {
    phoneNumber.value = newPhoneNumber;
  }

  void updatePassword(String newPassword) {
    // Handle password update logic
  }
}
