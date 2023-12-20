import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mod_android/model/music/Music.dart';
import 'package:mod_android/provider/music_provider.dart';
import 'package:mod_android/theme.dart';
import 'package:mod_android/widget/category_card.dart';
import 'package:mod_android/widget/movie_card.dart';
import 'package:mod_android/widget/music_card.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({super.key});

  @override
  State<MusicPage> createState() => MusicPageState();
}

class MusicPageState extends State<MusicPage> {
  String musicUrl = "assets/music/niki.mp3"; // Insert your music URL
  String thumbnailImgUrl =
      "assets/example_music.png"; // Insert your thumbnail URL
  AudioPlayer player = AudioPlayer();
  bool loaded = false;
  bool playing = false;
  int selectedMusic = 0;

  List<Music> listMusic = MusicProvider.getMusicList().toList();

  void _onMusicCardTap(Music music) {
    setState(() {
      selectedMusic = music.id;
    });
  }

  void loadMusic() async {
    await player.setAudioSource(AudioSource.asset(musicUrl));
    setState(() {
      loaded = true;
    });
  }

  void playMusic() async {
    setState(() {
      playing = true;
    });
    await player.play();
  }

  void pauseMusic() async {
    setState(() {
      playing = false;
    });
    await player.pause();
  }

  @override
  void initState() {
    loadMusic();
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget textTitle() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(
                  Icons.library_music,
                  color: Colors.white,
                  size: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Pilihan Musik",
                  style: primaryTextStyle.copyWith(
                    fontWeight: semibold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.white.withOpacity(0.5),
            ),
          ],
        ),
      );
    }

    Widget musicList() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ResponsiveGridList(
          listViewBuilderOptions: ListViewBuilderOptions(
            padding: const EdgeInsets.only(
              bottom: 20,
            ),
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            shrinkWrap: true,
          ),
          minItemWidth: 150,
          verticalGridSpacing: 20,
          children: listMusic
              .map(
                (music) => MusicCard(
                  selected: selectedMusic == music.id,
                  music: music,
                  musicId: music.id,
                  onTap: (isSelected) {
                    _onMusicCardTap(music);
                  },
                ),
              )
              .toList(),
        ),
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        actionsIconTheme: const IconThemeData(
          color: Colors.white,
          size: 25,
        ),
        actions: const [
          Icon(
            Icons.volume_up_rounded,
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.brightness_6_outlined,
          ),
          SizedBox(
            width: 20,
          ),
        ],
        title: Image.asset(
          'assets/kai_logo.png',
          height: 20,
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bg_primary.png"),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.home,
            size: 25,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: backgroundPrimary,
        ),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [
              // musicPlayer(),
              Container(
                height: 440,
                padding: const EdgeInsets.fromLTRB(60, 100, 60, 60),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/bg_primary.png",
                    ),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 280 / 280,
                      child: Container(
                        // height: 280,
                        // width: 280,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage(
                              "assets/example_music.png",
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                          border: Border.all(
                            width: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hati - Hati di Jalan Kami Datang e",
                                style: primaryTextStyle.copyWith(
                                  fontSize: 45,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Text(
                                "Orang Paling Tulus",
                                style: primaryTextStyle.copyWith(
                                  fontSize: 25,
                                  fontWeight: regular,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    IconButton(
                                        onPressed: loaded
                                            ? () async {
                                                if (player.position.inSeconds >=
                                                    10) {
                                                  await player.seek(Duration(
                                                      seconds: player.position
                                                              .inSeconds -
                                                          10));
                                                } else {
                                                  await player.seek(
                                                      const Duration(
                                                          seconds: 0));
                                                }
                                              }
                                            : null,
                                        icon: const Icon(
                                          Icons.fast_rewind_rounded,
                                          color: Colors.white,
                                          size: 30,
                                        )),
                                    IconButton(
                                        onPressed: loaded
                                            ? () {
                                                if (playing) {
                                                  pauseMusic();
                                                } else {
                                                  playMusic();
                                                }
                                              }
                                            : null,
                                        icon: Icon(
                                          playing
                                              ? Icons.pause_rounded
                                              : Icons.play_arrow_rounded,
                                          color: Colors.white,
                                          size: 50,
                                        )),
                                    IconButton(
                                        onPressed: loaded
                                            ? () async {
                                                if (player.position.inSeconds +
                                                        10 <=
                                                    player
                                                        .duration!.inSeconds) {
                                                  await player.seek(Duration(
                                                      seconds: player.position
                                                              .inSeconds +
                                                          10));
                                                } else {
                                                  await player.seek(
                                                      const Duration(
                                                          seconds: 0));
                                                }
                                              }
                                            : null,
                                        icon: const Icon(
                                          Icons.fast_forward_rounded,
                                          color: Colors.white,
                                          size: 30,
                                        )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                StreamBuilder(
                                    stream: player.positionStream,
                                    builder: (context, snapshot1) {
                                      final Duration duration = loaded
                                          ? snapshot1.data as Duration
                                          : const Duration(seconds: 0);
                                      return StreamBuilder(
                                          stream: player.bufferedPositionStream,
                                          builder: (context, snapshot2) {
                                            final Duration bufferedDuration =
                                                loaded
                                                    ? snapshot2.data as Duration
                                                    : const Duration(
                                                        seconds: 0);
                                            return Container(
                                              height: 30,
                                              // width: double
                                              //     .infinity,
                                              child: ProgressBar(
                                                barHeight: 3,
                                                progress: duration,
                                                total: player.duration ??
                                                    const Duration(seconds: 0),
                                                buffered: bufferedDuration,
                                                timeLabelPadding: -1,
                                                timeLabelTextStyle:
                                                    primaryTextStyle.copyWith(
                                                  fontSize: 14,
                                                ),
                                                progressBarColor: Colors.white,
                                                baseBarColor: Colors.white
                                                    .withOpacity(0.3),
                                                bufferedBarColor: Colors.white
                                                    .withOpacity(0.3),
                                                thumbColor: Colors.white,
                                                thumbRadius: 5,
                                                onSeek: loaded
                                                    ? (duration) async {
                                                        await player
                                                            .seek(duration);
                                                      }
                                                    : null,
                                              ),
                                            );
                                          });
                                    }),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 45,
              ),
              textTitle(),
              const SizedBox(
                height: 25,
              ),
              const SizedBox(
                height: 25,
              ),
              musicList(),
            ],
          ),
        ),
      ),
    );
  }
}
