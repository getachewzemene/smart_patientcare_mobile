import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/specialist_provider.dart';

import '../widgets/bottom_navigation.dart';
import '../widgets/nav_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) => SpecialistProvider()),
      child: Scaffold(
          appBar: AppBar(title: const Text("Home")),
          drawer: const NavDrawer(),
          body: SafeArea(
            child: SingleChildScrollView(
                controller: ScrollController(),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const Text("How do you feel today ?"),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text("Categories"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text("Brain"),
                      Text("Lung"),
                      Text('Stomach')
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text("Top Specialists"),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Consumer<SpecialistProvider>(
                    builder: (context, specialistProvider, _) =>
                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            controller: ScrollController(),
                            shrinkWrap: true,
                            itemCount: specialistProvider.getSpecialist.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {},
                                child: Card(
                                  margin: const EdgeInsets.all(10.0),
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shadowColor: Colors.grey,
                                  color: Colors.amberAccent,
                                  // margin: const EdgeInsets.all(10.0),
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32)),
                                  child: FittedBox(
                                    child: SizedBox(
                                      height: 300.0,
                                      width: 300,
                                      child: Column(
                                        children: <Widget>[
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.vertical(
                                                    bottom:
                                                        Radius.circular(32)),
                                            child: Container(
                                                height: 200.0,
                                                // width: 400,
                                                padding: const EdgeInsets.only(
                                                    bottom: 20.0),
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                  image: AssetImage(
                                                    specialistProvider
                                                        .getSpecialist[index]
                                                        .imageURL,
                                                  ),
                                                  fit: BoxFit.fill,
                                                ))),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                              specialistProvider
                                                      .getSpecialist[index]
                                                      .firstName +
                                                  " " +
                                                  specialistProvider
                                                      .getSpecialist[index]
                                                      .lastName,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 20)),
                                          const SizedBox(height: 2),
                                          Center(
                                              child: MaterialButton(
                                            onPressed: (() {}),
                                            child: const Text("View Detail"),
                                          ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                  )
                ])),
          ),
          bottomNavigationBar: const BottomNavBar()),
    );
  }
}
