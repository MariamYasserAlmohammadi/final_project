import 'package:flutter/material.dart';
import '../../../../../common_widgets/error_widget.dart';
import '../../../../../common_widgets/loading_widget.dart';
import '../../../../../data/model/similar_movies_responses.dart';

import '../../../../../data/repository/movies_repository/data_sources/data_sources.dart';
import 'build_similar_movies.dart';

class SimilarMovieList extends StatelessWidget {
  late String id;

  SimilarMovieList({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
   id =  ModalRoute.of(context)!.settings.arguments as String;

    return FutureBuilder(
      future: DataSources.getSimilarMovies(id),
      builder: (context, snapshot) {
        if(snapshot.hasData)
        {
          return buildMoviesList(snapshot.data!);
        }
        else if(snapshot.hasError)
        {
          return ErrorView(message: snapshot.error.toString());
        }
        else
        {
          return const LoadingWidget();
        }
      },
    );
  }

  Widget buildMoviesList(List<ResultsSimilar> simMovie) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: simMovie.length,
      itemBuilder: (context, index) {
        return BuildSimilarMovie(similarResults: simMovie[index]);
      },
    );
  }
}