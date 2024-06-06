// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:spotify/configuration/app_colors.dart';
import 'package:spotify/configuration/current_session.dart';
import 'package:spotify/model/user_model.dart';
import 'package:spotify/screens/bottom_nav_bar/bottom_nav_bar_screen.dart';
import 'package:spotify/screens/register/register_screen.dart';
import 'package:spotify/utils/helpers/app_navigation.dart';
import 'package:spotify/utils/helpers/firebase_error_messages.dart';
import 'package:spotify/utils/ui/common_views.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;
  final TextEditingController _userNameTextEditingController =
      TextEditingController();
  final FocusNode _userNameFocusNode = FocusNode();

  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();
  final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    getRememberMe();
  }

  getRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    if (rememberMe) {
      _userNameTextEditingController.text = prefs.getString("email") ?? "";
      _passwordTextEditingController.text = prefs.getString("password") ?? "";
    }
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
                        height: 53.h,
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
                              "Login Account",
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
                                controller: _userNameTextEditingController,
                                focusNode: _userNameFocusNode,
                                label: 'Username',
                                keyboardType: TextInputType.name,
                                suffixIcon: const Icon(Icons.person_outline),
                                onSubmitted: (v) {
                                  _passwordFocusNode.requestFocus();
                                },
                                validator: (v) {
                                  if (v == null || v.isEmpty) {
                                    return "This Field is required";
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
                                  FocusManager.instance.primaryFocus!.unfocus();
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
                            SwitchListTile.adaptive(
                              value: rememberMe,
                              onChanged: ((bool value) {
                                setState(() {
                                  rememberMe = value;
                                });
                              }),
                              contentPadding: const EdgeInsets.all(0),
                              title: const Text('Remember me',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.blueGrey)),
                            ),
                            CommonViews().commonButton(
                                onPressed: () async {
                                  try {
                                    if (_key.currentState!.validate()) {
                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      await prefs.setBool(
                                          "rememberME", rememberMe);
                                      if (rememberMe) {
                                        await prefs.setString(
                                            "email",
                                            _userNameTextEditingController
                                                .text);
                                        await prefs.setString(
                                            "password",
                                            _passwordTextEditingController
                                                .text);
                                      }

                                      var databaseResult = await FirebaseFirestore
                                          .instance
                                          .collection("Users")
                                          .where("userName",
                                              isEqualTo:
                                                  _userNameTextEditingController
                                                      .text)
                                          .get();
                                      UserModel model =
                                          UserModel.fromQueryDocumentSnapShot(
                                              databaseResult.docs.first);
                                      String email = model.email;
                                      UserCredential result = await FirebaseAuth
                                          .instance
                                          .signInWithEmailAndPassword(
                                        email: email,
                                        password:
                                            _passwordTextEditingController.text,
                                      );
                                      if (result.user != null) {
                                        if (result.user!.emailVerified) {
                                          CurrentSession().setUser(model);
                                          AppNavigator.of(context)
                                              .pushReplacement(
                                                  const BottomNavBarScreen());
                                        } else {
                                          showToast(
                                              "Your Email Is Not Verified",
                                              backgroundColor:
                                                  AppColors.errorColor,
                                              duration:
                                                  const Duration(seconds: 5));
                                        }
                                      }
                                    }
                                  } catch (e) {
                                    if (e is FirebaseAuthException) {
                                      showToast(
                                          FirebaseErrors.getMessage(e.code),
                                          backgroundColor:
                                              AppColors.cardBackGroundColor,
                                          duration: const Duration(seconds: 5));
                                    }
                                    showToast(e.toString(),
                                        backgroundColor: AppColors.errorColor,
                                        duration: const Duration(seconds: 5));
                                  }
                                },
                                title: 'LOG IN',
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
                            SizedBox(
                              height: 2.h,
                            ),
                            const Text(
                              'Forget password?',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.blueGrey),
                              textAlign: TextAlign.center,
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
                            'Don’t have an account?',
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
                                  .push(const RegisterScreen());
                            },
                            child: const Text(
                              'Sign up now',
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
}
