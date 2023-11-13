import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../data/model/search_movies_responses.dart';
import '../../../../common_widgets/loading_widget.dart';
import '../details_screen/details_screen.dart';


class BuildSearchMovie extends StatelessWidget {
  SearchResults searchResults;
  BuildSearchMovie({super.key, required this.searchResults});
  String baseUrl = "https://image.tmdb.org/t/p/w500";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, DetailsScreen.routeName, arguments: searchResults.id.toString());
            },
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(imageUrl: "$baseUrl${searchResults.posterPath}",
                    height: MediaQuery.of(context).size.height * .20,
                    width: MediaQuery.of(context).size.width * .34,
                    placeholder: (context, url) {
                      return const LoadingWidget();
                    },
                    fit: BoxFit.fill,
                    errorWidget: (context, url, error) {
                      return const Center(child: Icon(Icons.error,color: AppColors.yellow),);
                    },
                  ),
                ),
                const SizedBox(width: 4,),
                Container(
                  height: MediaQuery.of(context).size.height * .09,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text(searchResults.title??"",
                              style: const TextStyle(color: Colors.white, fontSize: 16),
                              softWrap: false, overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4,),
                      Text("${DateTime.tryParse(searchResults.releaseDate!)?.year??"".toString()}",
                        style: const TextStyle(fontSize: 10,color: AppColors.grey3, fontWeight: FontWeight.w400),),
                      const SizedBox(height: 8,),
                      Row(
                        children: [
                          const Icon(Icons.star,color: AppColors.yellow ,size: 16),
                          const SizedBox(width: 4,),
                          Text(searchResults.voteAverage!.toStringAsFixed(1),style: const TextStyle(color: Colors.white, fontSize: 10),)
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 12,),
          const Divider(color: Colors.white,indent: 6,endIndent: 6,)
        ],
      ),
    );
  }
}