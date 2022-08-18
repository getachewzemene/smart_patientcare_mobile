import 'package:flutter/material.dart';
import 'package:smart_health_assistant/constants/api_url.dart';
import 'package:smart_health_assistant/constants/widget_params.dart';
import 'package:smart_health_assistant/screens/appointment_screen.dart';

class DoctorDetail extends StatefulWidget {
  const DoctorDetail(
      {Key? key,
      required this.id,
      required this.name,
      required this.imageURL,
      required this.email,
      required this.gender,
      required this.phone,
      required this.address,
      required this.specialization})
      : super(key: key);
  final String name;
  final String specialization;
  final String imageURL;
  final String gender;
  final String email;
  final String id;
  final String phone;
  final String address;
  @override
  _DoctorDetailState createState() => _DoctorDetailState();
}

class _DoctorDetailState extends State<DoctorDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: contentColor, body: SafeArea(child: initWidget()));
  }

  Widget initWidget() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(50)),
            child: SizedBox(
              child: Stack(
                children: [
                  buildDoctorImage(),
                  buildAppBar(),
                ],
              ),
            ),
          ),
          buildDoctorDescription()
        ],
      ),
    );
  }

  Widget buildAppBar() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.transparent,
                  border: Border.all(
                      color: Color.fromARGB(255, 55, 126, 122), width: 0.3)),
              child: const Icon(
                Icons.arrow_back,
                color: Color.fromARGB(255, 15, 15, 15),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.transparent,
                border: Border.all(
                    color: Color.fromARGB(255, 226, 16, 16), width: 0.3)),
            margin: const EdgeInsets.only(right: 20),
            child: const Icon(
              Icons.favorite,
              color: Color.fromARGB(255, 213, 8, 8),
            ),
          )
        ],
      ),
    );
  }

  Widget buildDoctorImage() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Image.network(
        getBaseUrl + widget.imageURL,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget buildDoctorDescription() {
    return Container(
      padding: const EdgeInsets.only(left: 10.0, top: 10),
      // height: MediaQuery.of(context).size.height,
      color: contentColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.name,
            style: const TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
          ),
          const Text(
            "Specialization",
            style: TextStyle(fontSize: 16.5, color: Colors.white),
          ),
          Text(
            widget.specialization,
            style: const TextStyle(fontSize: 16.5, color: Colors.white),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Phone: ${widget.phone}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.yellowAccent,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          const Text(
            "Description",
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "${widget.name} is one of the best doctor in Ethiopai and has 10 years of experience. ${widget.gender == "male" ? "He" : "She"} has done a lot in the health industry",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  const Text(
                    "Reviews",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  Wrap(
                    children: const [
                      Text(
                        "4.9",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      SizedBox(
                        width: 6.0,
                      ),
                      Icon(
                        Icons.star_border,
                        size: 20.0,
                        color: Colors.yellow,
                      )
                    ],
                  ),
                ],
              ),
              Column(
                children: const [
                  Text("Patients",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      )),
                  Text(
                    "22k",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(40.0, 0, 40.0, 0),
            height: 40.0,
            child: MaterialButton(
              child: const Text(
                "Book appointment",
              ),
              color: const Color.fromARGB(255, 55, 116, 87),
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              onPressed: (() => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AppointmentScreen(
                            doctorId: widget.id,
                          )))),
            ),
          ),
          const SizedBox(
            height: 20.0,
          )
        ],
      ),
    );
    //         InkWell(
    //           onTap: (() => Navigator.pushReplacement(
    //               context,
    //               MaterialPageRoute(
    //                   builder: (context) => AppointmentScreen(
    //                         doctorId: widget.id,
    //                       )))),
    //           child: Column(
    //             children: [
    //               Flexible(
    //                 child: Container(
    //                   alignment: Alignment.center,
    //                   decoration: BoxDecoration(
    //                     color: Color.fromARGB(255, 26, 112, 96),
    //                     borderRadius: BorderRadius.circular(10),
    //                   ),
    //                   child: const Text(
    //                     "Book appointment",
    //                     style: TextStyle(
    //                         fontSize: 16,
    //                         fontWeight: FontWeight.w600,
    //                         color: Colors.white),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
