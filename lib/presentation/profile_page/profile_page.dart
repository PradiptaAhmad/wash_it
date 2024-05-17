import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profile_controller.dart';

class ProfilePage extends StatelessWidget {
  final ProfileController _controller = Get.put(ProfileController());

  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Obx(() {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: NetworkImage('https://via.placeholder.com/150'),
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
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  _controller.userName.value,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  _controller.email.value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 16),
                Divider(color: Color(0xFFDEDEDE), thickness: 1),
                SizedBox(height: 16),
                ListTile(
                  title: Text(
                    'Pengaturan Edit Profile',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                _buildEditProfileItem(context, 'Username', _controller.userName.value, 'Ganti Username', (newVal) {
                  _controller.updateUserName(newVal);
                }),
                _buildEditProfileItem(context, 'Email', _controller.email.value, 'Ganti Email', (newVal) {
                  _controller.updateEmail(newVal);
                }),
                _buildEditProfileItem(context, 'Nomor Telepon', _controller.phoneNumber.value, 'Ganti Nomor Telepon', (newVal) {
                  _controller.updatePhoneNumber(newVal);
                }),
                _buildEditProfileItem(context, 'Ganti Password', '••••••••', 'Ganti Password', (newVal) {
                  _controller.updatePassword(newVal);
                }),
                SizedBox(height: 16),
                Divider(color: Color(0xFFDEDEDE), thickness: 1),
                SizedBox(height: 16),
                ListTile(
                  title: Text(
                    'Pengaturan Akun',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Nonaktifkan Akun',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFFE72929),
                    ),
                  ),
                  onTap: () {
                    // Add logic to handle account deactivation
                  },
                ),
                SizedBox(height: 16),
                Divider(color: Color(0xFFDEDEDE), thickness: 1),
                SizedBox(height: 16),
                ListTile(
                  title: Text(
                    'Logout',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    // Add logic to handle logout
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildEditProfileItem(BuildContext context, String label, String value, String editTitle, Function(String) onSave) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w300,
          color: Colors.black,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        _showEditDialog(context, editTitle, value, onSave);
      },
    );
  }

  void _showEditDialog(BuildContext context, String title, String currentValue, Function(String) onSave) {
    TextEditingController _textController = TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: _textController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Get.back();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF76ABAE),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Konfirmasi',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                onSave(_textController.text);
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }
}
