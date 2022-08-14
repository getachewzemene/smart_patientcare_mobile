import 'package:flutter/material.dart';
import 'package:smart_health_assistant/api/doctor_api.dart';
import '../models/doctor.dart';
import '/api/appointment_api.dart';

class ApiNotifier extends ChangeNotifier {
  bool isLoading = false;
  List<Doctor?> doctorList = [];
  String successMessage = "";
  String errorMessage = "";
  Future<void> addAppointment(Map<String, dynamic> appointmentData) async {
    var response = await createAppointment(appointmentData);
    if (response.statusCode == 200) {
      successMessage = "appointment request added success";
    } else {
      errorMessage = response.body;
    }
    // debugPrint(responseMessage);
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
