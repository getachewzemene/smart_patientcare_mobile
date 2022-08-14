import 'package:flutter/material.dart';
import 'package:smart_health_assistant/constants/widget_params.dart';
import 'package:smart_health_assistant/screens/doctor_detail.dart';

class CategoryCard extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final iconImagePath;
  final String categoryName;
  const CategoryCard({
    Key? key,
    this.iconImagePath,
    required this.categoryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        margin: const EdgeInsets.all(10.0),
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shadowColor: Colors.grey,
        color: contentColor,
        // margin: const EdgeInsets.all(10.0),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: FittedBox(
          child: SizedBox(
            height: 250.0,
            width: 250,
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(32)),
                  child: Container(
                      height: 200.0,
                      // width: 400,
                      padding: const EdgeInsets.only(bottom: 20.0),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage(iconImagePath),
                        fit: BoxFit.fill,
                      ))),
                ),
                const SizedBox(height: 8),
                Text(categoryName,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 20)),
                const SizedBox(height: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
