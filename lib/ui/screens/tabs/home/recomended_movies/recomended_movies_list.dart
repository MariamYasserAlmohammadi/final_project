import 'package:flutter/material.dart';

import '../../../../../common_widgets/error_widget.dart';
import '../../../../../common_widgets/loading_widget.dart';
import '../../../../../data/model/recommended_movies_responses.dart';
import '../../../../../data/repository/movies_repository/data_sources/data_sources.dart';
import 'build_recomended_movies.dart';

class RecomendedMovieList extends StatelessWidget {
  const RecomendedMovieList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DataSources.getRecommendedMovies(),
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

  Widget buildMoviesList(List<ResultsRecomended> recomendedMovie) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: recomendedMovie.length,
      itemBuilder: (context, index) {
        return BuildRecomendedMovie(resultsRecomended: recomendedMovie[index]);
      },
    );
  }
}