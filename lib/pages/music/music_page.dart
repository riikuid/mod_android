import 'package:flutter/material.dart';
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
  int selectedMusic = 1;
  List<Music> listMusic = MusicProvider.getMusicList().toList();

  void _onMusicCardTap(int music) {
    setState(() {
      selectedMusic = music;
    });
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
          minItemWidth: 120,
          verticalGridSpacing: 20,
          children: listMusic
              .map(
                (music) => MusicCard(
                  selected: selectedMusic == music.id,
                  music: music,
                  musicId: music.id,
                  onTap: (isSelected) {
                    _onMusicCardTap(music.id);
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
          // image: DecorationImage(
          //   image: AssetImage(
          //     "assets/bg_primary.png",
          //   ),
          //   alignment: Alignment.topCenter,
          //   fit: BoxFit.cover,
          // ),
        ),
        // padding: const EdgeInsets.only(
        //   // top: 10,
        //   right: 20,
        //   left: 20,
        // ),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [
              Container(
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
                    Container(
                      height: 280,
                      width: 280,
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
                    const SizedBox(
                      width: 40,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hati - Hati di Jalan",
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
