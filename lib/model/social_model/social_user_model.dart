class UserModel {
  String name;
  String email;
  String phone;
  String image;
  String uId;
  String bio;
  bool isEmailVerified;

  UserModel({
    this.phone,
    this.name,
    this.uId,
    this.email,
    this.image,
    this.bio,
    this.isEmailVerified,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    bio = json['bio'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'image': image,
      'uId': uId,
      'bio': bio,
      'isEmailVerified': isEmailVerified,
    };
  }
}
