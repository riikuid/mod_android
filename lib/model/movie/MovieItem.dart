class MovieItem {
  late int id;
  late String name;

  MovieItem({
    required this.id,
    required this.name,
  });

  MovieItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
