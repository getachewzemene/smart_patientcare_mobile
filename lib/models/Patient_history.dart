// To parserequired this JSON data, do
//
//     final patierequiredntHistory = patierequiredntHistoryFromJson(jsonString);

import 'dart:convert';

PatientHistory patientHistoryFromJson(String str) =>
    PatientHistory.fromJson(json.decode(str));

class HistoryDoctor {
  HistoryDoctor({
    required this.id,
    required this.specialization,
    required this.imagePath,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.doctorUser,
  });

  String id;
  String specialization;
  String imagePath;
  DateTime createdAt;
  DateTime updatedAt;
  String userId;
  PatientHistory doctorUser;

  factory HistoryDoctor.fromJson(Map<String, dynamic> json) => HistoryDoctor(
        id: json["id"],
        specialization: json["specialization"],
        imagePath: json["imagePath"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        userId: json["userId"],
        doctorUser: PatientHistory.fromJson(json["doctorUser"]),
      );
}

class PrescriptionHistory {
  PrescriptionHistory({
    required this.id,
    required this.compliant,
    required this.investigationResult,
    required this.treatment,
    required this.createdAt,
    required this.updatedAt,
    required this.doctorId,
    required this.patientId,
    required this.prescriptionId,
    required this.historyDoctor,
  });

  String id;
  String compliant;
  String investigationResult;
  String treatment;
  DateTime createdAt;
  DateTime updatedAt;
  String doctorId;
  String patientId;
  String prescriptionId;
  HistoryDoctor historyDoctor;

  factory PrescriptionHistory.fromJson(Map<String, dynamic> json) =>
      PrescriptionHistory(
        id: json["id"],
        compliant: json["compliant"],
        investigationResult: json["investigationResult"],
        treatment: json["treatment"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        doctorId: json["doctorId"],
        patientId: json["patientId"],
        prescriptionId: json["prescriptionId"],
        historyDoctor: HistoryDoctor.fromJson(json["historyDoctor"]),
      );
}

class PatientPrescription {
  PatientPrescription(
      {required this.id,
      required this.diseaseName,
      required this.medicineName,
      required this.description,
      required this.dosage,
      required this.createdAt,
      required this.updatedAt,
      required this.doctorId,
      required this.patientId,
      required this.prescriptionHistory,
      this.isExpanded = false});
  bool isExpanded = false;
  String id;
  String diseaseName;
  String medicineName;
  String description;
  int dosage;
  DateTime createdAt;
  DateTime updatedAt;
  String doctorId;
  String patientId;
  PrescriptionHistory prescriptionHistory;

  factory PatientPrescription.fromJson(Map<String, dynamic> json) =>
      PatientPrescription(
        id: json["id"],
        diseaseName: json["diseaseName"],
        medicineName: json["medicineName"],
        description: json["description"],
        dosage: json["dosage"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        doctorId: json["doctorId"],
        patientId: json["patientId"],
        prescriptionHistory:
            PrescriptionHistory.fromJson(json["prescriptionHistory"]),
      );
}

class UserPatient {
  UserPatient({
    required this.id,
    required this.weight,
    required this.bloodGroup,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.patientPrescription,
  });
  String id;
  int weight;
  String bloodGroup;
  DateTime createdAt;
  DateTime updatedAt;
  String userId;
  List<PatientPrescription> patientPrescription;

  factory UserPatient.fromJson(Map<String, dynamic> json) => UserPatient(
        id: json["id"],
        weight: json["weight"],
        bloodGroup: json["bloodGroup"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        userId: json["userId"],
        patientPrescription: List<PatientPrescription>.from(
            json["patientPrescription"]
                .map((x) => PatientPrescription.fromJson(x))),
      );

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "weight": weight,
  //       "bloodGroup": bloodGroup,
  //       "createdAt": createdAt.toIso8601String(),
  //       "updatedAt": updatedAt.toIso8601String(),
  //       "userId": userId,
  //       "patientPrescription":
  //           List<dynamic>.from(patientPrescription.map((x) => x.toJson())),
  //     };
}

class PatientHistory {
  PatientHistory({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.gender,
    required this.dob,
    required this.address,
    required this.userPatient,
  });

  String id;
  String firstName;
  String lastName;
  String email;
  String phone;
  String gender;
  DateTime dob;
  String address;
  UserPatient? userPatient;

  factory PatientHistory.fromJson(Map<String, dynamic> json) => PatientHistory(
        id: json["id"] ?? "",
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
        email: json["email"],
        phone: json["phone"],
        gender: json["gender"],
        dob: DateTime.parse(json["DOB"]),
        address: json["address"],
        userPatient: json["userPatient"] == null
            ? null
            : UserPatient.fromJson(json["userPatient"]),
      );
}
