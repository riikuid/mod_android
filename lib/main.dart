import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mod_android/pages/article/article_page.dart';
import 'package:mod_android/pages/home_page.dart';
import 'package:mod_android/pages/movie/detail_movie_page.dart';
import 'package:mod_android/pages/movie/movie_page.dart';
import 'package:mod_android/pages/music/music_page.dart';
import 'package:mod_android/provider/article_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ArticleProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const HomePage(),
          '/movie': (context) => const MoviePage(),
          '/detail-movie': (context) => const DetailMoviePage(),
          '/music': (context) => const MusicPage(),
          '/article': (context) => const ArticlePage(),
        },
        title: 'Multimedia on Demand',
      ),
    );
  }
}
