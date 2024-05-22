import 'package:flutter/cupertino.dart';
import 'package:spotify/Data/music_slider.dart';
import 'package:spotify/configuration/app_colors.dart';
import 'package:spotify/screens/your_library/widget/play_list_image.dart';




class PlayList extends StatefulWidget {
  const PlayList({Key? key}) : super(key: key);

  @override
  State<PlayList> createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount( crossAxisCount:2),
        itemCount: playList.length,
        itemBuilder: (context,index){
        final play=playList[index];
        return Container(
          decoration: BoxDecoration(
              color: ColorConstants.cardBackGroundColor,
              borderRadius: BorderRadius.circular(10)
          ),
          padding: const EdgeInsets.only(top: 10,),
          margin: const EdgeInsets.all(4),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Wrap(
                children: [
                PlayListImage(image: play['image_1']),
                PlayListImage(image: play['image_2']),
                PlayListImage(image: play['image_3']),
                PlayListImage(image: play['image_4']),
                ],
            ),
                const SizedBox(height: 8,),
                Text(play['title'], style: TextStyle(
                  color: ColorConstants.starterWhite,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                )),
          ],
          ),
        );

        },
    );
  }
}
