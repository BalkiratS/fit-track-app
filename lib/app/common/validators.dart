import 'package:get/get.dart';

String? validator(String? value) {
  if (value == null || value.isEmpty) {
    return "Please fill out this field.";
  }

  return null;
}

String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "Please fill out this field.";
  }

  if (!GetUtils.isEmail(value)) {
    return "Please enter a valid email address";
  }

  return null;
}
