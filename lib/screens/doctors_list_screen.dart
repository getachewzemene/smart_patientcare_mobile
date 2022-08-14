import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_health_assistant/constants/api_url.dart';
import 'package:smart_health_assistant/constants/widget_params.dart';
import 'package:smart_health_assistant/providers/api_notifier.dart';

import 'doctor_detail.dart';

class DoctorsListScreen extends StatefulWidget {
  const DoctorsListScreen({Key? key}) : super(key: key);

  @override
  State<DoctorsListScreen> createState() => _DoctorsListScreenState();
}

class _DoctorsListScreenState extends State<DoctorsListScreen> {
  @override
  void initState() {
    super.initState();
    final doctorList = Provider.of<ApiNotifier>(context, listen: false);
    doctorList.getDoctorsList();
  }

  final searcController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final doctorListNtifier = Provider.of<ApiNotifier>(context);
    final doctorModel = doctorListNtifier.doctorList;
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.only(top: 20),
        child: doctorListNtifier.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                controller: ScrollController(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Wrap(
                      direction: Axis.horizontal,
                      runAlignment: WrapAlignment.spaceBetween,
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Icon(
                              Icons.arrow_back,
                              size: 30.0,
                              color: Color.fromARGB(255, 15, 15, 15),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 250.0,
                          height: 38.0,
                          child: TextField(
                            controller: searcController,
                            decoration: const InputDecoration(
                                hintText: "search doctors",
                                labelText: "Search",
                                suffixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)))),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Select a doctor and make an appointment",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 17.0),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ListView.builder(
                        controller: ScrollController(),
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: doctorModel.length,
                        itemBuilder: (context, index) {
                          var doctorData = doctorModel[index];
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DoctorDetail(
                                              id: doctorData!.id,
                                              name: "Dr. " +
                                                  doctorData.firstName +
                                                  " " +
                                                  doctorData.lastName,
                                              imageURL:
                                                  doctorData.doctor.imagePath,
                                              email: doctorData.email,
                                              gender: doctorData.gender,
                                              phone: doctorData.phone,
                                              address: doctorData.address,
                                              specialization: doctorData
                                                  .doctor.specialization)));
                                },
                                child: Card(
                                  margin: const EdgeInsets.all(10.0),
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shadowColor: Colors.grey,
                                  color: contentColor,
                                  // margin: const EdgeInsets.all(10.0),
                                  elevation: 8,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          bottom: Radius.circular(20.0))),
                                  child: FittedBox(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          30,
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            height: 200,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                30,
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                      bottom:
                                                          Radius.circular(32)),
                                              child: Image.network(
                                                getBaseUrl +
                                                    doctorModel[index]!
                                                        .doctor
                                                        .imagePath,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Text(
                                                    "Dr." +
                                                        doctorModel[index]!
                                                            .firstName +
                                                        " " +
                                                        doctorModel[index]!
                                                            .lastName,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16,
                                                        color: Colors.white)),
                                                const SizedBox(height: 4),
                                                Text(
                                                    "Gender:" +
                                                        doctorModel[index]!
                                                            .gender,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16,
                                                        color: Colors.white)),
                                                const SizedBox(height: 4),
                                                Text(
                                                    "Specialization: " +
                                                        doctorModel[index]!
                                                            .doctor
                                                            .specialization,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16,
                                                        color: Colors.white)),
                                                const SizedBox(
                                                  height: 10.0,
                                                )
                                              ],
                                            ),
                                          ),
                                          const Text(
                                            'view detail',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 222, 235, 234),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20.0,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        }),
                  ],
                ),
              ),
      )),
    );
  }
}
