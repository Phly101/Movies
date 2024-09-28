import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movies/API_Managers/Home_api_mangers/popular_api_manager.dart';
import 'package:movies/Providers/wish_list_provider.dart';
import 'package:movies/UI/MoviesDetailsScreen/movies_details_screen.dart';
import 'package:provider/provider.dart';

import 'package:shimmer/shimmer.dart';

import '../../../Models/Home_Modules/Popular/popular_response.dart';
import '../../../Providers/details_screen_provider.dart';

class PopularMoviesWidget extends StatelessWidget {
  const PopularMoviesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    final detailsProvider =
        Provider.of<DetailsScreenProvider>(context, listen: false);
    return FutureBuilder(
        future: PopularApiManager.getPopularMovies(),
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
            return Center(
                child: SizedBox(
              child: Shimmer.fromColors(
                  baseColor: Theme.of(context).colorScheme.onPrimary,
                  highlightColor: Theme.of(context).colorScheme.onSecondary,
                  child: Container(
                    height: 300,
                    width: 420,
                    color: Theme.of(context).colorScheme.onPrimary,
                  )),
            ));
          } else {
            PopularResponse? popularResponse = snapshot.data;

            return Padding(
              padding: const EdgeInsets.only(top: 26.0),
              child: SizedBox(
                height: 300,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    var titleLength =
                        popularResponse!.results?[index].title?.length ?? 0;
                    var popular = popularResponse.results?[index];
                    return InkWell(
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              detailsProvider.setDetailsScreenId(
                                  popularResponse.results?[index].id ?? 0);
                              Navigator.pushNamed(
                                  context, MoviesDetailsScreen.routeName);
                            },
                            child: SizedBox(
                              height: sizeHeight * 0.25,
                              width: 420,
                              child: Hero(
                                tag: popularResponse.results?[index].id ?? 0,
                                child: Image.network(
                                  "https://image.tmdb.org/t/p/w500"
                                  "${popularResponse.results?[index].backdropPath ?? "empty"}",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 15,
                            child: InkWell(
                              onTap: () {
                                detailsProvider
                                    .setDetailsScreenId(popular?.id ?? 0);
                                Navigator.pushNamed(
                                    context, MoviesDetailsScreen.routeName);
                              },
                              child: SizedBox(
                                height: sizeHeight * 0.22,
                                width: sizeWidth * 0.32,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(
                                    "https://image.tmdb.org/t/p/w500"
                                    "${popular?.posterPath ?? "empty"}",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 90,
                            left: 10,
                            child: Consumer<WishListProvider>(
                                builder: (context, value, child) {
                              return GestureDetector(
                                onTap: () {
                                  value.toggleBookmark(
                                    popular?.id ?? 0,
                                    popular?.posterPath ?? "empty",
                                    popular?.originalTitle ?? "empty",
                                    popular?.overview ?? "empty",
                                    popular?.releaseDate ?? "empty",
                                  );
                                },
                                child: value.isBookmarked(popular?.id ?? 0)
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
                          Positioned(
                            right: 200,
                            bottom: 200,
                            child: Image.asset(
                              "Assets/AppAssets/Icons/playButton.png",
                              height: 60,
                              width: 60,
                            ),
                          ),
                          titleLength < 26
                              ? Positioned(
                                  right: 130,
                                  bottom: 50,
                                  child: Text(
                                    popular?.title.toString() ?? " ",
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ))
                              : Positioned(
                                  right: 60,
                                  bottom: 50,
                                  child: Text(
                                    popular?.title.toString() ?? " ",
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  )),
                          Positioned(
                              right: 130,
                              bottom: 30,
                              child: Text(
                                popular?.releaseDate.toString() ?? " ",
                                style: Theme.of(context).textTheme.bodySmall,
                              ))
                        ],
                      ),
                    );
                  },
                  itemCount: popularResponse?.results?.length ?? 0,
                  scrollDirection: Axis.horizontal,
                  cacheExtent: 10.0,
                ),
              ),
            );
          }
        });
  }
}
