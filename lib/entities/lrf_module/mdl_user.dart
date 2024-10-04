import 'package:floor/floor.dart';

@entity
class MDLUser {
  @primaryKey
  int? status;
  String? authToken;
  String? lmpId;
  String? userId;
  String? firstName;
  String? middleName;
  String? surname;
  String? surnameId;
  String? surnameOther;
  String? officialSurname;
  String? gender;
  String? dob;
  String? phone;
  String? countryCode;
  String? countryCodeWA;
  String? whatsappNumber;
  String? email;
  String? education;
  String? educationId;
  String? occupation;
  String? occupationId;
  String? mahajan;
  String? mahajanId;
  String? mahajanOther;
  String? maritalStatus;
  String? maidenName;
  String? maidenSurname;
  String? maidenSurnameId;
  String? currentCity;
  String? placeOfBirth;
  String? nativePlace;
  String? gotra;
  String? gotraId;
  String? gotraOther;
  String? bloodGroup;
  String? thalassemiaStatus;
  String? height;
  String? weight;
  String? profilePicture;
  String? governmentId;
  String? governmentIdFileName;
  bool? isProfile;
  int? stage;
  bool? hasOccupation;
  bool? isNotification;

  MDLUser(
      {this.status,
      this.authToken,
      this.lmpId,
      this.userId,
      this.firstName,
      this.middleName,
      this.surname,
      this.surnameId,
      this.surnameOther,
      this.officialSurname,
      this.gender,
      this.dob,
      this.phone,
      this.countryCode,
      this.countryCodeWA,
      this.whatsappNumber,
      this.email,
      this.mahajan,
      this.mahajanId,
      this.mahajanOther,
      this.education,
      this.educationId,
      this.occupation,
      this.occupationId,
      this.maritalStatus,
      this.maidenName,
      this.maidenSurname,
      this.maidenSurnameId,
      this.currentCity,
      this.placeOfBirth,
      this.nativePlace,
      this.gotra,
      this.gotraId,
      this.gotraOther,
      this.bloodGroup,
      this.thalassemiaStatus,
      this.height,
      this.weight,
      this.profilePicture,
      this.governmentId,
      this.governmentIdFileName,
      this.isProfile,
      this.hasOccupation,
      this.stage,
      this.isNotification
      });

  MDLUser.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    authToken = json['authToken'];
    lmpId = json['lmpId'];
    userId = json['userId'];
    firstName = json['firstName'];
    middleName = json['middleName'];
    surname = json['surname'];
    surnameId = json['surnameId'];
    surnameOther = json['surnameOther'];
    officialSurname = json['officialSurname'];
    gender = json['gender'];
    dob = json['dob'];
    phone = json['phone'];
    countryCode = json['countryCode'];
    countryCodeWA = json['countryCodeWA'];
    whatsappNumber = json['whatsappNumber'];
    email = json['email'];
    mahajan = json['mahajan'];
    mahajanId = json['mahajanId'];
    mahajanOther = json['mahajanOther'];
    education = json['education'];
    educationId = json['educationId'];
    occupation = json['occupation'];
    occupationId = json['occupationId'];
    maritalStatus = json['maritalStatus'];
    maidenName = json['maidenName'];
    maidenSurname = json['maidenSurname'];
    maidenSurnameId = json['maidenSurnameId'];
    currentCity = json['currentCity'];
    placeOfBirth = json['placeOfBirth'];
    nativePlace = json['nativePlace'];
    nativePlace = json['nativePlace'];
    gotra = json['gotra'];
    gotraId = json['gotraId'];
    gotraOther = json['gotraOther'];
    bloodGroup = json['bloodGroup'];
    thalassemiaStatus = json['thalassemiaStatus'];
    height = json['height'];
    weight = json['weight'];
    profilePicture = json['profilePicture'];
    governmentId = json['governmentId'];
    governmentIdFileName = json['governmentIdFileName'];
    isProfile = json['isProfile'];
    hasOccupation = json['hasOccupation'];
    stage = json['stage'];
    isNotification = json['isNotification'];
  }
}
