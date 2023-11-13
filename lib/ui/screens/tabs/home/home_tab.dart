import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:final_project/data/model/popular_movies_responses.dart';
import 'package:final_project/ui/screens/tabs/home/new_releases_movies/new_releases_movies_list.dart';
import 'package:final_project/ui/screens/tabs/home/popular_movie_view_model.dart';
import 'package:final_project/ui/screens/tabs/home/recomended_movies/recomended_movies_list.dart';
import 'package:final_project/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common_widgets/error_widget.dart';
import '../../../../common_widgets/loading_widget.dart';
import '../details_screen/details_screen.dart';




class HomeTab extends StatefulWidget {
  static const String routeName = "Hometab";

  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeState();
}

class _HomeState extends State<HomeTab> {
  PopularMoviesViewModal viewModel = PopularMoviesViewModal();
  String baseUrl = "https://image.tmdb.org/t/p/w500";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel.getPopular();
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentView;
    return BlocBuilder<PopularMoviesViewModal, MoviesStatePopular>(
      bloc: viewModel,
      builder: (context, state) {
        if (state is LoadingStatePop) {
          currentView = const LoadingWidget();
        } else if (state is SuccessStatePopular) {
          currentView = buildPopularMovieHome(state.results);
        } else {
          currentView = ErrorView(message: (state as ErrorStatePopular).errorMessage);
        }
        return currentView;
      },
    );
  }

  Widget buildPopularMovieHome(List<ResultsPopular> results) {
    return Column(
      children: [
        Expanded(
            flex: 4,
            child: CarouselSlider(
                items: results.map((movie) => buildPopularMovie(movie)).toList(),
                options: CarouselOptions(autoPlay: true, viewportFraction: 1,height: double.infinity))),

        Expanded(
          flex: 4,
          child: Container(
            padding: const EdgeInsets.all(8),
            color: AppColors.grey4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 12, top: 4),
                    child: const Text(
                      "New release",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )),
                const Expanded(child: NewReleasesMovieList()),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        Expanded(
          flex: 5,
          child: Container(
            padding: const EdgeInsets.all(8),
            color: AppColors.grey4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 12, top: 4),
                    child: const Text(
                      "Recommended",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )),
                const Expanded(child: RecomendedMovieList()),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildPopularMovie(ResultsPopular movie) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        CachedNetworkImage(
          imageUrl: "$baseUrl${movie.backdropPath}",
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width * double.infinity,
          height: MediaQuery.of(context).size.height * double.infinity,
          placeholder: (_, __) => const Center(child: LoadingWidget()),
          errorWidget: (_, __, ___) => const Icon(
            Icons.error,
            color: AppColors.yellow,
          ),
        ),
        Container(
          width: double.infinity,
          height: 80,
          color:  AppColors.scaffoldBackground,
          child: Row(
            children: [
               SizedBox(
                  width: MediaQuery.of(context).size.width * .34,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      SizedBox(
                          width: 220,
                          child: Text(
                            movie.title ?? "",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                            overflow: TextOverflow.fade,
                            softWrap: false,
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${DateTime.tryParse(movie.releaseDate!)?.year??"".toString()}",
                        style:
                            const TextStyle(color: AppColors.grey6, fontSize: 10),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(movie.adult! ? " " : "PG-13",
                          style: const TextStyle(
                              color: AppColors.grey6, fontSize: 10)),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: 18,
          child: Stack(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, DetailsScreen.routeName, arguments: movie.id.toString());
                },
                child: CachedNetworkImage(
                  imageUrl: "$baseUrl${movie.posterPath}",
                  height: MediaQuery.of(context).size.height * .20,
                  width: MediaQuery.of(context).size.width * .28,
                  fit: BoxFit.fill,
                  placeholder: (_, __) => const Center(child: LoadingWidget()),
                  errorWidget: (_, __, ___) => const Icon(
                    Icons.error,
                    color: AppColors.yellow,
                  ),
                ),
              ),
            ),
            InkWell(
                onTap: () {},
                child: const Image(
                    image: AssetImage('assets/images/bookmark.png')))
          ]),
        )
      ],
    );
  }
}
