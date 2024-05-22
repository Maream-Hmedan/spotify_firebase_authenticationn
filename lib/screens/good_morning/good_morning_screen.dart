import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:spotify/screens/good_morning/widget/sugg_artists.dart';
import 'package:spotify/screens/good_morning/widget/top_music.dart';
import 'package:spotify/screens/good_morning/widget/weakly_music.dart';


class GoodMorning extends StatefulWidget {
  const GoodMorning({Key? key}) : super(key: key);

  @override
  State<GoodMorning> createState() => _GoodMorningState();
}

class _GoodMorningState extends State<GoodMorning> {
  @override
  Widget build(
      BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             SizedBox(height: 3.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                const Text("Good Morning",style:
                TextStyle(color: Colors.white,fontWeight: FontWeight.w700,
                    fontSize: 24),
                ),
                IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert,
                  color: Colors.white,)),
              ],
            ),
            SizedBox(height: 2.h,),
            Row(
              children:[
                IconButton(onPressed: (){}, icon:
                  const Icon(Icons.electric_bolt,
                  color: Colors.green,
                   ),
                     ),
               RichText(text: const TextSpan(
                 text: "Weakly ",
                 style: TextStyle(color: Colors.green,fontSize: 19,fontWeight: FontWeight.w400),
                 children: [
                   TextSpan(
                     text: " Music",
                     style: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.w400,),),
                 ],
               ),
               ),
              ],
            ),
             SizedBox(height: 2.h,),
            const WeaklyMusicList(),
            SizedBox(height: 3.h,),
            const Text("Your Top Mixes",style:
            TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.white),),
            SizedBox(height: 2.h,),
            const TopMixes(),
            SizedBox(height: 2.h,),
            const Text("Suggested artists",style:
            TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.white),),
            SizedBox(height: 2.h,),
            const SuggestedArtists()
          ],

        ),

      ),
    );
  }
}
