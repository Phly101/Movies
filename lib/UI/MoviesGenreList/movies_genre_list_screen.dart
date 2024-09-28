import 'package:flutter/material.dart';
import 'package:movies/API_Managers/Browse_api_mangers/genre_api_manager.dart';
import 'package:movies/Models/Browse_modules/GenreModule/genre_response.dart';
import 'package:movies/Providers/details_screen_provider.dart';
import 'package:movies/Providers/genre_provider.dart';
import 'package:provider/provider.dart';

import '../MoviesDetailsScreen/movies_details_screen.dart';

class MoviesGenreListScreen extends StatelessWidget {
  static const String routeName = "MoviesGenreListScreen";

  const MoviesGenreListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final detailsProvider =
    Provider.of<DetailsScreenProvider>(context, listen: false);
    final genreProvider = Provider.of<GenreProvider>(context, listen: false);
    String? genreName = genreProvider.fetchGenreName();
    num? genreId = genreProvider.fetchGenreId();

    return FutureBuilder(
        future: GenreApiManager.getMoviesGenre(genreId.toString()),
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
            GenreResponse? genreResponse = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.white),
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                toolbarHeight: 100,
                title: Text(
                  genreName ?? " ",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              body: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10, left: 10, right: 10, top: 10),
                        child: GestureDetector(
                          onTap: () {
                            detailsProvider.setDetailsScreenId(genreResponse?.results?[index].id?? 0);
                            Navigator.pushNamed(context, MoviesDetailsScreen.routeName);
                          },
                          child: AspectRatio(
                            aspectRatio: 1.5,
                            child: Image.network(
                              "https://image.tmdb.org/t/p/w500${genreResponse?.results?[index].posterPath ?? ""}",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ));
                  },
                  itemCount: genreResponse?.results?.length ?? 0),
            );
          }
        });
  }
}
