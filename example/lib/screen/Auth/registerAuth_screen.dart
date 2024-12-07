import 'package:arcore_flutter_plugin_example/models/data_model/md_user.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../components/cust_checkbox.dart';
import '../../components/cust_elevatedbtn.dart';
import '../../components/cust_textformfield.dart';
import '../../controllers/Auth_Control/login_controller.dart';
import '../../controllers/Auth_Control/register_controller.dart';
import '../../routes/screen_routes.dart';
import '../../utils/_initApp.dart';
import '../../utils/responsive.dart';

class RegisterScreen extends StatefulWidget with Application {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with Application {
  final TextEditingController _fnameControl = TextEditingController();
  final TextEditingController _emailControl = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmControl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) => GetBuilder<RegisterController>(
        init: RegisterController(),
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
                                image: AssetImage(image.BG6),
                                fit: BoxFit.cover),
                            color: color.primarylow,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(
                                    setResponsiveSize(context, baseSize: 35)),
                                bottomRight: Radius.circular(
                                    setResponsiveSize(context, baseSize: 35))),
                          ),
                        ),
                        Positioned(
                          top: setResponsiveSize(context, baseSize: 20),
                          left: setResponsiveSize(context, baseSize: 10),
                          child: IconButton(
                              icon: Icon(Icons.arrow_back, color: color.white),
                              onPressed: () =>
                                  Get.toNamed(ScreenRouter.getGetstartedRoute)),
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
                top: setResponsiveSize(context, baseSize: 100),
                child: Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.all(setResponsiveSize(context, baseSize: 17)),
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
                            'REGISTER',
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
                            'Create your new account',
                            textAlign: TextAlign.center,
                            style: style.displaySmall(context,
                                color: color.primarylow,
                                fontsize:
                                    setResponsiveSize(context, baseSize: 14),
                                fontweight: FontWeight.w400),
                          ),
                          Gap(setResponsiveSize(context, baseSize: 30)),
                          TextFormFields(
                            control: _fnameControl,
                            labeltext: 'Name',
                            iconData: Icons.person,
                            isPassword: false,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Username is required';
                              }
                              return null;
                            },
                          ),
                          Gap(setResponsiveSize(context, baseSize: 20)),
                          TextFormFields(
                            control: _emailControl,
                            labeltext: 'Email',
                            iconData: Icons.email,
                            isPassword: false,
                            validator: controller.validateEmail,
                          ),
                          Gap(setResponsiveSize(context, baseSize: 20)),
                          TextFormFields(
                            control: _passwordController,
                            labeltext: 'Password',
                            iconData: Icons.lock,
                            isPassword: true,
                            isPasswordVisible: controller.isPasswordVisible,
                            togglePasswordVisibility:
                                controller.togglePasswordVisibility,
                            validator: controller.validatePassword,
                          ),
                          Gap(setResponsiveSize(context, baseSize: 20)),
                          TextFormFields(
                            control: _confirmControl,
                            labeltext: 'Confirm Password',
                            iconData: Icons.lock,
                            isPassword: true,
                            isPasswordVisible:
                                controller.isConfirmPasswordVisible,
                            togglePasswordVisibility:
                                controller.toggleConfirmPasswordVisibility,
                            validator: (value) =>
                                controller.validateConfirmPassword(
                                    value, _passwordController.text),
                          ),
                          Gap(setResponsiveSize(context, baseSize: 10)),
                          CheckBoxs(
                            isRememberMeChecked: controller.isRememberMeChecked,
                            onChanged: (value) {
                              if (value != null) {
                                controller.toggleRememberMe();
                              }
                            },
                          ),
                          Gap(setResponsiveSize(context, baseSize: 20)),
                          CustElevatedbtn(
                            colors: color.primarylow,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                UserModel user = UserModel(
                                  name: _fnameControl.text,
                                  email: _emailControl.text,
                                  password: _passwordController.text,
                                  confirm_password: _confirmControl.text,
                                );

                                //
                                controller.toSignUpConfirm(
                                  user,
                                  context,
                                  'signup',
                                );
                              }
                            },
                            child: Text(
                              'REGISTER',
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
                          Gap(setResponsiveSize(context, baseSize: 15)),
                          CustElevatedbtn(
                            colors: color.grey,
                            onPressed: () {
                              loginController.signInWithGoogle(
                                context,
                                'login',
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  icon.GOOGLE,
                                  scale:
                                      setResponsiveSize(context, baseSize: 20),
                                ),
                                Gap(setResponsiveSize(context, baseSize: 20)),
                                Text(
                                  'Register with Google',
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
                                'Already have an account?',
                                textAlign: TextAlign.center,
                                style: style.displaySmall(context,
                                    color: color.primarylow,
                                    fontsize: 15,
                                    fontweight: FontWeight.w400),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Get.toNamed(ScreenRouter.getLoginRoute),
                                child: Text(
                                  'Login',
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
