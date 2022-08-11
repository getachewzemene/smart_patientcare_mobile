import 'package:flutter/material.dart';

import 'package:smart_health_assistant/providers/api_notifier.dart';
import 'package:smart_health_assistant/widgets/custom_snackbar.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

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
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2), () {});
    if (key.currentState!.validate()) {
      setState(() {
        isLoading = false;
      });
      Map<String, dynamic> appointmentData = {
        "id": 1,
        "title": titleController.text,
        "status": "pending",
        "doctorId": 3,
        "patinetId": 6
      };
      // print(appointmentData);
      ApiNotifier().addAppointment(appointmentData);
      customSnackBar(false, context, "appointment submit success");
    } else {
      setState(() {
        isLoading = false;
      });
      customSnackBar(true, context, "invalid appointment submition");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Appointment"), actions: []),
        body: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
                key: key,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                              : const Text("Submit"),
                          color: Colors.blueGrey,
                          textColor: Colors.white,
                          height: 40.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          onPressed: submitAppointment,
                        ),
                      ),
                    ])),
          ),
        ));
  }
}
