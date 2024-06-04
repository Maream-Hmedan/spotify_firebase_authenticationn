import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:spotify/firebase_options.dart';

import 'screens/get_started/get_started_screen.dart';

void main() async {
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Spotify',
        color: Colors.green,
        theme: ThemeData(
          primarySwatch: Colors.green,
         useMaterial3: false,

        ),
        debugShowCheckedModeBanner: false,
        home: const GetStartedScreen(),


      );
    });

  }
}

