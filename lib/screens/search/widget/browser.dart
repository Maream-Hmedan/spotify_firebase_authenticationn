import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:spotify/configuration/app_colors.dart';

class BrowseCard extends StatelessWidget {
  final String title;
  final String color1;
  final String color2;

  const BrowseCard(
      {super.key,
      required this.color1,
      required this.color2,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45.w,
      height: 11.h,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(colors: [
            hexToColor(color1),
            hexToColor(color2),
          ])),
      child: Text(title,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
    );
  }
}
