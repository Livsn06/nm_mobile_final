import 'package:arcore_flutter_plugin_example/api/api_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/cust_loadingAlert.dart';
import '../../components/cust_validationAlert.dart';
import '../../models/data_model/md_user.dart';
import '../../routes/screen_routes.dart';
import '../../utils/_initApp.dart';
import '../../utils/responsive.dart';

class RegisterController extends GetxController {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isRememberMeChecked = false;

  bool get isPasswordVisible => _isPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;
  bool get isRememberMeChecked => _isRememberMeChecked;

  // Toggle functions
  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    update();
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    update();
  }

  void toggleRememberMe() {
    _isRememberMeChecked = !_isRememberMeChecked;
    update();
  }

  // Email Validator
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  // Password Validator
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  // Confirm Password Validator
  String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Register User
  void toSignUpConfirm(
    UserModel user,
    BuildContext context,
    String msgType,
  ) async {
    try {
      if (isRememberMeChecked == true) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => LoadingAlert(
            title: "Registering...",
            subtitle: "Please wait while we verify your credentials...",
          ),
        );

        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: user.email!,
          password: user.password!,
        );

        if (userCredential.user != null) {
          var response = await AuthenticationApi.auth.register(user);

          if (response == 'Email already exists') {
            Navigator.pop(context);
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => ValidationAlert(
                title: "Error",
                text: "Email already exists",
                authType: msgType,
                isValid: false,
                onpress: () {
                  Navigator.pop(context);
                },
              ),
            );
          }

          if (response == 'Registration successful') {
            Navigator.pop(context);
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => ValidationAlert(
                title: "Success",
                text: "Registered successfully",
                authType: msgType,
                isValid: true,
                onpress: () {
                  Navigator.pop(context);
                  Get.toNamed(ScreenRouter.getLoginRoute);
                },
              ),
            );
          }
        } else {
          Navigator.pop(context);
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => ValidationAlert(
              title: "Error",
              text: "Error registering account",
              authType: msgType,
              isValid: false,
              onpress: () {
                Navigator.pop(context);
              },
            ),
          );
        }
        Navigator.pop(context);

        // Show success alert
        showValidationAlert(
            context, 'Successful', 'Successfully $msgType', msgType, true, () {
          Get.toNamed(ScreenRouter.getLoginRoute);
        });
      } else {
        Get.snackbar(
          padding: EdgeInsets.symmetric(
              vertical: setResponsiveSize(context, baseSize: 20),
              horizontal: setResponsiveSize(context, baseSize: 30)),
          icon: Icon(Icons.warning_rounded,
              color: Colors.white,
              size: setResponsiveSize(context, baseSize: 40)),
          backgroundColor: Application().color.valid,
          'Terms and Conditions',
          colorText: Colors.white,
          'Please check the terms and conditions',
          snackPosition: SnackPosition.TOP,
        );
      }
    } on FirebaseAuthException catch (ex) {
      String msgtext;
      if (ex.code == 'invalid-credential') {
        msgtext = 'Invalid Credential';
      } else if (ex.code == 'email-already-in-use') {
        msgtext = 'Email already registered.';
      } else if (ex.code == 'weak-password') {
        msgtext = 'Password must be at least 6 characters.';
      } else if (ex.code == 'user-disabled') {
        msgtext = 'Account Temporarily Disabled';
      } else {
        msgtext = 'An error occurred: ${ex.message}';
      }

      // Show error alert
      showValidationAlert(context, 'Opps...', msgtext, msgType, false, () {
        Navigator.pop(context);
      });
    }
  }
}
