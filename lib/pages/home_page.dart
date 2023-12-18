import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:mod_android/model/article/Article.dart';
import 'package:mod_android/pages/article/detail_article_page.dart';
import 'package:mod_android/provider/article_provider.dart';
import 'package:mod_android/theme.dart';
import 'package:mod_android/widget/car_status_card.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  List<Article> carouselList =
      ArticleProvider.getArticleList().take(3).toList();
  int _currentIndex = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPrimary,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/bg_primary.png',
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hallo",
                            style: hallo.copyWith(
                              fontSize: 38,
                            ),
                          ),
                          Text(
                            "SELAMAT DATANG",
                            style: primaryTextStyle.copyWith(
                              fontSize: 17.26,
                              fontWeight: semibold,
                            ),
                          )
                        ],
                      ),
                      Image.asset("assets/kai_logo.png")
                    ],
                  ),
                ),
                const SizedBox(
                  height: 43,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: backgroundPrimary,
                    ),
                    padding: const EdgeInsets.only(
                      left: 25,
                      right: 25,
                      top: 50,
                      bottom: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                            child: Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12.0),
                                    ),
                                    color: statusCardColor,
                                  ),
                                  child: CarouselSlider(
                                    options: CarouselOptions(
                                      height: double.infinity,
                                      viewportFraction: 1.0,
                                      enlargeCenterPage: false,
                                      autoPlay: true,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          _currentIndex = index;
                                        });
                                      },
                                    ),
                                    items: carouselList
                                        .map(
                                          (item) => GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: ((context) =>
                                                      DetailArticlePage(
                                                        article: item,
                                                      )),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: statusCardColor,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    item.thumbanail,
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 0, 40, 55),
                                                width: double.infinity,
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Colors
                                                          .transparent, // Transparan di tengah
                                                      Colors
                                                          .transparent, // Transparan di tengah
                                                      baseMovieGradientColor
                                                          .withOpacity(
                                                              0.5), // Warna hitam dengan transparansi 50%
                                                      baseMovieGradientColor
                                                          .withOpacity(
                                                              0.8), // Warna hitam dengan transparansi 50%
                                                      baseMovieGradientColor
                                                          .withOpacity(
                                                              1), // Warna hitam dengan transparansi 50%
                                                    ],
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                  ),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      item.title,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: primaryTextStyle
                                                          .copyWith(
                                                        fontSize: 25,
                                                        fontWeight: bold,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              // width: 805,
                                              // height: 374,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 20.0,
                                    left: 20,
                                  ),
                                  child: DotsIndicator(
                                    dotsCount: carouselList.length,
                                    position: _currentIndex,
                                    decorator: DotsDecorator(
                                      size: Size(7, 7),
                                      activeSize: Size(25, 7),
                                      activeShape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            5.0), // Radius sudut dot untuk bentuk persegi
                                      ),
                                      color: Colors.grey,
                                      activeColor: Color(0xffe04d6e),
                                      spacing: EdgeInsets.symmetric(
                                        horizontal: 5,
                                        vertical: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/movie');
                                },
                                child: AspectRatio(
                                  aspectRatio: 156 / 112,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          "assets/button_movie.png",
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/music');
                                },
                                child: AspectRatio(
                                  aspectRatio: 156 / 112,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          "assets/button_music.png",
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, "/article");
                                },
                                child: AspectRatio(
                                  aspectRatio: 156 / 112,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          "assets/button_kai.png",
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 110,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CarStatusCard(
                    'Stasiun Asal',
                    "assets/icon_asal.png",
                    "Stasiun Surabaya Gubeng (SGU)",
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CarStatusCard(
                    'Stasiun Berikutnya',
                    "assets/icon_train.png",
                    "Poncol",
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CarStatusCard(
                    'Stasiun Tujuan',
                    "assets/icon_tujuan.png",
                    "Pasar Senen",
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CarStatusCard(
                    'Suhu Ruangan',
                    "assets/icon_suhu.png",
                    "30\u00B0 C",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
