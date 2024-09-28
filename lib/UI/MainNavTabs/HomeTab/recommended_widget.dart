import 'package:flutter/material.dart';
import 'package:movies/Models/Home_Modules/Upcoming/upcoming_response.dart';
import 'package:provider/provider.dart';

import '../../../Providers/details_screen_provider.dart';
import '../../../Providers/wish_list_provider.dart';
import '../../MoviesDetailsScreen/movies_details_screen.dart';

class RecommendedWidget extends StatelessWidget {
  UpcomingResponse? upcomingResponse;
  late int index;
  late num movieId;
  late String movieTitle;
  late String moviePosterPath;
  late String movieOverview;
  late String movieReleaseDate;

  RecommendedWidget(
      {super.key,
      required this.upcomingResponse,
      required this.index,
      required this.movieId,
      required this.movieTitle,
      required this.moviePosterPath,
      required this.movieOverview,
      required this.movieReleaseDate});

  @override
  Widget build(BuildContext context) {
    final detailsProvider =
        Provider.of<DetailsScreenProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 8),
      child: GestureDetector(
        onTap: () {
          detailsProvider
              .setDetailsScreenId(upcomingResponse?.results?[index].id ?? 0);
          Navigator.pushNamed(context, MoviesDetailsScreen.routeName);
        },
        child: Container(
            width: 110,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).colorScheme.onPrimary,
              border:
                  Border.all(color: Theme.of(context).colorScheme.onPrimary),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(3, 2), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                Stack(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      "https://image.tmdb.org/t/p/w500"
                      "${upcomingResponse?.results![index].posterPath ?? ""}",
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: -5,
                    child: Consumer<WishListProvider>(
                        builder: (context, value, child) {
                      return GestureDetector(
                        onTap: () {
                          value.toggleBookmark(movieId, moviePosterPath,
                              movieTitle, movieOverview, movieReleaseDate);
                        },
                        child: value.isBookmarked(movieId)
                            ? Image.asset(
                                "Assets/AppAssets/Icons/Addedbookmark@2x.png",
                                width: 35,
                                height: 35,
                              )
                            : Image.asset(
                                "Assets/AppAssets/Icons/bookmark@2x.png",
                                width: 35,
                                height: 35,
                              ),
                      );
                    }),
                  ),
                ]),
                Row(
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 16,
                    ),
                    Text(
                        upcomingResponse?.results![index].voteAverage
                                .toString()
                                .substring(0, 3) ??
                            "",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontSize: 10,
                            )),
                  ],
                ),
                Text(upcomingResponse?.results![index].originalTitle ?? "",
                    style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(
                  height: 3,
                ),
                Text(upcomingResponse?.results![index].releaseDate ?? "",
                    style: Theme.of(context).textTheme.titleSmall),
              ],
            )),
      ),
    );
  }
}
