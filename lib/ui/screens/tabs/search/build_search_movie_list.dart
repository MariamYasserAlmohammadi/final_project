import 'package:final_project/data/model/search_movies_responses.dart';
import 'package:flutter/material.dart';
import '../../../../data/repository/movies_repository/data_sources/data_sources.dart';
import 'build_search_movie.dart';

class BuildSearchMovieList extends StatelessWidget {
  final String q;
  const BuildSearchMovieList({super.key, required this.q});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DataSources.getMoviesBySearch(q),

      builder: (context, snapshot) {
        if(snapshot.hasData)
        {
          return buildMovieList(snapshot.data!);
        }
        else
        {
          return const Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage("assets/images/movies.png")),
              SizedBox(height: 8,),
              Text("No movies found!", style: TextStyle(color: Colors.grey, fontSize: 14),)
            ],
          ));
        }
      },
    );
  }

  Widget buildMovieList(List<SearchResults> searchResult) {
    return ListView.builder(
        itemCount: searchResult.length,
        itemBuilder: (context, index) {
          return BuildSearchMovie(searchResults: searchResult[index]);
        },
    );
  }
}