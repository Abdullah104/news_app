import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/views/widgets/news_details_page.dart';

import '../../models/news_item.dart';

class CustomCarouselSlider extends StatefulWidget {
  const CustomCarouselSlider({super.key});

  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider>
    with SingleTickerProviderStateMixin {
  final _animationDuration = const Duration(milliseconds: 600);
  final _animationCurve = Curves.ease;
  late final CarouselController _carouselController;
  late final Timer _timer;
  late final AnimationController _animationController;
  var _current = 0;
  int? indexToMoveTo;

  @override
  void initState() {
    super.initState();

    _carouselController = CarouselController();

    _animationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
      reverseDuration: _animationDuration,
      lowerBound: 16,
      upperBound: 32,
      value: 32,
    );

    _animationController.addListener(_onAnimationControllerChanged);

    _timer = Timer.periodic(
      const Duration(seconds: 4),
      (timer) {
        int nextIndex = (_current + 1) % news.length;

        _carouselController.animateToPage(
          (_current + 1) % news.length,
          curve: _animationCurve,
          duration: Duration(
            seconds: 1,
            milliseconds: _animationDuration.inMilliseconds * 2,
          ),
        );

        _animationController.reverse().then(
              (_) => Future.delayed(
                const Duration(seconds: 1),
                () {
                  setState(() => _current = nextIndex);
                  _animationController.forward();
                },
              ),
            );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: _carouselController,
          options: CarouselOptions(
            enlargeCenterPage: true,
            aspectRatio: 2,
            onPageChanged: _onPageChanged,
          ),
          itemCount: news.length,
          itemBuilder: (_, index, __) {
            final newsItem = news[index];

            return InkWell(
              onTap: () => Navigator.of(context, rootNavigator: true).push(
                CupertinoPageRoute(
                  builder: (context) => NewsDetailsPage(
                    newsItem: newsItem,
                  ),
                ),
              ),
              child: Container(
                margin: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Stack(
                    children: [
                      Image.network(
                        newsItem.imageUrl,
                        fit: BoxFit.cover,
                        width: 1000,
                      ),
                      Positioned(
                        top: 10,
                        left: 24,
                        child: Container(
                          decoration: BoxDecoration(
                            color: theme.primaryColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            newsItem.category,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    '${newsItem.author} • ${newsItem.time}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(200, 0, 0, 0),
                                    Color.fromARGB(0, 0, 0, 0),
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 24,
                              ),
                              child: Text(
                                newsItem.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            news.length,
            (index) {
              final current = _current == index;

              final previous = (index == news.length && _current == 0) ||
                  (_current - index == 1);

              final width = current ||
                      previous &&
                          _animationController.status == AnimationStatus.reverse
                  ? _animationController.value
                  : _animationController.lowerBound;

              return GestureDetector(
                onTap: () => _carouselController.animateToPage(index),
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (_, child) => Container(
                    height: 16,
                    width: width,
                    margin: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color:
                          theme.primaryColor.withOpacity(current ? 0.8 : 0.16),
                      borderRadius: current ? BorderRadius.circular(8) : null,
                      shape: current ? BoxShape.rectangle : BoxShape.circle,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _timer.cancel();

    _animationController.removeListener(_onAnimationControllerChanged);
    _animationController.dispose();

    super.dispose();
  }

  void _onPageChanged(
    int index,
    CarouselPageChangedReason carouselPageChangedReason,
  ) {
    if (carouselPageChangedReason == CarouselPageChangedReason.manual) {
      setState(() => _current = index);
    } else {
      setState(() => indexToMoveTo = index);
    }
  }

  void _onAnimationControllerChanged() => setState(() {});
}
