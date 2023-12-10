import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:news_app/models/news_item.dart';

class NewsDetailsBody extends StatelessWidget {
  final NewsItem newsItem;
  const NewsDetailsBody({super.key, required this.newsItem});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(newsItem.imageUrl),
              ),
              const SizedBox(width: 8),
              Text(
                newsItem.author,
                style: textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            lorem(paragraphs: 8, words: 800),
            style: textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
