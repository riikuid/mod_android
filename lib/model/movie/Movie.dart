import 'package:mod_android/model/movie/MovieGenre.dart';
import 'package:mod_android/model/movie/MovieItem.dart';

class Movie {
  late int id;
  late String title;
  late String description;
  late MovieGenre genre;
  late String releaseYear;
  late String urlPoster;
  late List<MovieItem> items;
  late DateTime createdAt;

  Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.genre,
    required this.releaseYear,
    required this.urlPoster,
    required this.items,
    required this.createdAt,
  });

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    genre = MovieGenre.fromJson(json['genre']);
    releaseYear = json['release_year'];
    urlPoster = json['url_poster'];
    items = json['items']
        .map<MovieItem>((item) => MovieItem.fromJson(item))
        .toList();
    createdAt = DateTime.parse(json['created_at']);
  }
}
