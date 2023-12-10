import 'package:flutter/material.dart';

import '../../models/news_item.dart';
import 'app_bar_icon.dart';

class NewsDetailsAppBar extends StatefulWidget {
  final NewsItem newsItem;

  const NewsDetailsAppBar({super.key, required this.newsItem});

  @override
  State<NewsDetailsAppBar> createState() => _NewsDetailsAppBarState();
}

class _NewsDetailsAppBarState extends State<NewsDetailsAppBar> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();

    isFavorite = widget.newsItem.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return SliverAppBar(
      expandedHeight: size.height * 0.4,
      leading: const Padding(
        padding: EdgeInsets.only(left: 8),
        child: AppBarIcon(
          icon: Icons.chevron_left,
          iconSize: 32,
        ),
      ),
      leadingWidth: 56,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      actions: [
        AppBarIcon(
          icon: isFavorite ? Icons.bookmark : Icons.bookmark_border_outlined,
          onTap: () {
            final index = news.indexOf(
              news.firstWhere((newsItem) => newsItem.id == widget.newsItem.id),
            );

            setState(() {
              news[index] = widget.newsItem.copyWith(
                isFavorite: !widget.newsItem.isFavorite,
              );

              isFavorite = !isFavorite;
            });
          },
        ),
        const SizedBox(width: 8),
        const AppBarIcon(icon: Icons.more_vert),
        const SizedBox(width: 8),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                widget.newsItem.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 56,
              left: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        widget.newsItem.category,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: size.width * 0.96,
                    child: Text(
                      widget.newsItem.title,
                      style: theme.textTheme.headlineSmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${widget.newsItem.author} • ${widget.newsItem.time}',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        stretchModes: const [
          StretchMode.blurBackground,
          StretchMode.zoomBackground,
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(
          height: 32,
          width: size.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(40),
            ),
          ),
        ),
      ),
      pinned: true,
    );
  }
}
