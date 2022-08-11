import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '/constants/widget_params.dart';
import 'signin_screen.dart';
import 'signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
      height: MediaQuery.of(context).size.height,
      color: const Color.fromARGB(255, 182, 235, 235),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  "Welcome",
                  style: boldTextStyle,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "How can help you ?",
                  style: boldTextStyle,
                )
              ],
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(20.0), top: Radius.circular(20.0)),
              child: Container(
                  height: 300.0,
                  // width: 400,
                  padding: const EdgeInsets.only(bottom: 20.0),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage(
                      "assets/images/dr1.jpg",
                    ),
                    fit: BoxFit.fill,
                  ))),
            ),
          ),
          SizedBox(
            height: 2.0.h,
          ),
          Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                height: 40.0,
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpScreen(),
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 8, 67, 63),
                  ),
                  child: const Text("Register"),
                ),
              ),
              SizedBox(
                height: 2.0.h,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                height: 40.0,
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignInScreen(),
                      )),
                  style: TextButton.styleFrom(
                    elevation: 0,
                    backgroundColor: const Color.fromARGB(255, 8, 67, 63),
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color.fromARGB(255, 8, 67, 63),
                      ),
                    ),
                  ),
                  child: const Text("Login"),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ],
      ),
    )));
  }
}
