import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/models/news_models.dart';
import 'package:news_app/src/pages/screens.dart';
import 'package:news_app/src/widgets/news_list.dart';

class NewsDetailPage extends StatelessWidget {
  const NewsDetailPage({Key? key, required this.news}) : super(key: key);

  final Article news;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: padding.top + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _NewsTitle(news: news),
              _SomeData(news: news.source.name, helper: 'Source'),
              _NewImage(news: news),
              _SomeData(news: '${news.publishedAt}', helper: 'Date'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                child: Text(news.description, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w300)),
              ),
              const SizedBox(height: 10),
              const CardButtons(),
              const SizedBox(height: 10),
              _SomeData(news: news.content ?? 'No content.', helper: 'Content'),
            ],
          ),
        ),
      ),
    );
  }
}

class _NewsTitle extends StatelessWidget {
  const _NewsTitle({Key? key, required this.news}) : super(key: key);

  final Article news;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 24),
        children: [
          WidgetSpan(
            child: IconButton(
              padding: const EdgeInsets.only(bottom: 3, right: 12),
              constraints: const BoxConstraints(),
              icon: const Icon(Icons.arrow_back, size: 27),
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: () => Navigator.pop(context),
            ),
          ),
          TextSpan(text: '${news.title}.'),
          TextSpan(
            text: '   See all',
            style: const TextStyle(fontSize: 16, color: Colors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => WebViewPage(url: news.url)));
              },
          ),
        ],
      ),
    );
  }
}

class _SomeData extends StatelessWidget {
  const _SomeData({Key? key, required this.news, required this.helper}) : super(key: key);

  final String news;
  final String helper;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text('$helper: $news'),
    );
  }
}

class _NewImage extends StatelessWidget {
  const _NewImage({Key? key, required this.news}) : super(key: key);

  final Article news;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.only(top: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: FadeInImage(
        height: 300,
        fit: BoxFit.cover,
        placeholder: const AssetImage('assets/giphy.gif'),
        image: NetworkImage(
          news.urlToImage ?? 'https://res.cloudinary.com/brandon-rs/image/upload/v1643560194/no-image_suebjt.jpg',
        ),
      ),
    );
  }
}
