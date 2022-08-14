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
      body: SafeArea(
        child: Expanded(child: initWidget()),
      ),
    );
  }

  Widget initWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          children: [
            buildDoctorImage(),
            buildAppBar(),
          ],
        ),
        buildDoctorDescription()
      ],
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
      height: 250.0,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Image.network(
        getBaseUrl + widget.imageURL,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget buildDoctorDescription() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      child: Container(
        height: MediaQuery.of(context).size.height - 300,
        color: contentColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    widget.name,
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Text(
                widget.specialization,
                style: const TextStyle(fontSize: 16.5, color: Colors.black),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, top: 15),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Address: ${widget.address}, Ethiopia",
                      style:
                          const TextStyle(fontSize: 16.5, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Phone: ${widget.phone}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, top: 30),
              child: const Text(
                "Description",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
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
                textAlign: TextAlign.justify,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Reviews",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: const Text(
                                    "4.9",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 0.5),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Patients",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            // ignore: avoid_unnecessary_containers
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: const Text(
                                      "22k",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 0.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: (() => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AppointmentScreen(
                            doctorId: widget.id,
                          )))),
              child: Container(
                margin: const EdgeInsets.only(top: 20, left: 70, right: 20),
                height: 45,
                width: MediaQuery.of(context).size.width - 150,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 26, 112, 96),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Book appointment",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
