import "package:flutter/material.dart";
import 'package:sizer/sizer.dart';
import "../constants/widget_params.dart";
import '../widgets/signup_form.dart';
import 'signin_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  // It's time to validat the text field

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create Account",
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInScreen(),
                        )),
                    child: Text(
                      "Sign In!",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.0.sp),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: defaultPadding * 2),
              const SignUpForm(),
            ],
          ),
        ),
      ),
    );
  }
}
