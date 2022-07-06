import 'package:flutter/material.dart';
import 'package:smart_health_assistant/models/specialist.dart';

class SpecialistProvider extends ChangeNotifier {
  final List<Specialist> _specialistList = [
    Specialist(
        firstName: "Dr. Estifanos",
        lastName: "Alemu",
        email: "estalemu@gmail.com",
        phone: "0923456787",
        specialization: "Gynecologist",
        imageURL: "assets/images/dr1.jpg"),
    Specialist(
        firstName: "Dr.Fasil",
        lastName: "Kebede",
        email: "fkebde@gmail.com",
        phone: "0922395567",
        specialization: "Psychiatrist",
        imageURL: "assets/images/dr2.jpg"),
    Specialist(
        firstName: "Dr.Sara",
        lastName: "Bekele",
        email: "sbekele@gmail.com",
        phone: "0922456789",
        specialization: " Allergy and Immunology",
        imageURL: "assets/images/dr3.jpg"),
    Specialist(
        firstName: "Dr.Bogale",
        lastName: "Mola",
        email: "bmola@gmail.com",
        phone: "0922345433",
        specialization: "Pediatrics",
        imageURL: "assets/images/dr4.jpg"),
  ];
  List<Specialist> get getSpecialist => _specialistList;
}
