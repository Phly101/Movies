import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movies/DataBase/movie.dart';
import 'package:movies/Providers/wish_list_provider.dart';
import 'package:movies/Theme/theme.dart';
import 'package:movies/UI/HomeScreen/home_screen.dart';
import 'package:movies/UI/MainNavTabs/BrowseTab/browse_tab.dart';
import 'package:movies/UI/MainNavTabs/HomeTab/home_tab.dart';
import 'package:movies/UI/MainNavTabs/SearchTab/search_tab.dart';
import 'package:movies/UI/MainNavTabs/WatchListTab/watch_list_tab.dart';
import 'package:movies/UI/MoviesDetailsScreen/movies_details_screen.dart';
import 'package:movies/UI/MoviesGenreList/movies_genre_list_screen.dart';
import 'package:provider/provider.dart';
import 'Providers/details_screen_provider.dart';
import 'Providers/genre_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MovieAdapter());
  final movieBox = await Hive.openBox<Movie>('myMovies');


  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => DetailsScreenProvider()),
    ChangeNotifierProvider(create: (_) => GenreProvider()),
    ChangeNotifierProvider(
      create: (_) {
        final wishListProvider = WishListProvider();
        wishListProvider.init(movieBox); // Pass the box to the provider
        return wishListProvider;
      },
    ),

  ],child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        HomeTab.routeName: (context) => const HomeTab(),
        SearchTab.routeName: (context) => const SearchTab(),
        BrowseTab.routeName: (context) => const BrowseTab(),
        WatchListTab.routeName: (context) => const WatchListTab(),
        MoviesDetailsScreen.routeName: (context) => const MoviesDetailsScreen(),
        MoviesGenreListScreen.routeName: (context) =>
            const MoviesGenreListScreen(),
      },
      theme: MyThemeData.lightTheme,
    );
  }
}
