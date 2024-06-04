import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';
import 'package:spotify/Data/music_slider.dart';
import 'package:spotify/configuration/app_colors.dart';

class Podcast extends StatefulWidget {
  const Podcast({Key? key}) : super(key: key);

  @override
  State<Podcast> createState() => _PodcastState();
}

class _PodcastState extends State<Podcast> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:23.h,
      child:ListView.builder(
        scrollDirection: Axis.horizontal,
       shrinkWrap:true,
       physics: const BouncingScrollPhysics(),
       itemCount: podCast.length,
          itemBuilder: (context,index){
            final pod = podCast[index];
        return Container(
          decoration: BoxDecoration(
              color: AppColors.cardBackGroundColor,
              borderRadius: BorderRadius.circular(10)
          ),
          padding: const EdgeInsets.only(bottom: 0,left:15,right:15,top:15),
          margin:const EdgeInsets.symmetric(horizontal: 4),
          width: 38.w,
          height: 25.h,
          child: Column(
            children: [
              Container(
                height: 113,
                width: 125,
                decoration:BoxDecoration(image: DecorationImage(
                  image: AssetImage(pod['image']),
                 fit: BoxFit.fill,
                )),
              ),
              const SizedBox(height: 8,),
              Text(pod['title'],style: const TextStyle(
                  fontSize: 15,color:CupertinoColors.extraLightBackgroundGray,
                  fontWeight: FontWeight.w600),),
              const SizedBox(height: 8,),
              Text(pod['description'],style: const TextStyle(
                  fontSize: 14,color:CupertinoColors.extraLightBackgroundGray,
              ),),
            ],
          ),
        );

      })
    );
  }
}
