import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:spotify/Data/music_slider.dart';
import 'package:spotify/configuration/app_colors.dart';

class SuggestedArtists extends StatefulWidget {
  const SuggestedArtists({Key? key}) : super(key: key);

  @override
  State<SuggestedArtists> createState() => _SuggestedArtistsState();
}

class _SuggestedArtistsState extends State<SuggestedArtists> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 23.h,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount:artists.length,
        scrollDirection: Axis.horizontal,
        itemBuilder:(context,int index){
          final artist = artists[index];
          return Container(
            padding: const EdgeInsets.only(right: 15, left: 15, top: 15, bottom: 0),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 35.w,
            decoration: BoxDecoration(
              color: AppColors.cardBackGroundColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 110,
                  width: 110,
                  child: Image.asset(artist['image']),
                ),
                const SizedBox(height: 4,),
                Text(artist['name'], style: TextStyle(
                  color: AppColors.starterWhite,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
                ),

              ],
            ),
          );
        },
      ),
    );
  }
}

