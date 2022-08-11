import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_health_assistant/constants/api_url.dart';
import 'package:smart_health_assistant/providers/api_notifier.dart';

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

  @override
  Widget build(BuildContext context) {
    final doctorListNtifier = Provider.of<ApiNotifier>(context);
    final doctorModel = doctorListNtifier.doctorList;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doctors List"),
      ),
      body: Container(
          padding: const EdgeInsets.all(20),
          child: doctorListNtifier.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  controller: ScrollController(),
                  itemCount: doctorModel.length,
                  itemBuilder: (context, index) => Column(
                        children: [
                          Text(doctorModel[index]!.firstName),
                          Image.network(
                              getBaseUrl + doctorModel[index]!.doctor.imagePath)
                        ],
                      ))),
    );
  }
}
