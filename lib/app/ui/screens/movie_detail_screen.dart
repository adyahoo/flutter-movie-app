import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/app/router/router.dart';
import 'package:movie_app/app/ui/widgets/movie_button.dart';
import 'package:movie_app/utils/app_color.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({super.key});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            leading: InkWell(
              onTap: () {
                goRouter.pop();
              },
              child: const Icon(
                Icons.chevron_left_rounded,
                size: 24,
                color: Colors.white,
              ),
            ),
            expandedHeight: 260,
            backgroundColor: PrimaryColor.main,
            flexibleSpace: LayoutBuilder(
              builder: (ctx, constraint) {
                bool isExpanded = constraint.maxHeight >= 94;

                return FlexibleSpaceBar(
                  title: (!isExpanded)
                      ? Text(
                          "adjhfasd",
                          style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.white),
                        )
                      : const SizedBox(),
                  centerTitle: true,
                  background: CarouselSlider.builder(
                    itemCount: 5,
                    options: CarouselOptions(
                      height: 300,
                      viewportFraction: 1,
                    ),
                    itemBuilder: (context, index, realIndex) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              right: 0,
                              bottom: 0,
                              left: 0,
                              child: Image.asset(
                                "assets/images/bg_welcome.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              bottom: 16,
                              left: 16,
                              child: Row(
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFCFCFCF),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              //Section Overview
              Padding(
                padding: const EdgeInsets.only(top: 14, right: 16, bottom: 16, left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "asdf",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          child: Icon(
                            Icons.favorite_border_rounded,
                            size: 22,
                            color: TextColor.secondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("asldkfjs", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.secondary)),
                        Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: OtherColor.dot,
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                        Text("asldkfjs", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.secondary)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Overview",
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(color: TextColor.primary),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Et leo duis ut diam quam nulla porttitor. Pellentesque habitant morbi tristique senectus. Duis at tellus at urna condimentum mattis pellentesque id nibh. Tristique magna sit amet purus gravida quis blandit turpis cursus. Purus non enim praesent elementum facilisis leo vel fringilla. Dignissim cras tincidunt lobortis feugiat vivamus at. Commodo ullamcorper a lacus vestibulum sed arcu non odio. Diam sollicitudin tempor id eu. Vehicula ipsum a arcu cursus vitae congue mauris. Sit amet venenatis urna cursus eget nunc. Commodo ullamcorper a lacus vestibulum sed arcu. Et netus et malesuada fames.",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.secondary),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                    _renderTeam("Director"),
                    _renderTeam("Characters"),
                    _renderTeam("Screenplay"),
                  ],
                ),
              ),
              Container(height: 6, color: OtherColor.lineDivider),
              //Section Rating
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: PrimaryColor.light),
                      child: Image.asset(
                        "assets/images/ic_star_movie.png",
                        width: 32,
                        height: 32,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("9 Star", style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.black)),
                          const SizedBox(height: 4),
                          Text("Total Vote : ", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.secondary)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: MovieButton.outline(
                        text: "Rated",
                        isLoading: false,
                        onPress: () {},
                        size: MovieButtonSize.small,
                      ),
                    ),
                  ],
                ),
              ),
              Container(height: 6, color: OtherColor.lineDivider),
              //Section Cast
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Top Billed Cast", style: Theme.of(context).textTheme.labelMedium?.copyWith(color: TextColor.primary)),
                    const SizedBox(height: 16),
                    Card(
                      surfaceTintColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      clipBehavior: Clip.antiAlias,
                      elevation: 1,
                      child: SizedBox(
                        width: 120,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Image.network(
                              "https://static.promediateknologi.id/crop/0x0:0x0/750x500/webp/photo/indizone/2023/03/22/jzs7P3z/viral-pakai-baju-bersimbol-nazi-chaeyoung-twice-minta-maaf-saya-tak-tahu-arti-simbol-itu37.jpg",
                              width: double.infinity,
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "asdfds",
                                    style: Theme.of(context).textTheme.labelMedium,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "asdfsdf",
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.secondary),
                                    maxLines: 1,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _renderTeam(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.secondary),
        ),
        const SizedBox(height: 4),
        Text(
          "Mamank skkrttt",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.primary),
        ),
      ],
    );
  }
}
