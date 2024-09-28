import 'package:flutter/material.dart';
import 'package:movies/Models/MoreLikeThis_modules/more_like_this_response.dart';
import 'package:provider/provider.dart';

import '../../Providers/details_screen_provider.dart';
import '../../Providers/wish_list_provider.dart';

class MoreLikeThisWidget extends StatelessWidget {
  MoreLikeThisResponse? moreLikeThisResponse;
  late int index;
  late num movieId;
  late String movieTitle;
  late String? moviePosterPath;
  late String movieOverview;
  late String movieReleaseDate;
  late num? voteAverage;

  MoreLikeThisWidget(
      {super.key,
      required this.moreLikeThisResponse,
      required this.index,
      required this.movieId,
      required this.movieTitle,
      required this.moviePosterPath,
      required this.movieOverview,
      required this.movieReleaseDate,
      required this.voteAverage,

      });

  @override
  Widget build(BuildContext context) {
    final detailsProvider =
    Provider.of<DetailsScreenProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(
          bottom: 12, top: 12),
      child: Container(
        width: 110,
        height: 300,
        decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(5),
          color: Theme.of(context)
              .colorScheme
              .onPrimary,
          border: Border.all(
              color: Theme.of(context)
                  .colorScheme
                  .onPrimary),
          boxShadow: [
            BoxShadow(
              color:
              Colors.black.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(3,
                  2), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Stack(children: [
              ClipRRect(
                borderRadius:
                BorderRadius.circular(5),
                child: moviePosterPath ==
                    ""
                    ? const Icon(
                  Icons.image,
                  size: 100,
                )
                    : Image.network(
                  "https://image.tmdb.org/t/p/w500"
                      "$moviePosterPath",
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                top: 0,
                left: -5,
                child: Consumer<
                    WishListProvider>(
                    builder: (context, value,
                        child) {
                      return GestureDetector(
                        onTap: () {
                          value.toggleBookmark(
                              movieId,
                              moviePosterPath,
                              movieTitle,
                              movieOverview,
                              movieReleaseDate

                          );
                        },
                        child: value.isBookmarked(
                            movieId)
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
                  color: Theme.of(context)
                      .colorScheme
                      .secondary,
                  size: 16,
                ),
                Text(
                    voteAverage.toString()
                        .substring(
                        0, 3)

                    ,style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(
                      fontSize: 10,
                    )),
              ],
            ),
            Text(
                movieTitle,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall),
            const SizedBox(
              height: 3,
            ),
            Text(
                movieReleaseDate,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall),
          ],
        ),
      ),
    );
  }
}
