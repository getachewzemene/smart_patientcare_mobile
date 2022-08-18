import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_health_assistant/providers/api_notifier.dart';
import 'package:smart_health_assistant/utils/user_utils.dart';

class PatientHistory extends StatefulWidget {
  const PatientHistory({Key? key}) : super(key: key);

  @override
  State<PatientHistory> createState() => _PatientHistoryState();
}

class _PatientHistoryState extends State<PatientHistory> {
  bool isExpanded = false;
  @override
  void initState() {
    getPatientHistory();
    super.initState();
  }

  void getPatientHistory() async {
    var currentUser = await getCurrentUser();
    var userInfo = jsonDecode(currentUser!);
    var id = userInfo["id"];
    await Future.delayed(const Duration(seconds: 1), () {});
    final history = Provider.of<ApiNotifier>(context, listen: false);
    history.getPatientHistory(id);
  }

  @override
  Widget build(BuildContext context) {
    // final patientHistory = Provider.of<ApiNotifier>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Consumer<ApiNotifier>(
        builder: (context, patientHistory, child) => SafeArea(
            child: patientHistory.isLoading == true
                ? const CircularProgressIndicator()
                : SingleChildScrollView(
                    controller: ScrollController(),
                    child: Stack(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 70.0, left: 10.0, right: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0)),
                                              ),
                                              label: Text("Search"),
                                              prefixIcon: Icon(Icons.search)),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        right: 0,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: TextButton(
                                              onPressed: () {
                                                // getPatientHistory();
                                              },
                                              child: const Text("Search")),
                                        ))
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: ListView.builder(
                                    itemCount: patientHistory
                                        .history!
                                        .userPatient!
                                        .patientPrescription
                                        .length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    controller: ScrollController(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ExpansionPanelList(
                                        animationDuration:
                                            Duration(milliseconds: 1000),
                                        dividerColor: Colors.red,
                                        elevation: 1,
                                        children: [
                                          ExpansionPanel(
                                              body: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    const ClipOval(
                                                      child: CircleAvatar(
                                                          child: Icon(
                                                              Icons.history)),
                                                    ),
                                                    const SizedBox(
                                                      height: 30,
                                                    ),
                                                    Text(
                                                      patientHistory
                                                          .history!
                                                          .userPatient!
                                                          .patientPrescription[
                                                              index]
                                                          .description,
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[700],
                                                          fontSize: 15,
                                                          letterSpacing: 0.3,
                                                          height: 1.3),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              headerBuilder:
                                                  (BuildContext context,
                                                      bool isExpanded) {
                                                return Container(
                                                  padding: EdgeInsets.all(10),
                                                  child: Text(
                                                    patientHistory
                                                        .history!
                                                        .userPatient!
                                                        .patientPrescription[
                                                            index]
                                                        .diseaseName,
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                );
                                              },
                                              isExpanded: patientHistory
                                                  .history!
                                                  .userPatient!
                                                  .patientPrescription[index]
                                                  .isExpanded)
                                        ],
                                        expansionCallback:
                                            (int item, bool status) {
                                          setState(() {
                                            patientHistory
                                                    .history!
                                                    .userPatient!
                                                    .patientPrescription[index]
                                                    .isExpanded =
                                                !patientHistory
                                                    .history!
                                                    .userPatient!
                                                    .patientPrescription[index]
                                                    .isExpanded;
                                          });
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            )),
                        buildAppBar(patientHistory.history!.firstName +
                            "   " +
                            patientHistory.history!.lastName)
                      ],
                    ),
                  )),
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
              margin: const EdgeInsets.only(right: 20),
              child: Text(name)),
          const SizedBox(
            height: 20.0,
          )
        ],
      ),
    );
  }
}
