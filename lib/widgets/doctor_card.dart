import 'package:flutter/material.dart';

import '../constants/widget_params.dart';

class DoctorCard extends StatelessWidget {
  final String doctorImagePath;
  final String rating;
  final String docturName;
  final String doctorProfession;

  // ignore: use_key_in_widget_constructors
  const DoctorCard(
      {required this.doctorImagePath,
      required this.rating,
      required this.docturName,
      required this.doctorProfession});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: contentColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            //picture of doctors
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                doctorImagePath,
                height: 70,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            //rating out of 5
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                Text(
                  rating,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            //doctors name
            Text(
              docturName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            //doctors title
            Text(doctorProfession + '7 y.e,'),
          ],
        ),
      ),
    );
  }
}
