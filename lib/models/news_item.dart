class NewsItem {
  final int id;
  final String title;
  final String imageUrl;
  final String category;
  final String author;
  final String time;
  final bool isFavorite;

  const NewsItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.category,
    required this.author,
    this.time = '8 minutes ago',
    this.isFavorite = false,
  });

  NewsItem copyWith({
    int? id,
    String? title,
    String? imageUrl,
    String? category,
    String? author,
    bool? isFavorite,
  }) =>
      NewsItem(
        id: id ?? this.id,
        title: title ?? this.title,
        imageUrl: imageUrl ?? this.imageUrl,
        category: category ?? this.category,
        author: author ?? this.author,
        isFavorite: isFavorite ?? this.isFavorite,
      );

  @override
  bool operator ==(Object other) =>
      other is NewsItem &&
      other.id == id &&
      other.title == title &&
      other.imageUrl == imageUrl &&
      other.category == category &&
      other.author == author &&
      other.time == time &&
      other.isFavorite == isFavorite;

  @override
  int get hashCode => Object.hash(
        id,
        title,
        imageUrl,
        category,
        author,
        isFavorite,
      );
}

final news = [
  const NewsItem(
    id: 1,
    title: 'This is a freaking title here',
    imageUrl:
        'https://ichef.bbci.co.uk/news/976/cpsprodpb/5BA5/production/_129216432_womenafp.jpg.webp',
    category: 'Sports',
    author: 'CNN',
  ),
  const NewsItem(
    id: 2,
    title: 'This is a very good title here',
    imageUrl:
        'https://ichef.bbci.co.uk/news/976/cpsprodpb/0A7C/production/_129048620_photo19-02-2023113613.jpg.webp',
    category: 'Social',
    author: 'BBC',
  ),
  const NewsItem(
    id: 3,
    title: 'This is an amazing title here',
    imageUrl:
        'https://ichef.bbci.co.uk/news/976/cpsprodpb/CDCC/production/_129048625_photo01-01-2016002802.jpg.webp',
    category: 'Medical',
    author: 'Al-Jazeera',
  ),
  const NewsItem(
    id: 4,
    title: 'This is an excellent title here',
    imageUrl: 'https://ychef.files.bbci.co.uk/1600x900/p0fcgzcy.webp',
    category: 'Political',
    author: 'CNN',
  ),
];
