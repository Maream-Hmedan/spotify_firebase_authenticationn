import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:spotify/screens/your_library/widget/activities.dart';
import 'package:spotify/screens/your_library/widget/play_list.dart';



class YourLibrary extends StatefulWidget {
  const YourLibrary({Key? key}) : super(key: key);

  @override
  State<YourLibrary> createState() => _YourLibraryState();
}

class _YourLibraryState extends State<YourLibrary> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           SizedBox(height: 4.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                const Text("Your Library ",style: TextStyle(color: Colors.white,
                    fontWeight: FontWeight.w700,fontSize: 24),),
                 SizedBox(width: 23.w,),
                IconButton(onPressed: (){},
                    icon: const Icon(Icons.search_rounded,color: Colors.white,)),
                IconButton(onPressed: (){},
                    icon: const Icon(Icons.person,color: Colors.white,)),
              ],
            ),
            const PlayList(),
            const SizedBox(height: 4,),
            const Align(
              alignment: Alignment.center,
              child: Text("See All",style: TextStyle(color: Colors.white,fontSize: 18)),
            ),
             SizedBox(height: 2.h,),
            const Text("Your Activities",style: TextStyle(color: Colors.white,
                fontWeight: FontWeight.w700,fontSize: 18),),
            SizedBox(height: 2.h,),
            const ActivityCard(title: 'Liked Songs',icon: Icons.favorite),
            Divider(color: Colors.grey.shade800,),
            const ActivityCard(title: 'Followed Artist',icon: Icons.people),
            Divider(color: Colors.grey.shade800,),
            const ActivityCard(title: 'Followed Podcast', icon: Icons.mic),
          ],
        ),
      ),
    );
  }
}
