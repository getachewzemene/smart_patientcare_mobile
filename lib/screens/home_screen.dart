import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:smart_health_assistant/constants/api_url.dart';

import 'package:smart_health_assistant/constants/widget_params.dart';
import 'package:smart_health_assistant/providers/api_notifier.dart';
import 'package:smart_health_assistant/screens/check_health_screen.dart';
import 'package:smart_health_assistant/screens/doctors_list_screen.dart';
import 'package:smart_health_assistant/screens/welcome_screen.dart';
import 'package:smart_health_assistant/widgets/sidebar_menu.dart';
import '../models/doctor.dart';
import '../providers/auth_notifier.dart';
import '../providers/specialist_provider.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/category_card.dart';
import 'doctor_detail.dart';
// import '../widgets/nav_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isOpened = false;

  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();

  final GlobalKey<SideMenuState> _endSideMenuKey = GlobalKey<SideMenuState>();

  @override
  void initState() {
    var apiNotifier = Provider.of<ApiNotifier>(context, listen: false);
    apiNotifier.getDoctorsList();
    super.initState();
  }

  toggleMenu([bool end = false]) {
    if (end) {
      final _state = _endSideMenuKey.currentState!;
      if (_state.isOpened) {
        _state.closeSideMenu();
      } else {
        _state.openSideMenu();
      }
    } else {
      final _state = _sideMenuKey.currentState!;
      if (_state.isOpened) {
        _state.closeSideMenu();
      } else {
        _state.openSideMenu();
      }
    }
  }

  void logout(context) async {
    var loginNotifier = Provider.of<AuthNotifier>(context, listen: false);
    await loginNotifier.logout();
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return SideMenu(
      key: _sideMenuKey,
      background: contentColor,
      menu: const SidebarMenu(),
      type: SideMenuType.slideNRotate,
      onChange: (_isOpened) {
        setState(() => isOpened = _isOpened);
      },
      child: IgnorePointer(
        ignoring: isOpened,
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: contentColor,
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => toggleMenu(),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout_outlined),
                  onPressed: () {
                    logout(context);
                  },
                )
              ],
              title: const Text("Home"),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(5.0),
                scrollDirection: Axis.vertical,
                physics: const ScrollPhysics(),
                controller: ScrollController(),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  // card how do u feel?
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15.0),
                    // ignore: avoid_unnecessary_containers
                    child: Container(
                      height: 120.0,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.pink[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      // ignore: prefer_const_literals_to_create_immutables
                      child: Column(
                        children: [
                          const Center(
                            child: Text(
                              'How do you feel today?',
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: Center(
                                child: MaterialButton(
                                  child: const Text("Check Health"),
                                  color: const Color.fromARGB(255, 55, 116, 87),
                                  textColor: Colors.white,
                                  height: 45.0,
                                  minWidth: 100.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CheckHealth())),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  //search
                  SizedBox(
                    height: 50.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                            hintText: 'How can we help you?',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 43, 104, 101),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 200.0,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        controller: ScrollController(),
                        children: const [
                          CategoryCard(
                            categoryName: 'Dentist',
                            iconImagePath: 'assets/images/tooth.jpg',
                          ),
                          CategoryCard(
                            categoryName: 'Pediatrics',
                            iconImagePath: 'assets/images/asof.jpg',
                          ),
                          CategoryCard(
                            categoryName: 'Neurology',
                            iconImagePath: 'assets/images/bran.png',
                          ),
                        ]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //doctor list
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text.rich(
                          TextSpan(
                            text: 'Doctors',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' Top',
                                style:
                                    TextStyle(fontSize: 25, color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const DoctorsListScreen())),
                          child: const Text(
                            'See all',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 43, 104, 101),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                      height: 260.0,
                      child: Consumer<ApiNotifier>(
                          builder: ((context, value, child) => ListView.builder(
                              itemCount: 3,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: const ScrollPhysics(),
                              controller: ScrollController(),
                              itemBuilder: ((context, index) {
                                var doctorData = value.doctorList;
                                if (doctorData.isEmpty) {
                                  return const CircularProgressIndicator(
                                    strokeWidth: 3.0,
                                    backgroundColor: Colors.red,
                                    color: Colors.lightBlue,
                                  );
                                }
                                return topDoctorsList(doctorData[index]!);
                              })))))
                ]),
              ),
            ),
            bottomNavigationBar: const BottomNavBar()),
      ),
    );
  }

  Widget topDoctorsList(Doctor doctorData) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DoctorDetail(
                    id: doctorData.id,
                    name: "Dr. " +
                        doctorData.firstName +
                        " " +
                        doctorData.lastName,
                    imageURL: doctorData.doctor.imagePath,
                    email: doctorData.email,
                    gender: doctorData.gender,
                    phone: doctorData.phone,
                    address: doctorData.address,
                    specialization: doctorData.doctor.specialization)));
      },
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
            height: 300.0,
            width: 250,
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(32)),
                  child: Image.network(
                    getBaseUrl + doctorData.doctor.imagePath,
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                    height: 200.0,
                  ),
                ),
                const SizedBox(height: 4),
                Text("Dr. " + doctorData.firstName + " " + doctorData.lastName,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16)),
                const SizedBox(height: 4),
                Wrap(children: const [
                  Text("4.2",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  )
                ]),
                const SizedBox(height: 4),
                Text(doctorData.doctor.specialization,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
