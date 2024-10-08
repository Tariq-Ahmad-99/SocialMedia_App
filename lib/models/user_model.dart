class UserModel
{
  String? name;
  String? email;
  String? phone;
  late String uId;
  String? image;
  String? cover;
  String? bio;
  bool? isEmailVerified;

  UserModel({
    this.name,
    this.email,
    this.phone,
    required this.uId,
    this.image,
    this.cover,
    this.bio,
    this.isEmailVerified
  });

  UserModel.fromJson(Map<String, dynamic> json)
  {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap()
  {
    return{
      'email':email,
      'name':name,
      'phone':phone,
      'uId':uId,
      'image':image,
      'cover':cover,
      'bio':bio,
      'isEmailVerified':isEmailVerified,
    };
  }

}

