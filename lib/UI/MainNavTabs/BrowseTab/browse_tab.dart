import 'package:flutter/material.dart';
import 'package:movies/API_Managers/Browse_api_mangers/browse_api_manager.dart';
import 'package:movies/Models/Browse_modules/browse_response.dart';
import 'package:movies/Providers/genre_provider.dart';
import 'package:movies/UI/MoviesGenreList/movies_genre_list_screen.dart';
import 'package:provider/provider.dart';

class BrowseTab extends StatelessWidget {
  static const String routeName = "browse_tab";

  const BrowseTab({super.key});

  @override
  Widget build(BuildContext context) {
    final genreProvider = Provider.of<GenreProvider>(context, listen: false);
    List categoryCovers = [
      fetchImagePath("Action.jpg"),
      fetchImagePath("Adventure.jpg"),
      fetchImagePath("Animation.jpg"),
      fetchImagePath("Comedy.jpg"),
      fetchImagePath("Crime.jpg"),
      fetchImagePath("Documentary.jpg"),
      fetchImagePath("Drama.jpg"),
      fetchImagePath("Family.jpg"),
      fetchImagePath("Fantasy.jpg"),
      fetchImagePath("War.jpg"),
      fetchImagePath("Horror.jpg"),
      fetchImagePath("Music.jpg"),
      fetchImagePath("Mystery.jpg"),
      fetchImagePath("Romance.jpg"),
      fetchImagePath("Science Fiction.jpg"),
      fetchImagePath("TV Movie.jpg"),
      fetchImagePath("Thriller.jpg"),
      fetchImagePath("War.jpg"),
      fetchImagePath("Western.jpg"),
    ];
    return FutureBuilder(
        future: BrowseApiManager.getMoviesGenreIds(),
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
            BrowseResponse? response = snapshot.data;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 66,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 26),
                  child: Text(
                    "Browse Category",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,

                    ),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        genreProvider.setGenreId(
                            response?.genres?[index].name ?? " ",
                            response?.genres?[index].id ?? 0);

                        Navigator.pushNamed(
                            context, MoviesGenreListScreen.routeName);
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                              width: 230,
                              height: 180,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  categoryCovers[index],
                                  fit: BoxFit.fill,
                                ),
                              )),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                response?.genres?[index].name ?? " ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    itemCount: response?.genres?.length ?? 0,
                  ),
                ),
              ],
            );
          }
        });
  }

  String fetchImagePath(String imagePath) {
    String path = "Assets/AppAssets/Images/";

    return path + imagePath;
  }
}
