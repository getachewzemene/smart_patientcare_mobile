import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '/constants/widget_params.dart';
import 'signin_screen.dart';
import 'signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: contentColor,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0)),
                child: Container(
                  height: (MediaQuery.of(context).size.height) - 250,
                  color: Colors.white,
                  child: Stack(
                    fit: StackFit.loose,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 60.0),
                        child: Container(
                            // width: 400,
                            padding:
                                const EdgeInsets.only(top: 30.0, bottom: 20.0),
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage(
                                "assets/images/dr1.jpg",
                              ),
                              fit: BoxFit.fill,
                            ))),
                      ),
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
                              "How can we help you ?",
                              style: boldTextStyle,
                            )
                          ],
                        )),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    height: 40.0,
                    child: MaterialButton(
                      child: const Text("Login"),
                      color: Color.fromARGB(255, 61, 114, 88),
                      textColor: Colors.white,
                      height: 8.0.h,
                      minWidth: 32.0.w,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignInScreen(),
                          )),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    height: 40.0,
                    child: MaterialButton(
                      child: const Text("Register"),
                      color: Color.fromARGB(255, 61, 114, 88),
                      textColor: Colors.white,
                      height: 8.0.h,
                      minWidth: 32.0.w,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
