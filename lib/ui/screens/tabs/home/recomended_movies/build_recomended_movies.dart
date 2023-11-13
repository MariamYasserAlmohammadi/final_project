import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../../../data/model/recommended_movies_responses.dart';
import '../../../../../common_widgets/loading_widget.dart';
import '../../details_screen/details_screen.dart';


class BuildRecomendedMovie extends StatelessWidget {
  ResultsRecomended resultsRecomended;
  BuildRecomendedMovie({super.key, required this.resultsRecomended});
  String baseUrl = "https://image.tmdb.org/t/p/w500";

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailsScreen.routeName, arguments: resultsRecomended.id.toString());
      },
      child: Column(
        children: [
          const SizedBox(height: 16,),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: ClipRRect(
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(4),topLeft: Radius.circular(4)),
                    child:
                    Stack(children: [
                      CachedNetworkImage(
                        imageUrl: "$baseUrl${resultsRecomended.posterPath}",height: MediaQuery.of(context).size.height * .18,
                        width: MediaQuery.of(context).size.width * .28,
                        fit: BoxFit.fill,
                        placeholder: (_, __) => const Center(child: LoadingWidget()),
                        errorWidget: (_, __, ___) => const Icon(Icons.error,
                          color: AppColors.yellow),
                      ),
                      InkWell(onTap: (){},child: const Image(image: AssetImage('assets/images/bookmark.png'))),
                    ])),
              ),
            ],
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(4),bottomRight: Radius.circular(4)),
              child: Container(
                padding: const EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width * .28,
                height: MediaQuery.of(context).size.height * .067,
                color: AppColors.grey5,
              child: Column(
                children: [
                  Row(
                    children: [
                      const Image(image: AssetImage('assets/images/star.png')),
                      const SizedBox(width: 4,),
                      Text(resultsRecomended.voteAverage!.toStringAsFixed(1),
                        style: const TextStyle(fontSize: 10,color: Colors.white,fontWeight: FontWeight.w400),)
                    ],
                  ),
                  const SizedBox(height: 4,),
                  SizedBox(width: 150,child: Text(resultsRecomended.title??"",
                    style: const TextStyle(fontWeight: FontWeight.w400,color: Colors.white,fontSize: 10),
                    overflow: TextOverflow.ellipsis, maxLines: 1,softWrap: false)),
                  const SizedBox(height: 2,),
                  Row(
                    children: [
                      Text("${DateTime.tryParse(resultsRecomended.releaseDate!)?.year??"".toString()}", style: const TextStyle(
                          fontSize: 8,color: AppColors.grey6, fontWeight: FontWeight.w400),),
                      const SizedBox(width: 4,),
                      Text(resultsRecomended.adult! ? " " : "PG-13", style: const TextStyle(fontSize: 8,color: AppColors.grey6, fontWeight: FontWeight.w400),),
                    ],
                  )
                ],
              ),
              ))
        ],
      ),
    );
  }
}