import "package:flutter/material.dart";
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_health_assistant/providers/auth_notifier.dart';
import 'package:smart_health_assistant/screens/home_screen.dart';
import "../constants/widget_params.dart";
import 'custom_snackbar.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passController = TextEditingController();

  //UserManagement _userManagement = new UserManagement();
  final TextStyle _txtStyle = TextStyle(fontSize: 13.0.sp, color: Colors.black);

  final TextStyle _errorStyle =
      TextStyle(fontFamily: 'Montserrat', fontSize: 13.0.sp, color: Colors.red);

  //input values
  String _email = '';

  // ignore: unused_field
  String _loginEmail = '';

  // ignore: unused_field
  String _password = '';

  bool _obsecureText = true;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _obsecureText = !_obsecureText;
    });
  }

  Widget _buildEmail() {
    return TextFormField(
      key: const ValueKey("email"),
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      obscureText: false,
      style: _txtStyle,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        prefixIcon: const Icon(Icons.email),
        labelText: 'email',
        hintText: "someone@gmail.com",
        labelStyle: _txtStyle,
        errorStyle: _errorStyle,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.black)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple)),
      ),
      validator: EmailValidator(errorText: emailError),
      onSaved: (email) => _email = email!,
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      key: const ValueKey("password"),
      keyboardType: TextInputType.visiblePassword,
      controller: _passController,
      style: _txtStyle,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        prefixIcon: const Icon(Icons.lock),
        labelText: "password",
        hintText: '**************',
        labelStyle: _txtStyle,
        errorStyle: _errorStyle,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.black)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black)),
        suffixIcon: IconButton(
          icon: Icon(
            _obsecureText ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: _toggle,
        ),
      ),
      validator: passwordValidator,
      onSaved: (password) => _password = password!,
      textInputAction: TextInputAction.done,
      obscureText: _obsecureText,
    );
  }

  void signIn() async {
    var authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 1), () {});
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = false;
      });
      Map<String, dynamic> loginCredintial = {
        "email": _emailController.text.trim(),
        "password": _passController.text.trim()
      };
      await authNotifier.notifySignIn(loginCredintial);
      if (authNotifier.isLogin == true) {
        customSnackBar(false, context, "sign in success");
        _emailController.clear();
        _passController.clear();
        await Future.delayed(const Duration(seconds: 1), () {});
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      } else {
        customSnackBar(true, context, authNotifier.errorMessage);
        _emailController.clear();
        _passController.clear();
      }
    } else {
      setState(() {
        isLoading = false;
      });
      customSnackBar(true, context, "invalid form submition try again");
      _emailController.clear();
      _passController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEmail(),
          const SizedBox(height: defaultPadding),
          _buildPassword(),
          const SizedBox(height: defaultPadding),
          Center(
            child: MaterialButton(
              child: isLoading
                  ? SizedBox(
                      height: 5.0.h,
                      width: 5.0.w,
                      child: const CircularProgressIndicator(
                        backgroundColor: Colors.cyan,
                        color: Colors.red,
                      ))
                  : const Text("Sign In"),
              color: const Color.fromARGB(255, 55, 116, 87),
              textColor: Colors.white,
              height: 8.0.h,
              minWidth: 32.0.w,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              onPressed: signIn,
            ),
          ),
        ],
      ),
    );
  }
}
