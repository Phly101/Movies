import 'package:flutter/material.dart';
import 'package:movies/API_Managers/DetailsScreen_api_managers/credit_api_manager.dart';
import 'package:movies/API_Managers/DetailsScreen_api_managers/similar_api_manager.dart';
import 'package:movies/Models/Details_modules/movie_details_response.dart';
import 'package:movies/Models/MoreLikeThis_modules/more_like_this_response.dart';
import 'package:movies/Models/credits_module/credit_response.dart';
import 'package:movies/Providers/details_screen_provider.dart';
import 'package:movies/Providers/wish_list_provider.dart';
import 'package:movies/UI/MoviesDetailsScreen/cast_widget.dart';
import 'package:movies/UI/MoviesDetailsScreen/more_like_this_widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../API_Managers/DetailsScreen_api_managers/details_api_manager.dart';

class MoviesDetailsScreen extends StatefulWidget {
  static const String routeName = "MovieDetailsScreen";

  const MoviesDetailsScreen({super.key});

  @override
  State<MoviesDetailsScreen> createState() => _MoviesDetailsScreenState();
}

class _MoviesDetailsScreenState extends State<MoviesDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var sizeHeight = MediaQuery.of(context).size.height;

    final detailsProvider =
    Provider.of<DetailsScreenProvider>(context, listen: false);


    Future<List<dynamic>> fetchApiData() async {
      final details = await DetailsApiManager.getMoviesDetails(
          detailsProvider.fetchDetailsScreenId());
      final similar = await SimilarMovieApiManager.getSimilarMovies(
          detailsProvider.fetchDetailsScreenId());
      final movieCast = await CastCreditApiManager.getMovieCast(
          detailsProvider.fetchDetailsScreenId());
      return [details, similar, movieCast];
    }

    return FutureBuilder(
        future: fetchApiData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                children: [
                  Text(
                    snapshot.error.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Retry")),
                ],
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Shimmer.fromColors(
                      baseColor: Theme
                          .of(context)
                          .colorScheme
                          .onPrimary,
                      highlightColor: Theme
                          .of(context)
                          .colorScheme
                          .onSecondary,
                      child: Container(
                        height: 500,
                        width: 420,
                        color: Theme
                            .of(context)
                            .colorScheme
                            .onPrimary,
                      )),
                  const SizedBox(
                    height: 16,
                  ),
                  Shimmer.fromColors(
                    baseColor: Theme
                        .of(context)
                        .colorScheme
                        .onPrimary,
                    highlightColor: Theme
                        .of(context)
                        .colorScheme
                        .onSecondary,
                    child: Container(
                      color: Theme
                          .of(context)
                          .colorScheme
                          .onPrimary,
                      width: double.infinity,
                      height: sizeHeight * 0.25,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Shimmer.fromColors(
                    baseColor: Theme
                        .of(context)
                        .colorScheme
                        .onPrimary,
                    highlightColor: Theme
                        .of(context)
                        .colorScheme
                        .onSecondary,
                    child: Container(
                      color: Theme
                          .of(context)
                          .colorScheme
                          .onPrimary,
                      width: double.infinity,
                      height: sizeHeight * 0.25,
                    ),
                  ),
                ],
              ),
            );
          } else {
            MovieDetailsResponse? details = snapshot.data![0];
            MoreLikeThisResponse? moreLikeThisResponse = snapshot.data![1];
            CreditResponse? creditResponse = snapshot.data![2];

            return Scaffold(
              appBar: AppBar(
                title: Text(details?.title ?? "",
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge),
                iconTheme: Theme
                    .of(context)
                    .iconTheme,
                shadowColor: Colors.transparent,
                toolbarHeight: 60,
              ),
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                primary: true,
                child: Column(
                  children: [
                    Column(
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                                child: SizedBox(
                                    height: 240,
                                    width: double.infinity,
                                    child: Hero(
                                      tag: details?.id ?? "",
                                      child: Image.network(
                                        "https://image.tmdb.org/t/p/w500"
                                            "${details?.backdropPath ?? ""}",
                                      ),
                                    ))),
                            Positioned(
                              right: 180,
                              bottom: 100,
                              child: Image.asset(
                                "Assets/AppAssets/Icons/playButton.png",
                                height: 60,
                                width: 60,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(details?.title ?? "",
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                    fontSize: 18,
                                  )),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    details?.releaseDate.toString() ?? "",
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                      color: Theme
                                          .of(context)
                                          .colorScheme
                                          .onSecondary
                                          .withOpacity(0.5),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Text(movieRuntime(details?.runtime ?? 0),
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                        color: Theme
                                            .of(context)
                                            .colorScheme
                                            .onSecondary
                                            .withOpacity(0.5),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Stack(
                              children: [
                                SizedBox(
                                  width: screenWidth*0.33,
                                  height: screenWidth*0.5,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.network(
                                        "https://image.tmdb.org/t/p/w500"
                                            "${details?.posterPath ?? "empty"}",
                                        fit: BoxFit.fill),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  left: -5,
                                  child: Consumer<WishListProvider>(
                                      builder: (context, value, child) {
                                        return GestureDetector(
                                          onTap: () {
                                            value.toggleBookmark(
                                              details?.id ?? 0,
                                              details?.posterPath ?? "",
                                              details?.title ?? "",
                                              details?.overview ?? "",
                                              details?.releaseDate ?? "",
                                            );
                                          },
                                          child: value.isBookmarked(
                                            details?.id ?? 0,
                                          )
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
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                GridView.builder(
                                    shrinkWrap: true,
                                    gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 5,
                                      crossAxisSpacing: 5,
                                      childAspectRatio: 2.5,
                                    ),
                                    itemCount: details?.genres?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        width: 65,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(6),
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .onPrimary
                                              .withOpacity(0.5),
                                          border: Border.all(
                                              color: Theme
                                                  .of(context)
                                                  .colorScheme
                                                  .onPrimary,
                                              width: 0.7),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text(
                                            details?.genres?[index].name ?? "",
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .titleSmall,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      );
                                    }),
                                SizedBox(
                                  width: screenWidth * 0.5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      details?.overview ?? "",
                                      style:
                                      Theme
                                          .of(context)
                                          .textTheme
                                          .bodySmall,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top:8,left: 30,),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.star_rounded,
                                        color: Theme
                                            .of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                      Text(
                                          details?.voteAverage
                                              .toString()
                                              .substring(0, 3) ??
                                              "",
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .bodySmall),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    ///----------------------------details-------------------------------->end
                    const SizedBox(
                      height: 18,
                    ),
                    CastWidget(creditResponse: creditResponse),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      color: Theme
                          .of(context)
                          .colorScheme
                          .onPrimary,
                      width: double.infinity,
                      height: sizeHeight * 0.38,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "More like this",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .titleMedium,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 12),
                            child: SizedBox(
                              height: sizeHeight * 0.3,
                              child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        detailsProvider.setDetailsScreenId( moreLikeThisResponse?.results?[index].id);
                                        setState(() {

                                        });
                                      },
                                      child: MoreLikeThisWidget(
                                          moreLikeThisResponse: moreLikeThisResponse,
                                          index: index,
                                          movieId: moreLikeThisResponse?.results?[index].id ?? 0,
                                          movieTitle: moreLikeThisResponse?.results?[index].originalTitle ?? "",
                                          moviePosterPath: moreLikeThisResponse?.results?[index].posterPath ?? "",
                                          movieOverview: moreLikeThisResponse?.results?[index].overview ?? "",
                                          movieReleaseDate: moreLikeThisResponse?.results?[index].releaseDate ?? "",
                                          voteAverage:  moreLikeThisResponse?.results?[index].voteAverage ?? 0.0,
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(width: 16);
                                  },
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                  moreLikeThisResponse?.results?.length ??
                                      0),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }

  String movieRuntime(num runtime) {
    num hours = runtime ~/ 60;
    num minutes = runtime % 60;
    return "$hours h $minutes min";
  }
}
