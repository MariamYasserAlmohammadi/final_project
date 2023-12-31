import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../../common_widgets/loading_widget.dart';
import '../../../../../data/model/similar_movies_responses.dart';
import '../details_screen.dart';


class BuildSimilarMovie extends StatelessWidget {
  ResultsSimilar similarResults;
  BuildSimilarMovie({super.key, required this.similarResults});


  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailsScreen.routeName, arguments: similarResults.id.toString());
      },
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                child: ClipRRect(
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(4),topLeft: Radius.circular(4)),
                    child:
                    Stack(children: [
                      CachedNetworkImage(
                        imageUrl: "$baseUrl${similarResults.posterPath}",
                        height: MediaQuery.of(context).size.height * .16,
                        width: MediaQuery.of(context).size.width * .24,
                        fit: BoxFit.fill,
                        placeholder: (_, __) => const Center(child: LoadingWidget()),
                        errorWidget: (_, __, ___) => const Icon(Icons.error, color: Color.fromRGBO(
                            253, 174, 26, 1.0),),
                      ),
                      InkWell(onTap: (){},child: const Image(image: AssetImage('assets/images/bookmark.png'))),
                    ])),
              ),
            ],
          ),
          ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(6),bottomRight: Radius.circular(6)),
              child: Container(
                padding: const EdgeInsets.all(4),
                width: MediaQuery.of(context).size.width * .26,height: MediaQuery.of(context).size.height * .068,color: const Color.fromARGB(255, 52, 53, 52),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Image(image: AssetImage('assets/images/star.png')),
                        const SizedBox(width: 4,),
                        Text(similarResults.voteAverage!.toStringAsFixed(1),
                          style: const TextStyle(fontSize: 10,color: Colors.white,fontWeight: FontWeight.w400),)
                      ],
                    ),
                    const SizedBox(height: 3,),
                    SizedBox(width: 200,child: Text(similarResults.title??"",
                        style: const TextStyle(fontWeight: FontWeight.w400,color: Colors.white,fontSize: 10),
                        overflow: TextOverflow.ellipsis, maxLines: 1,softWrap: false)),
                    const SizedBox(height: 4,),
                    Row(
                      children: [
                        Text("${DateTime.tryParse(similarResults.releaseDate!)?.year??"".toString()}",
                          style: const TextStyle(fontSize: 8,color: AppColors.grey6, fontWeight: FontWeight.w400),),
                        const SizedBox(width: 4,),
                        Text(similarResults.originalLanguage??"", style: const TextStyle(fontSize: 8,color: AppColors.grey6,
                            fontWeight: FontWeight.w400),),
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
  String baseUrl = "https://image.tmdb.org/t/p/w500";
}