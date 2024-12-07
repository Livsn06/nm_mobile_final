import 'package:arcore_flutter_plugin_example/api/api_auth.dart';
import 'package:arcore_flutter_plugin_example/constants/_savedUser.dart';
import 'package:arcore_flutter_plugin_example/models/data_model/md_user.dart';
import 'package:arcore_flutter_plugin_example/utils/_session.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/cust_loadingAlert.dart';
import '../../components/cust_validationAlert.dart';
import '../../routes/screen_routes.dart';
import '../../utils/_initApp.dart';
import '../Home_Control/bookmark_controller.dart';

class LoginController extends GetxController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  //hasError, errorCode, provider,uid, email, name, imageUrl
  String? _errorCode;
  String? _name;
  String? _email;
  String? _gender;
  String? _address;
  String? _birthdate;
  String? _phoneNumber;
  String? _imageEmail;
  String? _uid;
  String? _imageUrl;
  String? _provider;
  bool _hasError = false;
  bool _isSignedIn = false;

  // Getters for each variable
  String? get name => _name;
  String? get email => _email;
  String? get uid => _uid;
  String? get imageUrl => _imageUrl;
  String? get imageEmail => _imageEmail;
  String? get provider => _provider;
  String? get gender => _gender;
  String? get address => _address;
  String? get birthdate => _birthdate;
  String? get phoneNumber => _phoneNumber;
  bool get isSignedIn => _isSignedIn;
  String? get errorCode => _errorCode;
  bool get hasError => _hasError;

  SignInProvider() {
    checkSignInUser();
  }

  Future checkSignInUser() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("signed_in") ?? false;
    update();
  }

  Future setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("signed_in", true);
    _isSignedIn = true;
    update();
  }

  // sign in with google
  Future signInWithGoogle(BuildContext context, String msgType) async {
    try {
      showLoadingAlert(
        context,
        "Logging In",
        "Please wait while we verify your credentials...",
      );

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final User userDetails =
            (await firebaseAuth.signInWithCredential(credential)).user!;
        print('User Credentials: $userDetails');

        // saveDataToSharedPreferences();
        handleUserLogin(); // Call this after user login
        showValidationAlert(
            context, 'Successful', 'Successfully $msgType', msgType, true, () {
          Get.toNamed(ScreenRouter.getControlscreenRoute);
          Get.snackbar(
              'Successfully Login', 'Welcome back, ${CURRENT_USER.value.name}!',
              icon: Icon(Icons.check_circle_outline,
                  color: Application().color.white),
              colorText: Application().color.white,
              snackPosition: SnackPosition.TOP,
              backgroundColor: Application().color.valid);
        });
        update();
      } else {
        _hasError = true;
        update();
      }
    } on FirebaseAuthException catch (e) {
      _handleAuthError(context, e, msgType);
    } catch (e) {
      print("Google sign-in error: $e");
      _hasError = true;
      update();
    }
  }

  // Sign-in with email and password
  Future<void> signInWithEmail(
    UserModel user,
    BuildContext context,
    String msgType,
  ) async {
    try {
      //shoe alert dialog
      showLoadingAlert(
        context,
        "Logging In",
        "Please wait while we verify your credentials...",
      );

      //LOGIN AT FIREBASE AUTH
      // final userCredential = await firebaseAuth.signInWithEmailAndPassword(
      //   email: user.email!,
      //   password: user.password!,
      // );

      // if (userCredential.user != null) {
      //
      //DELETE SESSIONS DATA
      clearStoredSessionData();

      //LOGIN AT API MYSQL
      var response = await AuthenticationApi.auth.login(user);
      Navigator.of(context).pop();

      if (response is String) {
        showValidationAlert(
          context,
          'Error',
          response,
          msgType,
          false,
          () {
            Navigator.of(context).pop();
          },
        );
        return;
      }

      //STORE SESSION DATA
      storeSessionData(newUser: response as UserModel);

      showValidationAlert(
        context,
        'Successful',
        'Successfully $msgType',
        msgType,
        true,
        () {
          Get.toNamed(ScreenRouter.getControlscreenRoute);
          Get.snackbar(
            'Successfully Login',
            'Welcome back, ${user.name}!',
            icon: Icon(Icons.check_circle_outline,
                color: Application().color.white),
            colorText: Application().color.white,
            snackPosition: SnackPosition.TOP,
            backgroundColor: Application().color.valid,
          );
        },
      );
      // }
    } on FirebaseAuthException catch (e) {
      _handleAuthError(context, e, msgType);
    }
  }

  void storeSessionData({required UserModel newUser}) async {
    await SessionAccess.instance.storeSessionToken(
      sessionName: SessionAccess.names.SESSION_LOGIN,
      token: newUser.access_token,
    );
    await SessionAccess.instance.storeUserData(newUser);
  }

  void clearStoredSessionData() {
    SessionAccess.instance.deleteSessionToken(
      sessionName: SessionAccess.names.SESSION_LOGIN,
    );
    SessionAccess.instance.deleteUserData();
  }

  Future<void> getDataFromSharedPreferences() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _name = s.getString('name');
    _email = s.getString('email');
    _imageUrl = s.getString('image_url');
    _uid = s.getString('uid');
    _provider = s.getString('provider');
    _address = s.getString('address');
    _birthdate = s.getString('birthdate');
    _gender = s.getString('gender');
    _phoneNumber = s.getString('phoneNumber');
    _imageEmail = s.getString('imageEmail');
    update();
  }

  // checkUser exists or not in cloudfirestore
  // Future<bool> checkUserExists() async {
  //   DocumentSnapshot snap =
  //       await FirebaseFirestore.instance.collection('users').doc(_uid).get();
  //   if (snap.exists) {
  //     print("EXISTING USER");
  //     return true;
  //   } else {
  //     print("NEW USER");
  //     return false;
  //   }
  // }

  void handleUserLogin() async {
    final BookmarkController bookmarkController = Get.put(BookmarkController());
    await bookmarkController.loadBookmarks();
  }

  // signout
  Future userSignOut() async {
    firebaseAuth.signOut;
    await googleSignIn.signOut();

    _isSignedIn = false;
    update();
    // clear all storage information
    clearStoredData();
  }

  Future clearStoredData() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.clear();
  }

  bool isPasswordVisible = false;

  // Handle FirebaseAuth exceptions
  void _handleAuthError(
      BuildContext context, FirebaseAuthException e, String msgType) {
    final errorMsg = _getErrorMessage(e.code);
    showValidationAlert(context, 'Opps...', errorMsg, msgType, false, () {
      Navigator.of(context).pop();
    });
  }

  // Return error message based on FirebaseAuthException code
  String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'invalid-credential':
        return 'Verify your credentials and try again.';
      case 'invalid-email':
        return 'Incorrect Email';
      case 'too-many-requests':
        return 'Account Temporarily Disabled';
      default:
        return 'Unknown Error Occurred';
    }
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }

  // Validation methods
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  final borderCust = OutlineInputBorder(
    borderSide: BorderSide(color: Application().color.primarylow, width: 1.2),
    borderRadius: BorderRadius.circular(6),
  );
}
