import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_health_assistant/screens/agora_screen.dart';
import 'package:smart_health_assistant/utils/user_utils.dart';
import 'package:uuid/uuid.dart';

class MeetingScreen extends StatefulWidget {
  const MeetingScreen({Key? key}) : super(key: key);

  @override
  State<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  bool isAdmin = false;
  bool isUser = false;
  final meetingController = TextEditingController();
  final nameController = TextEditingController();
  final key = GlobalKey<FormState>();

  @override
  void dispose() {
    meetingController.clear();
    meetingController.dispose();
    nameController.clear();
    nameController.dispose();
    super.dispose();
  }

  void callVideoPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AgoraScreen()));
  }
  // void join() async {
  //   if (key.currentState!.validate()) {
  //     key.currentState!.save();
  //     // var isMeeting = await isMeetingPresent(meetingController.text);
  //     var meeting = await joinMeeting(meetingController.text);
  //     var meetingId = meeting.id;
  //     print(meetingId);
  //     if (meetingId != "") {
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) => VideoCallScreen(
  //                   meetingId: meetingId,
  //                   name: nameController.text,
  //                   meeting: meeting)));
  //     } else {
  //       showDialog(
  //           context: context,
  //           builder: (BuildContext context) => AlertDialog(
  //                 title: const Text("Info"),
  //                 actionsAlignment: MainAxisAlignment.end,
  //                 elevation: 5.0,
  //                 content: const Text("Invalid Meeting ID"),
  //                 shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(20.0)),
  //                 titleTextStyle: const TextStyle(
  //                     color: Colors.red,
  //                     fontSize: 22.0,
  //                     fontWeight: FontWeight.w300),
  //                 actions: [
  //                   TextButton(
  //                       onPressed: () => Navigator.pop(context),
  //                       child: const Text("Cancel"))
  //                 ],
  //               ));
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Meeting Screen"),
            centerTitle: true,
            automaticallyImplyLeading: true,
          ),
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
                            controller: meetingController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.link,
                                  color: Colors.blue,
                                ),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.copy),
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(
                                            text: meetingController.text))
                                        .then((_) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: const Text(
                                            "meeting ID copied to clipboard"),
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                        ),
                                        margin: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                    .size
                                                    .height -
                                                100,
                                            right: 20,
                                            left: 20),
                                      ));
                                    });
                                  },
                                ),
                                label: const Text("meeting ID"),
                                hintText: "Enter meeting Id",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            onChanged: (value) {
                              meetingController.text = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter valid meeting Id';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                            controller: nameController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.blue,
                                ),
                                label: const Text("display name"),
                                hintText: "Enter user name",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter valid user name';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MaterialButton(
                              child: const Text("Start New Meeting"),
                              color: Colors.blueGrey,
                              textColor: Colors.white,
                              height: 40.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              onPressed: startMeeting,
                            ),
                            MaterialButton(
                                child: const Text("Join Meeting"),
                                color: Colors.blueGrey,
                                textColor: Colors.white,
                                height: 40.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                onPressed: callVideoPage)
                          ],
                        ),
                      ])),
            ),
          )),
    );
  }

  void startMeeting() {
    var uuid = Uuid().v4().substring(0, 12);
    nameController.text = uuid;
  }
}
