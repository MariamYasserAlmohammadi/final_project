import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/model/popular_movies_responses.dart';
import '../../../../data/repository/movies_repository/data_sources/data_sources.dart';
import '../../../../data/repository/movies_repository/movies_repository.dart';


class PopularMoviesViewModal extends Cubit<MoviesStatePopular>
{
  MoviesRepository moviesRepository = MoviesRepository (DataSources());
  PopularMoviesViewModal():super(LoadingStatePop());

  void getPopular() async
  {
    emit(LoadingStatePop());
    try{
      PopularMoviesResponses? response = await moviesRepository.getPopMovies();
      if(response != null && response.results!.isNotEmpty == true)
      {
        emit(SuccessStatePopular(response.results!));
      }
      else{
        throw " Something went wrong ";
      }
    }catch(error){
      emit(ErrorStatePopular(error.toString()));
    }
  }
}

class MoviesStatePopular{}
class SuccessStatePopular extends MoviesStatePopular
{
  List<ResultsPopular> results = [];
  SuccessStatePopular(this.results);
}

class LoadingStatePop extends MoviesStatePopular {

}
class ErrorStatePopular extends MoviesStatePopular {
  String errorMessage;
  ErrorStatePopular(this.errorMessage);
}