import 'package:flutter/material.dart';
import 'package:smart_health_assistant/api/doctor_api.dart';
import '../models/doctor.dart';
import '/api/appointment_api.dart';

class ApiNotifier extends ChangeNotifier {
  bool isLoading = false;
  List<Doctor?> doctorList = [];
  void addAppointment(Map<String, dynamic> appointmentData) async {
    var response = await createAppointment(appointmentData);
    debugPrint(response);
    notifyListeners();
  }

  void getDoctorsList() async {
    isLoading = true;
    await Future.delayed(const Duration(seconds: 1), () {});
    doctorList = await getDoctorsData();
    isLoading = false;
    notifyListeners();
  }
}
