import 'package:flutter/material.dart';

import '../../models/news_item.dart';
import 'news_details_app_bar.dart';
import 'news_details_body.dart';

class NewsDetailsPage extends StatelessWidget {
  final NewsItem newsItem;

  const NewsDetailsPage({super.key, required this.newsItem});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomScrollView(
              slivers: [
                NewsDetailsAppBar(
                  newsItem: newsItem,
                ),
                SliverToBoxAdapter(
                  child: NewsDetailsBody(
                    newsItem: newsItem,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: size.height * 0.32,
              width: size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                  colors: [
                    Colors.white,
                    Colors.white.withOpacity(0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
