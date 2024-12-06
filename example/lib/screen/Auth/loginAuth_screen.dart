import 'package:arcore_flutter_plugin_example/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../components/cust_elevatedbtn.dart';
import '../../components/cust_textformfield.dart';
import '../../controllers/Auth_Control/login_controller.dart';
import '../../routes/screen_routes.dart';
import '../../utils/_initApp.dart';

class LoginScreen extends StatefulWidget with Application {
  LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Application {
  final _emailControl = TextEditingController();
  final _passControl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (controller) => Scaffold(
        backgroundColor: color.white,
        body: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.38,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(image.BG6), fit: BoxFit.cover),
                          color: color.primarylow,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(
                                  setResponsiveSize(context, baseSize: 35)),
                              bottomRight: Radius.circular(
                                  setResponsiveSize(context, baseSize: 35))),
                        ),
                      ),
                      // Back button
                      Positioned(
                          top: setResponsiveSize(context, baseSize: 20),
                          left: setResponsiveSize(context, baseSize: 10),
                          child: IconButton(
                            icon: Icon(Icons.arrow_back, color: color.white),
                            onPressed: () =>
                                Get.toNamed(ScreenRouter.getGetstartedRoute),
                          )),
                      Center(
                        child: Image.asset(
                          logo.second,
                          scale: setResponsiveSize(context, baseSize: 2.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              top: setResponsiveSize(context, baseSize: 250),
              child: Container(
                width: double.infinity,
                padding:
                    EdgeInsets.all(setResponsiveSize(context, baseSize: 18)),
                decoration: BoxDecoration(
                  color: color.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                        setResponsiveSize(context, baseSize: 25)),
                    topRight: Radius.circular(
                        setResponsiveSize(context, baseSize: 25)),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Gap(setResponsiveSize(context, baseSize: 15)),
                        Text(
                          'LOGIN',
                          textAlign: TextAlign.center,
                          style: style.displaySmall(context,
                              color: color.primarylow,
                              fontsize:
                                  setResponsiveSize(context, baseSize: 22),
                              fontweight: FontWeight.w700,
                              fontspace:
                                  setResponsiveSize(context, baseSize: 4)),
                        ),
                        Gap(setResponsiveSize(context, baseSize: 5)),
                        Text(
                          'Login to your account',
                          textAlign: TextAlign.center,
                          style: style.displaySmall(context,
                              color: color.primarylow,
                              fontsize:
                                  setResponsiveSize(context, baseSize: 14),
                              fontweight: FontWeight.w400),
                        ),
                        Gap(setResponsiveSize(context, baseSize: 30)),
                        TextFormFields(
                          control: _emailControl,
                          labeltext: 'Email',
                          iconData: Icons.email,
                          isPassword: false,
                          validator: controller.validateEmail,
                        ),
                        Gap(setResponsiveSize(context, baseSize: 20)),
                        TextFormFields(
                          control: _passControl,
                          labeltext: 'Password',
                          iconData: Icons.lock,
                          isPassword: true,
                          isPasswordVisible: controller.isPasswordVisible,
                          togglePasswordVisibility:
                              controller.togglePasswordVisibility,
                          validator: controller.validatePassword,
                        ),
                        Gap(setResponsiveSize(context, baseSize: 10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Get.toNamed(
                                    ScreenRouter.getForgetPasswordRoute);
                              },
                              child: Text(
                                'Forgot Password?',
                                textAlign: TextAlign.center,
                                style: style.displaySmall(context,
                                    color: color.primarylow,
                                    fontsize: 15,
                                    fontweight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                        Gap(setResponsiveSize(context, baseSize: 10)),
                        CustElevatedbtn(
                          colors: color.primarylow,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              controller.signInWithEmail(_emailControl,
                                  _passControl, context, 'login');
                            }
                          },
                          child: Text(
                            'LOGIN',
                            textAlign: TextAlign.center,
                            style: style.buttonText(context,
                                color: color.white,
                                fontspace: 3,
                                fontsize:
                                    setResponsiveSize(context, baseSize: 15)),
                          ),
                        ),
                        Gap(setResponsiveSize(context, baseSize: 20)),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  setResponsiveSize(context, baseSize: 50)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Divider(
                                      thickness: setResponsiveSize(context,
                                          baseSize: 0.5),
                                      color: color.primarylow)),
                              Gap(setResponsiveSize(context, baseSize: 5)),
                              Text(
                                'or with',
                                textAlign: TextAlign.center,
                                style: style.displaySmall(context,
                                    color: color.primarylow,
                                    fontsize: 15,
                                    fontweight: FontWeight.w500),
                              ),
                              Gap(setResponsiveSize(context, baseSize: 5)),
                              Expanded(
                                  child: Divider(
                                      thickness: setResponsiveSize(context,
                                          baseSize: 0.5),
                                      color: color.primarylow)),
                            ],
                          ),
                        ),
                        Gap(setResponsiveSize(context, baseSize: 20)),
                        CustElevatedbtn(
                          colors: color.grey,
                          onPressed: () {
                            controller.signInWithGoogle(context, 'login');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                icon.GOOGLE,
                                scale: setResponsiveSize(context, baseSize: 20),
                              ),
                              Gap(setResponsiveSize(context, baseSize: 20)),
                              Text(
                                'Login with Google',
                                textAlign: TextAlign.center,
                                style: style.displaySmall(context,
                                    color: color.primarylow,
                                    fontsize: 15,
                                    fontweight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Gap(setResponsiveSize(context, baseSize: 30)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              textAlign: TextAlign.center,
                              style: style.displaySmall(context,
                                  color: color.primarylow,
                                  fontsize: 15,
                                  fontweight: FontWeight.w400),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Get.toNamed(ScreenRouter.getRegisterRoute),
                              child: Text(
                                'Register',
                                textAlign: TextAlign.center,
                                style: style.displaySmall(context,
                                    color: color.primary,
                                    fontsize: 15,
                                    fontweight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
