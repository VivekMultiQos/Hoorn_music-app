import 'dart:io';


class MDLUserParam {
  String? countryCode;
  String? phone;
  String? password;

  MDLUserParam({
    this.countryCode,
    this.password,
    this.phone,
  });

  Map<String, dynamic> get toJson {
    return {
      'countryCode': countryCode,
      'phone': phone,
      'password': password,
    };
  }
}

class ResetPasswordParam {
  String countryCode;
  String phone;
  // String otp;
  String newPassword;
  String confirmPassword;

  ResetPasswordParam(
      {required this.countryCode,
        required this.phone,
        // required this.otp,
        required this.newPassword,
        required this.confirmPassword,

      });

  Map<String, dynamic> get toJson {
    return {
      "countryCode": countryCode,
      "phone": phone,
      // 'otp': int.parse(otp),
      "password": newPassword,
      "confirmPassword": confirmPassword,
    };
  }
}


class MDLChangePasswordParam {
  String? oldPassword;
  String? newPassword;
  String? confirmPassword;

  MDLChangePasswordParam(
      {this.oldPassword, this.newPassword, this.confirmPassword});

  Map<String, dynamic> get toJson {
    return {
      'oldPassword': oldPassword,
      'password': newPassword,
      'confirmPassword': confirmPassword,
    };
  }
}

class MDlRegisterAccountParam {
  String firstName;
  String lastName;
  String countryCode;
  String mobileNumber;
  String email;
  String password;
  String address;
  File profilePicture;
  String countryID;
  String countryName;
  String cityName;
  String deviceToken;

  MDlRegisterAccountParam({
    required this.firstName,
    required this.lastName,
    required this.countryCode,
    required this.mobileNumber,
    required this.email,
    required this.password,
    required this.address,
    required this.profilePicture,
    required this.countryID,
    required this.countryName,
    required this.cityName,
    required this.deviceToken,
  });

  Map<String, dynamic> get toJson {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'countryCode': countryCode,
      'mobileNumber': mobileNumber,
      'email': email,
      'password': password,
      'address': address,
      'profilePicture': profilePicture,
      'countryId': countryID,
      'countryName': countryName,
      'cityName': cityName,
      'deviceToken': deviceToken,
    };
  }
}
