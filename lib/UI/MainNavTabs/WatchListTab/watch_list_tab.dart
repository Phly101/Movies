import 'package:flutter/material.dart';
import 'package:movies/Providers/wish_list_provider.dart';
import 'package:provider/provider.dart';

import '../../../DataBase/movie.dart';

class WatchListTab extends StatelessWidget {
  static const String routeName = "watchlist_tab";

  const WatchListTab({super.key});

  @override
  Widget build(BuildContext context) {
    final wishListProvider = Provider.of<WishListProvider>(context);
    List<Movie> bookmarks = wishListProvider.getBookmarks();

    return bookmarks.isEmpty
        ? Scaffold(
            appBar: AppBar(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "WatchList",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ) ,
              shadowColor: Colors.transparent,
            ),
            body: Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.secondary,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.onPrimary,
                        width: 1,
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                                      "Assets/AppAssets/Icons/MovieCrateIcon.png",
                                      height: 200,
                                      width: 200,
                                    ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "WishList is empty.",
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )),
        )
        : Scaffold(
            appBar: AppBar(
              title: Text(
                "WatchList",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              shadowColor: Colors.transparent,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                  child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Stack(children: [
                              Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 16, right: 10, top: 16),
                                  child: SizedBox(
                                      width: 130,
                                      height: 200,
                                      child: bookmarks[index].posterPath == null
                                          ? const Icon(Icons.image)
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: Image.network(
                                                "https://image.tmdb.org/t/p/w500"
                                                "${bookmarks[index].posterPath}",
                                                fit: BoxFit.fill,
                                              ),
                                            ))),
                              Positioned(
                                top: 16,
                                left: -6,
                                child: Consumer<WishListProvider>(
                                    builder: (context, value, child) {
                                  return GestureDetector(
                                      onTap: () {
                                        value.removeBookmark(
                                            bookmarks[index].id ?? 0);
                                      },
                                      child: Image.asset(
                                        "Assets/AppAssets/Icons/Addedbookmark@2x.png",
                                        width: 35,
                                        height: 35,
                                      ));
                                }),
                              ),
                            ]),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  bookmarks[index].originalTitle ?? "",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  bookmarks[index].releaseDate ?? "",
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
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Container(
                          width: double.infinity,
                          height: 2,
                          color: Theme.of(context).colorScheme.onPrimary,
                        );
                      },
                      itemCount: bookmarks.length)),
            ),
          );
  }
}
