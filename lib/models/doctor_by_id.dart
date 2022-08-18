// To parserequired this JSON data, do
//
//     final doctor = doctorFromJson(jsonString);

import 'dart:convert';

DoctorById doctorByIdFromJson(String str) =>
    DoctorById.fromJson(json.decode(str));

class DoctorById {
  DoctorById({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.address,
    required this.specialization,
    required this.imageUrl,
  });

  String id;
  String firstName;
  String lastName;
  String email;
  String phone;
  String address;
  String specialization;
  String imageUrl;

  factory DoctorById.fromJson(Map<String, dynamic> json) => DoctorById(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        specialization: json["specialization"],
        imageUrl: json["imageURL"],
      );
}
