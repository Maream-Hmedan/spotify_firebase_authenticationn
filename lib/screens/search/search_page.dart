import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:spotify/Data/music_slider.dart';
import 'package:spotify/configuration/app_colors.dart';
import 'package:spotify/screens/Search/widget/browser.dart';
import 'package:spotify/screens/Search/widget/podcasts.dart';
import 'package:spotify/screens/Search/widget/search_input.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               SizedBox(height: 3.h,),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children:  [
                 const Text("Search",style: TextStyle(color: Colors.white,
                     fontWeight: FontWeight.w700,fontSize: 24),),
                 IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert,color: Colors.white,)),
               ],
             ),
               SizedBox(height: 2.h,),
              const SearchInput(),
               SizedBox(height: 1.h,),
              Wrap(
                spacing:8 ,
                  runSpacing: 8,
                  children: searchList.map((search) => Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: ColorConstants.cardBackGroundColor,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child:Text(search,style: const TextStyle(
                        color: Colors.white,fontSize: 11,fontWeight: FontWeight.w400),) ,
                  )).toList(),
              ),
               SizedBox(height:3.h,),
              const Text("Podcast's",style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.w700,fontSize: 18),),
              const SizedBox(height: 8,),
              const Podcast(),
              const SizedBox(height: 16,),
              const Text("Browser all",style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.w700,fontSize: 18),),
              const SizedBox(height: 8,),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children:[
              BrowseCard (
                  title: 'Made For You',
                  color1: '#E02FCF',
                  color2: '#00C188'
              ),
              BrowseCard (
                  title: 'Charts',
                  color1: '#0A3CEC',
                  color2: '#4DD4AC'
              ),
              BrowseCard(
                  title: 'Discover',
                  color1: '#0A3CEC',
                  color2: '#D9DD01'
              ),
              BrowseCard(
                  title: 'New Release',
                  color1: '#0E31AE',
                  color2: '#DD1010'
              ),

            ],
          ),
          ],
        ),
        ),
      ),
    );
  }
}


