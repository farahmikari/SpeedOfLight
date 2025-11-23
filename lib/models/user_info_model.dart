class UserInfoModel {
  final String token;
  final UserModel? user;
  final String message;

  UserInfoModel(
      {required this.user, required this.token, required this.message});

  factory UserInfoModel.fromJson(jsonData) {
    return UserInfoModel(
      user: jsonData['user'] == null
          ? null
          : UserModel.fromJson(jsonData['user']),
      token: jsonData['token'],
      message: jsonData['message'],
    );
  }

   Map<String, dynamic> toJson() => {
        "message": message,
        "user": user!.toJson(),
        "token": token,
    };
}

class UserModel {
  final String firstName;
  final String lastName;
  final dynamic phoneNumber;
  final String country;
  final String city;
  final String? password;
  final String? passwordConf;
  final dynamic id;
  dynamic image;

  UserModel(
      { this.image,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.country,
      required this.city,
      required this.id,
       this.password,
       this.passwordConf,
      });

  factory UserModel.fromJson(jsonData) {
    return UserModel(
      image: jsonData['image'],
      id: jsonData['id'],
      firstName: jsonData['first_name'],
      lastName: jsonData['last_name'],
      phoneNumber: jsonData['phone_number'],
      country: jsonData['country'],
      city: jsonData['city'],
     
    );
  }
   Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "phone_number": phoneNumber,
        "country": country,
        "city": city,
        "id": id,
    };
}
