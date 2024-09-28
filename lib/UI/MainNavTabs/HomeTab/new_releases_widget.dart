import 'package:flutter/material.dart';
import 'package:movies/Models/Home_Modules/TopRated/top_rated_response.dart';

import 'package:provider/provider.dart';

import '../../../Providers/details_screen_provider.dart';
import '../../../Providers/wish_list_provider.dart';
import '../../MoviesDetailsScreen/movies_details_screen.dart';

class NewReleasesWidget extends StatelessWidget {
  TopRatedResponse? topRatedResponse;
  late int index;
  late num movieId;
  late String movieTitle;
  late String moviePosterPath;
  late String movieOverview;
  late String movieReleaseDate;

  NewReleasesWidget(
      {super.key,
      required this.topRatedResponse,
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
              .setDetailsScreenId(topRatedResponse?.results?[index].id ?? 0);
          Navigator.pushNamed(context, MoviesDetailsScreen.routeName);
        },
        child: Container(
            width: 100,
            height: 130,
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
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      "https://image.tmdb.org/t/p/w500"
                      "${topRatedResponse?.results![index].posterPath ?? ""}",
                      fit: BoxFit.fill,
                    ),
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
                      child: value.isBookmarked(
                              topRatedResponse?.results![index].id ?? 0)
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
              ],
            )),
      ),
    );
  }
}
