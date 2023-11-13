import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../../../common_widgets/loading_widget.dart';
import '../../../../../data/model/new_releases_movies_responses.dart';
import '../../details_screen/details_screen.dart';

class BuildNewReleasesMovie extends StatelessWidget {
  ResultsNewReleases newReleasesResults;
  BuildNewReleasesMovie({super.key, required this.newReleasesResults});
  String baseUrl = "https://image.tmdb.org/t/p/w500";

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context
            , DetailsScreen.routeName,
            arguments: newReleasesResults.id.toString());
      },
      child: Column(
        children: [
          const SizedBox(height: 16,),
          Row(
            children: [
              Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                  child:
                  Stack(children: [
                    CachedNetworkImage(
                      imageUrl: "$baseUrl${newReleasesResults.posterPath}",
                      height: MediaQuery.of(context).size.height * .18,
                      width: MediaQuery.of(context).size.width * .28,
                      fit: BoxFit.fill,
                      placeholder: (_, __) => const Center(child: LoadingWidget()),
                      errorWidget: (_, __, ___) => const Icon(Icons.error, color: AppColors.yellow,),
                    ),
                  InkWell(onTap: (){},child: const Image(image: AssetImage('assets/images/bookmark.png'))),
                  ])),
                ),
            ],
          ),
        ],
      ),
    );
  }
}