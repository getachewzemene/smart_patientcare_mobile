import "package:flutter/material.dart";
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_health_assistant/api/check_disease_api.dart';
import 'package:smart_health_assistant/constants/symptom.dart';
import 'package:smart_health_assistant/screens/disease_detail.dart';
import 'package:smart_health_assistant/widgets/custom_snackbar.dart';
import '../models/disease.dart';
import '/constants/widget_params.dart';

class CheckHealth extends StatefulWidget {
  const CheckHealth({Key? key}) : super(key: key);

  @override
  State<CheckHealth> createState() => _CheckHealthState();
}

class _CheckHealthState extends State<CheckHealth> {
  final _multiSelectKey = GlobalKey<FormFieldState>();

  List<String?> _selectedSymptom = [];

  bool isLoading = false;

  void checkHealth() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 1), () {});
    setState(() {
      isLoading = false;
    });
    Disease? disease = await checkDisease(_selectedSymptom);
    if (disease != null) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => DiseaseDetail(disease: disease)));
    } else {
      customSnackBar(true, context, "Error occured try again");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Check Health"),
        backgroundColor: contentColor,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("Check Health"),
            Column(
              children: [
                MultiSelectBottomSheetField<String?>(
                  key: _multiSelectKey,
                  initialChildSize: 0.7,
                  maxChildSize: 0.95,
                  title: const Text("Symptoms"),
                  buttonText: const Text("select symptoms"),
                  items: symptomList.entries.map((
                    symptom,
                  ) {
                    return MultiSelectItem(symptom.value, symptom.key);
                  }).toList(),
                  searchable: true,
                  validator: (values) {
                    if (values == null || values.isEmpty) {
                      return "Required";
                    }
                  },
                  onConfirm: (values) {
                    setState(() {
                      _selectedSymptom = values;
                    });
                    _multiSelectKey.currentState!.validate();
                  },
                  chipDisplay: MultiSelectChipDisplay(
                    onTap: (item) {
                      setState(() {
                        _selectedSymptom.remove(item);
                      });
                      _multiSelectKey.currentState!.validate();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Center(
                    child: MaterialButton(
                      child: isLoading
                          ? SizedBox(
                              height: 5.0.h,
                              width: 5.0.w,
                              child: const CircularProgressIndicator(
                                strokeWidth: 3.0,
                                backgroundColor: Colors.cyan,
                                color: Colors.red,
                              ))
                          : const Text("Check Health"),
                      color: const Color.fromARGB(255, 55, 116, 87),
                      textColor: Colors.white,
                      height: 8.0.h,
                      minWidth: 32.0.w,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      onPressed: checkHealth,
                    ),
                  ),
                ),
                const SizedBox(height: defaultPadding),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
