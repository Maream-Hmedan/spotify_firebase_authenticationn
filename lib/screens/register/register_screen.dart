// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sizer/sizer.dart';
import 'package:spotify/configuration/app_colors.dart';
import 'package:spotify/model/user_model.dart';
import 'package:spotify/screens/login/login_screen.dart';
import 'package:spotify/utils/helpers/app_navigation.dart';
import 'package:spotify/utils/helpers/firebase_error_messages.dart';
import 'package:spotify/utils/helpers/progress_hud.dart';
import 'package:spotify/utils/ui/common_views.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();

  final TextEditingController _mobileNumberController = TextEditingController();
  final FocusNode _mobileFocus = FocusNode();

  final TextEditingController _fullNameController = TextEditingController();
  final FocusNode _fullNameFocus = FocusNode();

  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();
  final GlobalKey<FormState> _key = GlobalKey();

  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FocusNode _confirmPasswordFocus = FocusNode();

  bool showErrorEmail = false;
  bool showErrorName = false;
  bool showErrorNumber = false;

  bool showErrorPassword = false;
  bool showErrorConfigPassword = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: _key,
        child: SizedBox(
          height: 100.h,
          child: Stack(
            children: [
              Container(
                height: 50.h,
                width: 100.w,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(60),
                    bottomLeft: Radius.circular(60),
                  ),
                  color: Colors.green,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 9.h,
                      child: Image.asset("assets/images/logo.png"),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    const Text(
                      " Millions of songs, free on spotify",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SizedBox(
                  height: 100.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 55.h,
                        margin: const EdgeInsets.all(20),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 23, vertical: 23),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(60),
                          ),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              "Register Account",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 5.h,
                              child: CommonViews().createTextFormField(
                                controller: _fullNameController,
                                focusNode: _fullNameFocus,
                                label: 'Username',
                                keyboardType: TextInputType.name,
                                suffixIcon: const Icon(Icons.person_outline),
                                onSubmitted: (v) {
                                  _emailFocusNode.requestFocus();
                                },
                                validator: (v) {
                                  if (v == null || v.isEmpty) {
                                    return "This Field is required";
                                  }
                                  if (v.length < 5) {
                                    return "full name must be greater than 5 chars";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            SizedBox(
                              height: 5.h,
                              child: CommonViews().createTextFormField(
                                controller: _emailTextEditingController,
                                focusNode: _emailFocusNode,
                                label: 'Email ',
                                keyboardType: TextInputType.emailAddress,
                                suffixIcon: const Icon(Icons.email_outlined),
                                onSubmitted: (v) {
                                  _mobileFocus.requestFocus();
                                },
                                validator: (v) {
                                  if (v == null || v.isEmpty) {
                                    return "This Field is required";
                                  }
                                  if (!CommonViews().isEmail(
                                      _emailTextEditingController.text)) {
                                    return "Please Enter Valid Email";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            SizedBox(
                              height: 5.h,
                              child: CommonViews().createTextFormField(
                                controller: _mobileNumberController,
                                focusNode: _mobileFocus,
                                label: 'Your Phone Number',
                                keyboardType: TextInputType.phone,
                                suffixIcon: const Icon(Icons.phone_android),
                                onSubmitted: (v) {
                                  _passwordFocusNode.requestFocus();
                                },
                                validator: (v) {
                                  if (v == null || v.isEmpty) {
                                    return "this field is required";
                                  }
                                  if (v.length < 9) {
                                    return "mobile must be greater than 9 chars";
                                  }
                                  if (v.contains(" ")) {
                                    return "mobile must not include white space";
                                  }
                                  if (!v.startsWith("07")) {
                                    return "mobile number not correct";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            SizedBox(
                              height: 5.h,
                              child: CommonViews().createTextFormField(
                                controller: _passwordTextEditingController,
                                focusNode: _passwordFocusNode,
                                label: "Password",
                                keyboardType: TextInputType.text,
                                suffixIcon:
                                    const Icon(Icons.visibility_outlined),
                                inputAction: TextInputAction.go,
                                isObscure: true,
                                onSubmitted: (value) {
                                  _confirmPasswordFocus.requestFocus();
                                },
                                validator: (v) {
                                  if (v == null || v.isEmpty) {
                                    return "This Field is required";
                                  }
                                  if (!CommonViews().validPassword(
                                      _passwordTextEditingController.text)) {
                                    return "Please Enter Strong password more than 6 characters";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            SizedBox(
                              height: 5.h,
                              child: CommonViews().createTextFormField(
                                controller: _confirmPasswordController,
                                focusNode: _confirmPasswordFocus,
                                label: "confirm Password",
                                keyboardType: TextInputType.text,
                                suffixIcon:
                                    const Icon(Icons.visibility_outlined),
                                inputAction: TextInputAction.go,
                                isObscure: true,
                                onSubmitted: (value) {
                                  FocusManager.instance.primaryFocus!.unfocus();
                                },
                                validator: (v) {
                                  if (v == null || v.isEmpty) {
                                    return "This Field is required";
                                  }
                                  if (!CommonViews().validPassword(
                                      _passwordTextEditingController.text)) {
                                    return "Please Enter Strong password more than 6 characters and ues special characters ";
                                  }
                                  if (v !=
                                      _passwordTextEditingController.text) {
                                    return "passwords not match";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            CommonViews().commonButton(
                                onPressed: () async {
                                  if (_key.currentState!.validate()) {
                                    ProgressHud.shared.startLoading(context);
                                    try {
                                      var acs = ActionCodeSettings(
                                          url: 'https://www.example.com',
                                          handleCodeInApp: true,
                                          iOSBundleId: 'com.example.ios',
                                          androidPackageName:
                                              'com.example.android',
                                          // installIfNotAvailable
                                          androidInstallApp: true,
                                          // minimumVersion
                                          androidMinimumVersion: '12');

                                      UserCredential result = await FirebaseAuth
                                          .instance
                                          .createUserWithEmailAndPassword(
                                        email: _emailTextEditingController.text,
                                        password:
                                            _passwordTextEditingController.text,
                                      );
                                      if (result.user != null) {
                                        await result.user!
                                            .sendEmailVerification(acs);
                                        _saveDataToFireStore(result.user!.uid);
                                        ProgressHud.shared.stopLoading();
                                        showToast("Please Verify Your Email",
                                            backgroundColor:
                                                AppColors.primaryColor,
                                            duration:
                                                const Duration(seconds: 2));
                                        AppNavigator.of(context).pop();
                                        AppNavigator.of(context)
                                            .push(const LoginScreen());
                                      } else {
                                        if (kDebugMode) {
                                          print("error");
                                        }
                                      }
                                    } on FirebaseAuthException catch (e) {
                                      if (kDebugMode) {
                                        print(e);
                                      }
                                      ProgressHud.shared.stopLoading();
                                      showToastWidget(
                                          Container(
                                            width: 80.w,
                                            height: 10.h,
                                            padding: const EdgeInsets.all(8),
                                              decoration:  BoxDecoration(
                                                  borderRadius: const BorderRadius.all(
                                                    Radius.circular(20),
                                                  ),color: AppColors.errorColor,),
                                         child: Center(
                                                child: Text(
                                                    FirebaseErrors.getMessage(
                                                            e.code) )),
                                          ),
                                          duration: const Duration(seconds: 5));
                                    } catch (e) {
                                      if (kDebugMode) {
                                        print(e);
                                      }
                                      ProgressHud.shared.stopLoading();
                                      showToast(e.toString(),
                                          backgroundColor: Colors.red);
                                      showToastWidget(SizedBox(
                                        height: 80,
                                        width: 100.w,
                                        child: Text(e.toString()),
                                      ));
                                    }
                                  }

                                },
                                title: 'Sign Up ',
                                height: 38),
                            SizedBox(
                              height: 1.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Expanded(
                                  child: Divider(
                                    thickness: 1,
                                    height: 1,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                const Text("or",
                                    style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400)),
                                SizedBox(
                                  width: 2.w,
                                ),
                                const Expanded(
                                    child: Divider(
                                  thickness: 1,
                                  height: 1,
                                  color: Colors.blueGrey,
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 40,
                                    child: Image.asset(
                                        'assets/images/google+.png')),
                                SizedBox(
                                  width: 2.w,
                                ),
                                SizedBox(
                                    height: 40,
                                    child: Image.asset(
                                        'assets/images/facebook.png')),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already Have Account',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              AppNavigator.of(context)
                                  .push(const LoginScreen());
                            },
                            child: const Text(
                              'Sign In Now',
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.w700),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


void _saveDataToFireStore(String uid) async {
  UserModel model = UserModel(
      email: _emailTextEditingController.text,
      mobile: _mobileNumberController.text,
      uid: uid,
      username:_fullNameController.text,
      isVerify: false);


  FirebaseFirestore.instance.collection("Users").add(model.toJson());
}
}
