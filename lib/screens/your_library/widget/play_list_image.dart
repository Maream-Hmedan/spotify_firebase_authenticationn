import 'package:flutter/cupertino.dart';

class PlayListImage extends StatelessWidget {
  const PlayListImage({Key? key, required this.image,}) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      width: 75,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover
          )
      ),
    );
  }
}