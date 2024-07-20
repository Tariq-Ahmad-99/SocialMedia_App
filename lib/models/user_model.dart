class SocialUserModel
{
  late String name;
  late String email;
  late String phone;
  late String uId;
  late bool isEmailVerified;

  SocialUserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uId,
    required this.isEmailVerified
  });

  SocialUserModel.fromJson(Map<String, dynamic> json)
  {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap()
  {
    return{
      'email':email,
      'name':name,
      'phone':phone,
      'uId':uId,
      'isEmailVerified':isEmailVerified,
    };
  }

}

