import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

const bootomText = TextStyle(fontSize: 10.0, fontWeight: FontWeight.normal);
const errorTextStyle = TextStyle(color: Colors.red);
const successtextStyle = TextStyle(color: Colors.black);
const primaryColor = Color(0xFF255ED6);
const textColor = Color(0xFF35364F);
const backgroundColor = Color(0xFFE6EFF9);
const redColor = Color(0xFFE85050);
const boldTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0);
const defaultPadding = 16.0;
const emailError = 'Enter a valid email address';
const requiredField = "This field is required";
final nameValidator = MultiValidator([
  RequiredValidator(errorText: "name is required"),
  MinLengthValidator(4, errorText: 'name must be at least 4 chars long'),
  PatternValidator(r'^[a-z A-Z,.\-]+$', errorText: "Invalid name")
]);
final phoneValidator = MultiValidator([
  RequiredValidator(errorText: "phone is required"),
  MinLengthValidator(10, errorText: 'phone must be 10 chars long'),
  PatternValidator(r'(^(?:[+0]9)?[0-9]{10,12}$)', errorText: "Invalid phone")
]);
final weightValidator = MultiValidator([
  RequiredValidator(errorText: "weight is required"),
  PatternValidator(r'^[0-9]+([,.][0-9]?)?$', errorText: "Invalid weight")
]);
final passwordValidator = MultiValidator(
  [
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(4, errorText: 'password must be at least 4 digits long'),
    // PatternValidator(r'(?=.*?[#?!@$%^&*-])',
    //     errorText: 'passwords must have at least one special character')
  ],
);
