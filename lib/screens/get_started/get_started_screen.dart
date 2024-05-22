import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:spotify/utils/helpers/app_navigation.dart';
import 'package:spotify/utils/ui/common_views.dart';
import '../login/login_screen.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/getStarted.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
                "A digital music, podcast, and video service that gives you access to millions of songs and other content from creators all over the world.",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
                textAlign: TextAlign.center),
            SizedBox(
              height: 3.h,
            ),
            CommonViews().commonButton(
                onPressed: () {
                  AppNavigator.of(context).push(const LoginScreen());
                },
                title: 'Get Started', height: 58),
            SizedBox(
              height: 3.h,
            ),
          ],
        ),
      ),
    );
  }
}
