import 'package:flutter/material.dart';
import 'package:spotify/configuration/app_colors.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({Key? key}) : super(key: key);

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
      filled: true,
      fillColor:ColorConstants.cardBackGroundColor,
      border:OutlineInputBorder(borderRadius: BorderRadius.circular(10),
      ) ,
      prefixIcon: const Icon(Icons.search,color: Colors.white),
      hintText: "Search" ,
      hintStyle: const TextStyle(color: Colors.white,fontSize: 15,),

    ),style: const TextStyle(color: Colors.white,fontSize: 14,),

    );
  }
}
