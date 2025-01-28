import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var firstName = ''.obs;
  var lastName = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var firstNameError = RxnString();
  var lastNameError = RxnString();
  var emailError = RxnString();
  var passwordError = RxnString();


  @override
  void onInit() {}

  void validateFirstName(String value) {
    firstName.value = value;
    if (value.isEmpty) {
      firstNameError.value = 'First name is required';
    } else if (value.length < 2) {
      firstNameError.value = 'First name must be at least 2 characters';
    } else {
      firstNameError.value = null;
    }
  }

  void validateEmail(String value) {
    email.value = value;
    if (value.isEmpty) {
      emailError.value = 'Email is required';
    } else if (!GetUtils.isEmail(value)) {
      emailError.value = 'Please enter a valid email';
    } else {
      emailError.value = null;
    }
  }

  void validateLastName(String value) {
    lastName.value = value;
    if (value.isEmpty) {
      lastNameError.value = 'Last name is required';
    } else if (value.length < 2) {
      lastNameError.value = 'Last name must be at least 2 characters';
    } else {
      lastNameError.value = null;
    }
  }

  void validatePassword(String value) {
    password.value = value;
    if (value.isEmpty) {
      passwordError.value = 'Password is required';
    } else if (value.length < 6) {
      passwordError.value = 'Password must be at least 6 characters';
    } else {
      passwordError.value = null;
    }
  }

  bool isFormValid() {
    validateFirstName(firstName.value);
    validateLastName(lastName.value);
    validateEmail(email.value);
    validatePassword(password.value);

    return firstNameError.value == null &&
        lastNameError.value == null &&
        emailError.value == null &&
        passwordError.value == null;
  }


}
