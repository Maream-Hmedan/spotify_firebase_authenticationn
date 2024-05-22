import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'screens/get_started/get_started_screen.dart';

void main() {
  runApp(const MyApp());
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

