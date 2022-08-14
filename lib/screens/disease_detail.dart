import 'package:flutter/material.dart';
import 'package:smart_health_assistant/constants/widget_params.dart';

import '../models/disease.dart';

class DiseaseDetail extends StatelessWidget {
  const DiseaseDetail({Key? key, required this.disease}) : super(key: key);
  final Disease disease;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(disease.diseaseName + " Detail"),
        backgroundColor: contentColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Center(
                    child: Text("Disease Name",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.solid,
                            fontSize: 22.0,
                            fontWeight: FontWeight.w700))),
                const SizedBox(height: defaultPadding),
                Text(
                  disease.diseaseName,
                  style: const TextStyle(
                      fontSize: 22.0, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 30.0),
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(32)),
                    child: Container(
                      color: const Color.fromARGB(255, 243, 238, 238),
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Disease Category",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationStyle: TextDecorationStyle.solid,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(height: defaultPadding),
                          Text(
                            disease.category,
                            style: const TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: defaultPadding),
                          const Text("Symptoms",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationStyle: TextDecorationStyle.solid,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(height: defaultPadding),
                          Column(
                              mainAxisSize: MainAxisSize.min,
                              children: disease.symptom.map((symptom) {
                                String parsedSymptomName = symptom.symptomName
                                    .replaceAll(RegExp('_'), ' ');
                                return Text(
                                  parsedSymptomName,
                                  style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w300),
                                );
                              }).toList()),
                          const SizedBox(height: defaultPadding),
                          const Text("Treatments",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationStyle: TextDecorationStyle.solid,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(height: defaultPadding),
                          Text(
                            disease.precuation,
                            style: const TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
