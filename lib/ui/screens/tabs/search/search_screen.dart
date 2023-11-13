import 'package:final_project/ui/screens/tabs/search/build_search_movie_list.dart';
import 'package:final_project/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';


class SearchScreen extends StatefulWidget {
  static const String routeName = "SearchScreen";
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.scaffoldBackground,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 28,vertical: 10),
            width: double.infinity,
            height: 55,
            child: TextField(
              controller: controller,
              onChanged: (value) {
                setState(() {
                  BuildSearchMovieList(q: value,);
                });
              },
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(255, 81, 79, 79),
                prefixIcon: InkWell(
                  overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                  onTap: () {
                  setState(() {BuildSearchMovieList(q: controller.text,);});
                  }, child: const Icon(Icons.search,size: 24,color: Colors.white,),),
                hintText: "Search",
                hintStyle: const TextStyle(color: Colors.white,fontSize: 14),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white,width: 2),
                    borderRadius: BorderRadius.circular(32)
                ),
              ),
            ),
          ),
          Expanded(
              child: BuildSearchMovieList(q: controller.text) ,
          )
        ],
      ),
    );
  }
}