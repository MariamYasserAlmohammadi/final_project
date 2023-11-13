import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project/ui/screens/tabs/details_screen/similar_movies/similar_movie_list.dart';
import 'package:final_project/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../common_widgets/error_widget.dart';
import '../../../../common_widgets/loading_widget.dart';
import '../../../../data/model/details_movie_responses.dart';
import '../../../../data/repository/movies_repository/data_sources/data_sources.dart';



class DetailsScreen extends StatelessWidget {
  static const String routeName = "DetailsScreen";
  late String id;
  String baseUrl = "https://image.tmdb.org/t/p/w500";
  DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    id = ModalRoute.of(context)!.settings.arguments as String;

    return FutureBuilder(
      future: DataSources.getDetailsMovies(id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return buildDetailsMovie(snapshot.data!, context);
        } else if (snapshot.hasError) {
          return ErrorView(message: snapshot.error.toString());
        } else {
          return const LoadingWidget();
        }
      },
    );
  }

  Widget buildDetailsMovie(
      DetailsMovieResponses detailsMovieResponses, BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: Text(
          detailsMovieResponses.title ?? "",
          style: const TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
        backgroundColor: AppColors.grey2,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: SizedBox(
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: "$baseUrl${detailsMovieResponses.backdropPath}",
                fit: BoxFit.fill,
                placeholder: (context, url) => const Center(child: LoadingWidget()),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  color: AppColors.yellow,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              margin: const EdgeInsets.only(right: 14,left: 14,top: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 2,),
                  Text(
                    detailsMovieResponses.title ?? "",
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Text(
                        "${DateTime.tryParse(detailsMovieResponses.releaseDate!)?.year??"".toString()}",
                        style: const TextStyle(
                            color:AppColors.grey3,
                            fontSize: 10,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(detailsMovieResponses.adult! ?" ":"PG-13",
                          style: const TextStyle(
                              color: AppColors.grey3,
                              fontSize: 10,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: CachedNetworkImage(
                              imageUrl:
                                  "$baseUrl${detailsMovieResponses.posterPath}",
                              height: MediaQuery.of(context).size.height * .24,
                              fit: BoxFit.fill,
                              placeholder: (context, url) =>
                                  const LoadingWidget(),
                              errorWidget: (context, url, error) => const Center(
                                  child: Icon(
                                Icons.error,
                                color: AppColors.yellow,
                              )),
                            ),
                          )),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                GridView.builder(
                                    shrinkWrap: true,
                                    controller: ScrollController(keepScrollOffset: false),
                                    itemCount: detailsMovieResponses.genres!.length,
                                    itemBuilder: (context, index) => Container(
                                      height: double.infinity,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              border: Border.all(
                                                  width: 2, color: Colors.grey)),
                                          child: Center(child: Text(detailsMovieResponses.genres![index].name??"",
                                            style: const TextStyle(
                                                color: Colors.white54,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10),
                                          )),
                                        ),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 6,
                                      childAspectRatio: 2,
                                      crossAxisSpacing: 6,
                                    )),
                                const SizedBox(height: 6,),
                                SizedBox(
                                    height: 95,
                                    width: double.infinity,
                                    child: SingleChildScrollView(
                                        child: Text(
                                      detailsMovieResponses.overview ?? "",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300),
                                    ))),
                                SizedBox(height: MediaQuery.of(context).size.height * .01,),
                                Row(
                                  children: [
                                    const Icon(Icons.star,color: AppColors.yellow),
                                    const SizedBox(width: 4,),
                                    Text(detailsMovieResponses.voteAverage!.toStringAsFixed(1).toString(),
                                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),),
                                  ],
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              color: AppColors.grey4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(flex: 1, child: Padding(
                    padding: EdgeInsets.only(top: 10, left: 12),
                    child: Text("More Like This", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),),
                  ),),
                  Expanded(flex:5,child: SimilarMovieList(id: detailsMovieResponses.id.toString(),)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}