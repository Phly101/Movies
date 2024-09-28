import 'package:flutter/material.dart';
import 'package:movies/API_Managers/Home_api_mangers/upcoming_api_manager.dart';
import 'package:movies/Models/Home_Modules/TopRated/top_rated_response.dart';
import 'package:movies/Models/Home_Modules/Upcoming/upcoming_response.dart';
import 'package:movies/UI/MainNavTabs/HomeTab/new_releases_widget.dart';
import 'package:movies/UI/MainNavTabs/HomeTab/popular_movies_widget.dart';
import 'package:movies/UI/MainNavTabs/HomeTab/recommended_widget.dart';
import 'package:shimmer/shimmer.dart';
import '../../../API_Managers/Home_api_mangers/top_rated_api_manager.dart';

class HomeTab extends StatelessWidget {
  static const String routeName = "home_tab";

  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;

    Future<List<dynamic>> fetchApiData() async {
      final topRatedMovies = await TopRatedApiManager.getTopRatedMovies();
      final upComingMovies = await UpComingApiManager.getUpComingMovies();
      return [topRatedMovies, upComingMovies];
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
            return Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                Shimmer.fromColors(
                    baseColor: Theme.of(context).colorScheme.onPrimary,
                    highlightColor: Theme.of(context).colorScheme.onSecondary,
                    child: Container(
                      height: 300,
                      width: 420,
                      color: Theme.of(context).colorScheme.onPrimary,
                    )),
                const SizedBox(
                  height: 16,
                ),
                Shimmer.fromColors(
                  baseColor: Theme.of(context).colorScheme.onPrimary,
                  highlightColor: Theme.of(context).colorScheme.onSecondary,
                  child: Container(
                    color: Theme.of(context).colorScheme.onPrimary,
                    width: double.infinity,
                    height: sizeHeight * 0.25,
                  ),
                ),
                const SizedBox(height: 16),
                Shimmer.fromColors(
                  baseColor: Theme.of(context).colorScheme.onPrimary,
                  highlightColor: Theme.of(context).colorScheme.onSecondary,
                  child: Container(
                      color: Theme.of(context).colorScheme.onPrimary,
                      width: double.infinity,
                      height: sizeHeight * 0.25),
                ),
              ],
            );
          } else {
            TopRatedResponse? topRatedResponse =
                snapshot.data?[0]; // new release
            UpcomingResponse? upcomingResponse =
                snapshot.data?[1]; // recommended

            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              primary: true,
              child: Column(
                children: [
                  const PopularMoviesWidget(),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    color: Theme.of(context).colorScheme.onPrimary,
                    width: double.infinity,
                    height: sizeHeight * 0.25,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "New Releases",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 12),
                          child: SizedBox(
                            height: sizeHeight * 0.195,
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                return NewReleasesWidget(
                                  topRatedResponse: topRatedResponse,
                                  index: index,
                                  movieId:
                                      topRatedResponse?.results?[index].id ?? 0,
                                  movieTitle: topRatedResponse
                                          ?.results?[index].originalTitle ??
                                      "",
                                  moviePosterPath: topRatedResponse
                                          ?.results?[index].posterPath ??
                                      "",
                                  movieOverview: topRatedResponse
                                          ?.results?[index].overview ??
                                      "",
                                  movieReleaseDate: topRatedResponse
                                          ?.results?[index].releaseDate ??
                                      "",
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(width: sizeWidth * 0.036);
                              },
                              itemCount: topRatedResponse?.results?.length ?? 0,
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    color: Theme.of(context).colorScheme.onPrimary,
                    width: double.infinity,
                    height: sizeHeight * 0.34,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "Recommended",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 12),
                          child: SizedBox(
                            height: sizeHeight * 0.25,
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                return RecommendedWidget(
                                  upcomingResponse: upcomingResponse,
                                  index: index,
                                  movieId:
                                      upcomingResponse?.results?[index].id ?? 0,
                                  movieTitle: upcomingResponse
                                          ?.results?[index].originalTitle ??
                                      "",
                                  moviePosterPath: upcomingResponse
                                          ?.results?[index].posterPath ??
                                      "",
                                  movieOverview: upcomingResponse
                                          ?.results?[index].overview ??
                                      "",
                                  movieReleaseDate: upcomingResponse
                                          ?.results?[index].releaseDate ??
                                      "",
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(width: sizeWidth * 0.036);
                              },
                              itemCount: upcomingResponse?.results?.length ?? 0,
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        });
  }
}
