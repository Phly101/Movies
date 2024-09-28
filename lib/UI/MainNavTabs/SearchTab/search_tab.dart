import 'package:flutter/material.dart';
import 'package:movies/API_Managers/Search_api_mangers/movie_search_api_manager.dart';
import 'package:movies/Models/Search_modules/movies_from_search_response.dart';
import 'package:movies/Providers/details_screen_provider.dart';
import 'package:movies/UI/MoviesDetailsScreen/movies_details_screen.dart';
import 'package:provider/provider.dart';

class SearchTab extends StatefulWidget {
  static const String routeName = "search_tab";

  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  TextEditingController queryController = TextEditingController();
  Future<MoviesFromSearchResponse?>? searchFuture;
  bool isMovieFound = true;
  late int isLongString;

  void searchMovies() {
    // Trigger the API call and update the UI with the FutureBuilder
    setState(() {
      searchFuture =
          MovieSearchApiManager.getMovieFromSearch(queryController.text);
    });
  }

  bool isMovieInResults(
      MoviesFromSearchResponse? moviesResponse, String query) {
    if (moviesResponse == null || moviesResponse.results == null) return false;

    for (var movie in moviesResponse.results!) {
      if (movie.title != null &&
          movie.title!.trim().toLowerCase() ==
              queryController.text.trim().toLowerCase()) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final detailsProvider =
        Provider.of<DetailsScreenProvider>(context, listen: false);
    var size = MediaQuery.of(context).size;
    isLongString = 20;
    return FutureBuilder(
        future: searchFuture,
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
          } else {
            MoviesFromSearchResponse? moviesFromSearchResponse = snapshot.data;
            isMovieFound = isMovieInResults(
                moviesFromSearchResponse, queryController.text);

            return Column(
              children: [
                SizedBox(
                  height: size.height * 0.038,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 26, right: 26),
                  child: TextField(
                    controller: queryController,
                    onSubmitted: (movie) {
                      searchMovies();
                    },
                    cursorColor: Theme.of(context).colorScheme.onSecondary,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(36),
                        borderSide: BorderSide(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondary
                              .withOpacity(0.3),
                        ),
                      ),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.onPrimary,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(36),
                        borderSide: BorderSide(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondary
                              .withOpacity(0.1),
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).colorScheme.onSecondary,
                        size: 24,
                      ),
                      hintText: "Search",
                      hintStyle:
                          Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondary
                                    .withOpacity(0.5),
                              ),
                    ),
                  ),
                ),
                isMovieFound
                    ? Expanded(
                        child: SizedBox(
                          width: 340,
                          height: 600,
                          child: ListView.separated(
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                String movieTitle = moviesFromSearchResponse
                                        ?.results?[index].title ??
                                    'No Title';
                                String movieReleaseDate =
                                    moviesFromSearchResponse
                                            ?.results?[index].releaseDate ??
                                        'cant find a Release date';
                                return GestureDetector(
                                  onTap: () {
                                    detailsProvider.setDetailsScreenId(
                                        moviesFromSearchResponse
                                                .results?[index].id ??
                                            0);
                                    Navigator.pushNamed(
                                        context, MoviesDetailsScreen.routeName);
                                  },
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 16, right: 10, top: 16),
                                        child: SizedBox(
                                            width: 120,
                                            height: 120,
                                            child: Image.network(
                                              "https://image.tmdb.org/t/p/w500"
                                              "${moviesFromSearchResponse?.results?[index].posterPath}",
                                              fit: BoxFit.fill,
                                            )),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          moviesFromSearchResponse!
                                                      .results![index]
                                                      .title!
                                                      .length >
                                                  isLongString
                                              ? SizedBox(
                                                  width: 170,
                                                  child: Text(
                                                    movieTitle,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium,
                                                  ),
                                                )
                                              : Text(
                                                  movieTitle,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium,
                                                ),
                                          Text(
                                            movieReleaseDate,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSecondary
                                                        .withOpacity(0.5)),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Container(
                                  width: double.infinity,
                                  height: 2,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                );
                              },
                              itemCount:
                                  moviesFromSearchResponse?.results?.length ??
                                      0),
                        ),
                      )
                    : Expanded(
                        child: Center(
                            child: SizedBox(
                          width: 105,
                          height: 120,
                          child: Image.asset(
                            "Assets/AppAssets/Icons/NoMoviesIcon@2x.png",
                            fit: BoxFit.fill,
                          ),
                        )),
                      ),
              ],
            );
          }
        });
  }
}
