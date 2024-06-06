class ProfileModel {
  final int id;
  final String username;
  final String email;
  final String phone;
  final String? imagePath;
  final String phoneVerifiedAt;
  final String createdAt;
  final String updatedAt;

  ProfileModel({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    this.imagePath,
    required this.phoneVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      imagePath: json['image_path'],
      phoneVerifiedAt: json['phone_verified_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
