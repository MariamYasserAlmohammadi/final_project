import 'package:final_project/data/model/new_releases_movies_responses.dart';
import 'package:final_project/ui/screens/tabs/home/new_releases_movies/new_releases.dart';
import 'package:flutter/material.dart';
import '../../../../../common_widgets/error_widget.dart';
import '../../../../../common_widgets/loading_widget.dart';
import '../../../../../data/repository/movies_repository/data_sources/data_sources.dart';



class NewReleasesMovieList extends StatelessWidget {
  const NewReleasesMovieList({super.key});

  static late int itemCount;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DataSources.getNewReleasesMovies(),
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

  Widget buildMoviesList(List<ResultsNewReleases> newReleasesMovie) {
    itemCount = newReleasesMovie.length;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return BuildNewReleasesMovie(newReleasesResults: newReleasesMovie[index]);
        },
    );
  }
}