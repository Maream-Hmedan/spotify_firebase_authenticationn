import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:spotify/Data/music_slider.dart';
import 'package:spotify/configuration/app_colors.dart';


class TopMixes extends StatefulWidget {
  const TopMixes({Key? key}) : super(key: key);

  @override
  State<TopMixes> createState() => _TopMixesState();
}

class _TopMixesState extends State<TopMixes> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28.h,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount:topMixes.length,
        scrollDirection: Axis.horizontal,
        itemBuilder:(context,int index){
          final top = topMixes[index];
          return Container(
            padding: const EdgeInsets.only(right: 15, left: 15, top: 15, bottom: 0),
            margin:const EdgeInsets.symmetric(horizontal: 4),
            width: 37.w,
            height: 30.h,
            decoration: BoxDecoration(
              color: ColorConstants.cardBackGroundColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 16.h,
                  width: 30.w,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(image:AssetImage(top["image"]),fit:BoxFit.cover),

                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 7,
                        height: 24,
                        decoration: BoxDecoration(
                            color: hexToColor(top['color'])
                        ),
                      ),
                      const SizedBox(height: 12,),
                      Container(
                        height: 8,
                        decoration: BoxDecoration(
                            color: hexToColor(top['color']),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            )
                        ),
                      ),

                    ],
                  ),
                ),
                const SizedBox(height: 8,),
                Text(top['title'], style: TextStyle(
                  color: ColorConstants.starterWhite,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                )),
                const SizedBox(height: 2,),
                Text(top['description'], style: TextStyle(
                  color: ColorConstants.starterWhite,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ))
              ],
            ),
          );
        },
      ),
    );
  }
}
