import '../../model/popular_movies_responses.dart';
import 'data_sources/data_sources.dart';

class MoviesRepository {
 DataSources onlineDataSources;

  MoviesRepository(this.onlineDataSources);

  Future<PopularMoviesResponses?> getPopMovies() async {
    PopularMoviesResponses responses =
        await onlineDataSources.getPopularMovies();
    return responses;
  }
}
