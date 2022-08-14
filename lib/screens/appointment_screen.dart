import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_health_assistant/constants/widget_params.dart';

import 'package:smart_health_assistant/providers/api_notifier.dart';
import 'package:smart_health_assistant/utils/user_utils.dart';
import 'package:smart_health_assistant/widgets/custom_snackbar.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({Key? key, required this.doctorId}) : super(key: key);
  final String doctorId;
  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final titleController = TextEditingController();

  final key = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  void initState() {
    // getDoctorsData();
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  void submitAppointment() async {
    var apiNotifier = Provider.of<ApiNotifier>(context, listen: false);
    var currentUserPreference = await getCurrentUser();
    var currentUser = jsonDecode(currentUserPreference!);
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 1), () {});
    if (key.currentState!.validate()) {
      setState(() {
        isLoading = false;
      });
      Map<String, dynamic> appointmentData = {
        "id": generateId(),
        "title": titleController.text,
        "status": "pending",
        "doctorId": widget.doctorId,
        "patientId": currentUser["id"]
      };

      // print("currentUserId: ${currentUser['id']}");
      // print("currentUseremail: ${currentUser['email']}");
      // print("doctorId: ${widget.doctorId}");
      // print(appointmentData);

      await apiNotifier.addAppointment(appointmentData);
      // print(apiNotifier.responseMessage);
      customSnackBar(
          false,
          context,
          apiNotifier.successMessage == ""
              ? apiNotifier.errorMessage
              : apiNotifier.successMessage);
      await Future.delayed(const Duration(seconds: 1), () {});
      if (apiNotifier.successMessage != "") {
        Navigator.of(context).pop();
      }
    } else {
      setState(() {
        isLoading = false;
      });
      customSnackBar(true, context, "invalid form submission");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              "Book Appointment",
              style: TextStyle(fontSize: 16.0),
            ),
            centerTitle: true,
            backgroundColor: contentColor,
            actions: []),
        body: Container(
          margin: const EdgeInsets.only(top: 50.0),
          padding: const EdgeInsets.all(10.0),
          child: Form(
              key: key,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                        controller: titleController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Colors.blue,
                            ),
                            label: const Text("appointment case"),
                            hintText: "enter some description",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter valid description';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Center(
                      child: MaterialButton(
                        child: isLoading
                            ? const SizedBox(
                                height: 25,
                                width: 25,
                                child: CircularProgressIndicator())
                            : const Text(
                                "Submit",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0),
                              ),
                        color: Color.fromARGB(255, 48, 156, 129),
                        textColor: Colors.white,
                        minWidth: MediaQuery.of(context).size.width - 150,
                        height: 45.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        onPressed: submitAppointment,
                      ),
                    ),
                  ])),
        ));
  }
}
