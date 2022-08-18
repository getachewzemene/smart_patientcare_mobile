import 'package:flutter/material.dart';
import 'package:smart_health_assistant/api/doctor_api.dart';
import 'package:smart_health_assistant/api/patient_history_api.dart';

import '../models/Patient_history.dart';
import '../models/doctor.dart';
import '/api/appointment_api.dart';

class ApiNotifier extends ChangeNotifier {
  bool isLoading = false;
  List<Doctor?> doctorList = [];
  String successMessage = "";
  String errorMessage = "";
  PatientHistory? history;
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

  Future<void> getDoctorsList() async {
    isLoading = true;
    await Future.delayed(const Duration(seconds: 1), () {});
    var response = await getDoctorsData();
    if (response.statusCode == 200) {
      doctorList = doctorFromJson(response.body);
    } else {
      isLoading = false;
      doctorList = [];
    }
    isLoading = false;
    notifyListeners();
  }

  getPatientHistory(var id) async {
    isLoading = true;
    await Future.delayed(const Duration(seconds: 1), () {});
    history = await getPatientHistoryById(id);
    // print(history!.firstName);
    // print(history!.userPatient!.patientPrescription.length);
    isLoading = false;
    notifyListeners();
  }
}
