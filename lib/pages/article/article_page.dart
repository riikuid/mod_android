import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:mod_android/model/article/Article.dart';
import 'package:mod_android/pages/article/detail_article_page.dart';
import 'package:mod_android/provider/article_provider.dart';
import 'package:mod_android/theme.dart';
import 'package:mod_android/widget/article_card.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  List<Article> articleList = ArticleProvider.getArticleList();
  List<Article> articleCarousel =
      ArticleProvider.getArticleList().take(3).toList();

  int _currentIndex = 0;

  Widget build(BuildContext context) {
    Widget header() {
      return Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.menu_book_rounded,
                color: Colors.white,
                size: 30,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Pilihan Artikel Lain",
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
      );
    }

    Widget articleListSection() {
      return ResponsiveGridList(
        listViewBuilderOptions: ListViewBuilderOptions(
          padding: const EdgeInsets.only(bottom: 20),
          physics: const NeverScrollableScrollPhysics(),
          primary: false,
          shrinkWrap: true,
        ),
        minItemWidth: 233.48,
        verticalGridSpacing: 20,
        children: articleList
            .map(
              (article) => ArticleCard(
                article: article,
              ),
            )
            .toList(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
        height: double.infinity,
        decoration: BoxDecoration(
          color: backgroundPrimary,
        ),
        padding: const EdgeInsets.only(
          // top: 10,
          right: 20,
          left: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            // scrollDirection: Axis.vertical,
            children: [
              const SizedBox(
                height: 34,
              ),
              Container(
                height: 310,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
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
                      // clipBehavior: Clip.antiAlias,
                    ),
                    items: articleCarousel
                        .map(
                          (item) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) => DetailArticlePage(
                                          article: item,
                                        )),
                                  ),
                                );
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 310,
                                      decoration: BoxDecoration(
                                        color: statusCardColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12.0),
                                        ),
                                        image: DecorationImage(
                                          image: AssetImage(
                                            item.thumbanail,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          item.title,
                                          style: primaryTextStyle.copyWith(
                                            fontSize: 28,
                                            fontWeight: semibold,
                                          ),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              "assets/kai_logo2.png",
                                              height: 20,
                                              fit: BoxFit.cover,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              DateFormat('EEEE, dd MMMM yyyy',
                                                      'id')
                                                  .format(
                                                item.createdAt,
                                              ),
                                              style: primaryTextStyle.copyWith(
                                                fontWeight: regular,
                                                fontSize: 14,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          item.description,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 5,
                                          style: primaryTextStyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: light,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList()),
              ),
              const SizedBox(
                height: 20,
              ),
              DotsIndicator(
                dotsCount: articleCarousel.length,
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
              const SizedBox(
                height: 35,
              ),
              header(),
              const SizedBox(
                height: 25,
              ),
              const SizedBox(
                height: 25,
              ),
              articleListSection(),
              // GridView.builder(gridDelegate: gridDelegate, itemBuilder: itemBuilder)

              // Container(
              //   height: 1000,
              //   width: double.infinity,
              //   color: Colors.white.withOpacity(0.5),
              // ),

              // Row(
              //   children: [
              //     Container(
              //       height: 223,
              //       width: 149.5,
              //       decoration: const BoxDecoration(
              //         color: Colors.white,
              //         borderRadius: BorderRadius.all(
              //           Radius.circular(12.0),
              //         ),
              //       ),
              //     )
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
