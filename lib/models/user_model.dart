class UserModel {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String image;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.image,
  });

  // Convert to Firestore Map
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "phone": phone,
      "address": address,
      "image": image,
    };
  }

  // Convert from Firestore Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map["uid"] ?? "",
      name: map["name"] ?? "",
      email: map["email"] ?? "",
      phone: map["phone"] ?? "",
      address: map["address"] ?? "",
      image: map["image"] ?? "",
    );
  }
}
