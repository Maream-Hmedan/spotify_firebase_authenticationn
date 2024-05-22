import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:spotify/Data/music_slider.dart';

class WeaklyMusicList extends StatefulWidget {
  const WeaklyMusicList({Key? key}) : super(key: key);

  @override
  State<WeaklyMusicList> createState() => _WeaklyMusicListState();
}

class _WeaklyMusicListState extends State<WeaklyMusicList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 18.h,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount:slider.length,
          scrollDirection: Axis.horizontal,
          itemBuilder:(context,int index){
            final slid = slider[index];
            return Column(
              children: [
                Container(
                  height:14.h,
                  width: 58.w,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image:  DecorationImage(
                        image: AssetImage(slid["image"]),
                        fit: BoxFit.cover,
                      )
                  ),
                ),
                const SizedBox(height: 8,),
                Text(slid['title'],
                    style: const TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center),
              ],
            );

          }),
    );
  }
}
