// To parse this JSON data, do
//
//     final doctor = doctorFromJson(jsonString);

import 'dart:convert';

List<Doctor> doctorFromJson(String str) =>
    List<Doctor>.from(json.decode(str).map((x) => Doctor.fromJson(x)));

class Doctor {
  Doctor({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.gender,
    required this.dob,
    required this.address,
    required this.role,
    required this.doctor,
  });

  String id;
  String firstName;
  String lastName;
  String email;
  String phone;
  String gender;
  DateTime dob;
  String address;
  String role;
  DoctorData doctor;

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        id: json["id"] ?? "",
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
        email: json["email"] ?? "",
        phone: json["phone"] ?? "",
        gender: json["gender"] ?? "",
        dob: DateTime.parse(json["DOB"]),
        address: json["address"] ?? "",
        role: json["role"] ?? "",
        doctor: DoctorData.fromJson(json["userDoctor"]),
      );
}

class DoctorData {
  DoctorData({
    required this.id,
    required this.specialization,
    required this.imagePath,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  String id;
  String specialization;
  String imagePath;
  DateTime createdAt;
  DateTime updatedAt;
  String userId;

  factory DoctorData.fromJson(Map<String, dynamic> json) => DoctorData(
        id: json["id"] ?? "",
        specialization: json["specialization"] ?? "",
        imagePath: json["imagePath"] ?? "",
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        userId: json["userId"] ?? "",
      );
}
