import "package:flutter/material.dart";
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_health_assistant/screens/signin_screen.dart';
import 'package:smart_health_assistant/utils/user_utils.dart';
import "../constants/widget_params.dart";
import '../providers/auth_notifier.dart';
import 'custom_snackbar.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _dateInputController = TextEditingController();
  final TextStyle _txtStyle = TextStyle(fontSize: 15.0.sp, color: Colors.black);
  final TextStyle _errorStyle =
      TextStyle(fontFamily: 'Montserrat', fontSize: 10.0.sp, color: Colors.red);
  bool _obsecureText = true;
  bool isLoading = false;
  String _defaultGender = 'male';
  //radio group id
  int _groupId = 1;
  Map<String, String> bloodGroup = {
    'Blood Group A': "A",
    'Blood Group B': "B",
    'Blood Group AB': "AB",
    'Blood Group O': "O",
  };
  String _selectedBloodGroup = "A";
  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _weightController.dispose();
    _dateInputController.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _obsecureText = !_obsecureText;
    });
  }

  Widget _buildForm(
      TextEditingController controller,
      TextInputType textInputType,
      Icon icon,
      String lable,
      String hintText,
      MultiValidator validator) {
    return TextFormField(
        controller: controller,
        keyboardType: textInputType,
        textAlign: TextAlign.justify,
        maxLines: null,
        decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsetsDirectional.only(start: 12.0, top: 10.0),
              child: icon, // myIcon is a 48px-wide widget.
            ),
            labelText: lable,
            hintText: hintText,
            labelStyle: const TextStyle(color: Colors.black),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 10.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
        validator: validator,
        onSaved: (savedVal) {
          setState(() {
            controller.text = savedVal as String;
          });
        });
  }

  Widget _buildEmail() {
    return TextFormField(
      key: const ValueKey("email"),
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      obscureText: false,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.email),
          labelText: 'email',
          hintText: "someone@gmail.com",
          labelStyle: const TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 10.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      validator: EmailValidator(errorText: emailError),
      onSaved: (savedVal) {
        setState(() {
          _emailController.text = savedVal as String;
        });
      },
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      key: const ValueKey("password"),
      keyboardType: TextInputType.visiblePassword,
      controller: _passController,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock),
        labelText: "password",
        hintText: '**************',
        labelStyle: const TextStyle(color: Colors.black),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        suffixIcon: IconButton(
          icon: Icon(
            _obsecureText ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: _toggle,
        ),
      ),
      validator: passwordValidator,
      onSaved: (savedVal) {
        setState(() {
          _emailController.text = savedVal as String;
        });
      },
      textInputAction: TextInputAction.done,
      obscureText: _obsecureText,
    );
  }

  Widget _buildGender() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            'Gender*',
            style: _txtStyle,
          ),
        ),
        Wrap(
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: <Widget>[
            Radio(
              value: 1,
              groupValue: _groupId,
              onChanged: (val) {
                setState(() {
                  _defaultGender = "Male";
                  _groupId = 1;
                });
              },
            ),
            Text("Male", style: _txtStyle),
            Radio(
              value: 2,
              groupValue: _groupId,
              onChanged: (val) {
                setState(() {
                  _defaultGender = "Female";
                  _groupId = 2;
                });
              },
            ),
            Text("Female", style: _txtStyle),
          ],
        )
      ],
    );
  }

  Widget _buildBloodGroupDropDown() {
    return DropdownButtonFormField<String>(
      value: _selectedBloodGroup,
      isExpanded: true,
      decoration: InputDecoration(
        prefixIcon: const Padding(
          padding: EdgeInsetsDirectional.only(start: 12.0, top: 10.0),
          child: Icon(
            Icons.bloodtype,
            color: Color.fromARGB(255, 241, 57, 11),
          ),
        ),
        labelText: 'select blood group',
        filled: true,
        fillColor: Colors.white,
        labelStyle: TextStyle(color: Colors.black, fontSize: 15.sp),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            gapPadding: 5.0,
            borderSide: const BorderSide(
                color: Colors.black45, style: BorderStyle.none)),
      ),
      onChanged: (newValue) {
        setState(() {
          _selectedBloodGroup = newValue!;
        });
      },
      validator: (_value) {
        if (_value == null) {
          return "can't empty";
        } else {
          return null;
        }
      },
      items: bloodGroup.entries.map((
        bloodGroup,
      ) {
        return DropdownMenuItem(
          child: Text(bloodGroup.key),
          value: bloodGroup.value,
        );
      }).toList(),
      onSaved: (bloodGroup) {
        setState(() {
          _selectedBloodGroup = bloodGroup!;
        });
      },
      dropdownColor: Colors.grey.shade200,
      elevation: 8,
    );
  }

  Widget _buildDate() {
    return TextFormField(
      controller: _dateInputController,
      keyboardType: TextInputType.datetime,

      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.calendar_today), //icon of text field
        labelText: "Enter Date",
        labelStyle: const TextStyle(color: Colors.black),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0)), //label text of field
      ),
      readOnly: true, //set it true, so that user will not able to edit text
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(
                1900), //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2100));

        if (pickedDate != null) {
          print(
              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          print(
              formattedDate); //formatted date output using intl package =>  2021-03-16
          //you can implement different kind of Date Format here according to your requirement

          setState(() {
            _dateInputController.text =
                formattedDate; //set output date to TextField value.
          });
        } else {
          print("Date is not selected");
        }
      },
    );
  }

  void signUp() async {
    var authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 1), () {});
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = false;
      });
      Map<String, dynamic> userData = {
        "id": generateId(),
        "firstName": _firstNameController.text.trim(),
        "lastName": _lastNameController.text.trim(),
        "email": _emailController.text.trim(),
        "password": _passController.text.trim(),
        "phone": _phoneController.text.trim(),
        "gender": _defaultGender,
        "DOB": _dateInputController.text.trim(),
        "address": _addressController.text.trim(),
        "weight": _weightController.text.trim(),
        "bloodGroup": _selectedBloodGroup
      };
      await authNotifier.notifySignUp(userData);
      if (authNotifier.isRegister == true) {
        customSnackBar(false, context, "sign up success");
        _firstNameController.clear();
        _lastNameController.clear();
        _emailController.clear();
        _passController.clear();
        _phoneController.clear();
        _weightController.clear();
        _dateInputController.clear();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const SignInScreen()));
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
      _firstNameController.clear();
      _lastNameController.clear();
      _emailController.clear();
      _passController.clear();
      _phoneController.clear();
      _weightController.clear();
      _dateInputController.clear();
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
          _buildForm(
              _firstNameController,
              TextInputType.name,
              const Icon(Icons.person_add),
              "First Name",
              "enter first name",
              nameValidator),
          const SizedBox(height: defaultPadding),
          _buildForm(
              _lastNameController,
              TextInputType.name,
              const Icon(Icons.person_add),
              "Last Name",
              "enter last name",
              nameValidator),
          const SizedBox(height: defaultPadding),
          _buildEmail(),
          const SizedBox(height: defaultPadding),
          _buildPassword(),
          const SizedBox(height: defaultPadding),
          _buildForm(
              _phoneController,
              TextInputType.phone,
              const Icon(Icons.phone),
              "Phone",
              "+251-000-00-00-00",
              phoneValidator),
          const SizedBox(height: defaultPadding),
          _buildGender(),
          const SizedBox(height: defaultPadding),
          _buildDate(),
          const SizedBox(height: defaultPadding),
          _buildForm(
              _weightController,
              TextInputType.number,
              const Icon(Icons.numbers),
              "Weight",
              "e.g 70 kg",
              weightValidator),
          const SizedBox(height: defaultPadding),
          _buildBloodGroupDropDown(),
          const SizedBox(height: defaultPadding),
          _buildForm(
              _addressController,
              TextInputType.streetAddress,
              const Icon(Icons.place),
              "Adress",
              "e.g Bahir Dar",
              nameValidator),
          const SizedBox(height: defaultPadding),
          Center(
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
                  : const Text("Sign Up"),
              color: const Color.fromARGB(255, 55, 116, 87),
              textColor: Colors.white,
              height: 8.0.h,
              minWidth: 32.0.w,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              onPressed: signUp,
            ),
          ),
          const SizedBox(height: defaultPadding),
        ],
      ),
    );
  }
}
