import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:smart_health_assistant/api/doctor_api.dart';
import 'package:smart_health_assistant/models/doctor_by_id.dart';
import 'package:smart_health_assistant/screens/video_call/start_meeting_screen.dart';
import 'package:smart_health_assistant/screens/welcome_screen.dart';

import '../constants/api_url.dart';
import '../constants/widget_params.dart';
import '../providers/auth_notifier.dart';
import 'video_call/join_meeting_screen.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({Key? key, required this.id}) : super(key: key);
  final id;
  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  DoctorById? doctorData;
  @override
  void initState() {
    getDoctorById();
    super.initState();
  }

  void logout(context) async {
    var loginNotifier = Provider.of<AuthNotifier>(context, listen: false);
    await loginNotifier.logout();
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()));
  }

  Future<void> getDoctorById() async {
    doctorData = await getDoctorsDataById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: contentColor,
      body: SafeArea(
        child: FutureBuilder(
            future: getDoctorById(),
            builder: (context, _snapShot) {
              if (doctorData == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(50)),
                        child: SizedBox(
                          child: Stack(
                            children: [
                              buildDoctorImage(doctorData!.imageUrl),
                              buildAppBar("Dr." + doctorData!.firstName),
                            ],
                          ),
                        ),
                      ),
                      buildDoctorDescription(doctorData!)
                    ]);
              }
            }),
      ),
    );
  }

  Widget buildAppBar(String name) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              name,
              style: const TextStyle(color: Colors.black, fontSize: 20.0),
            ),
          ),
          InkWell(
            onTap: () => logout(context),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.transparent,
                  border: Border.all(
                      color: Color.fromARGB(255, 255, 250, 250), width: 0.3)),
              margin: const EdgeInsets.only(right: 20),
              child: const Icon(
                Icons.logout,
                color: Color.fromARGB(255, 17, 136, 233),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildDoctorImage(String imageURL) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Image.network(
        getBaseUrl + imageURL,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget buildDoctorDescription(DoctorById doctorById) {
    return Container(
      // height: MediaQuery.of(context).size.height,
      margin: const EdgeInsets.all(30.0),
      color: contentColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Dr." + doctorById.firstName + " " + doctorById.lastName,
            style: const TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
          ),
          Text(
            "Specialization: ${doctorById.specialization}",
            style: TextStyle(fontSize: 16.5, color: Colors.white),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Phone:' + doctorById.phone,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.yellowAccent,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          const SizedBox(
            height: 40.0,
          ),
          Wrap(
            children: [
              MaterialButton(
                  height: 55.0,
                  child: const Text(
                    "New meeting",
                  ),
                  color: const Color.fromARGB(255, 55, 116, 87),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const StartMeetingScreen()))),
              const SizedBox(
                width: 20.0,
              ),
              MaterialButton(
                  height: 55.0,
                  child: const Text(
                    "Join Meeting",
                  ),
                  color: const Color.fromARGB(255, 55, 116, 87),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const JoinMeetingScreen()))),
              const SizedBox(
                height: 20.0,
              )
            ],
          ),
        ],
      ),
    );
  }
}
