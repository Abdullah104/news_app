import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/news_item.dart';
import '../widgets/custom_carousel_slider.dart';
import '../widgets/home_title_widget.dart';
import '../widgets/news_details_page.dart';
import '../widgets/recommendation_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              const SizedBox(height: 16),
              const HomeTitleWidget(title: 'Breaking News'),
              const SizedBox(height: 8),
              const CustomCarouselSlider(),
              const SizedBox(height: 16),
              const HomeTitleWidget(title: 'Recommendation'),
              const SizedBox(height: 8),
              ...news
                  .map(
                    (newsItem) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: InkWell(
                        onTap: () => Navigator.of(
                          context,
                          rootNavigator: true,
                        ).push(
                          CupertinoPageRoute(
                            builder: (_) => NewsDetailsPage(
                              newsItem: newsItem,
                            ),
                          ),
                        ),
                        child: RecommendationItem(newsItem: newsItem),
                      ),
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
