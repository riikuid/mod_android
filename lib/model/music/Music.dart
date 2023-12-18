import 'package:mod_android/model/music/Singer.dart';

class Music {
  late int id;
  late String title;
  late double duration;
  late Singer singer;

  Music({
    required this.id,
    required this.title,
    required this.duration,
    required this.singer,
  });

  Music.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    duration = json['duration'];
    singer = Singer.fromJson(json['singer']);
  }
}
