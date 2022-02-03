import 'package:flutter/material.dart';
import 'package:news_app/src/models/news_models.dart';
import 'package:news_app/src/pages/news_detail_page.dart';

class NewsList extends StatelessWidget {
  const NewsList({Key? key, required this.newsList}) : super(key: key);

  final List<Article> newsList;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return ListView.builder(
      padding: EdgeInsets.only(left: 15, right: 15, top: padding.top + 10, bottom: 10),
      itemCount: newsList.length,
      itemBuilder: (_, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => NewsDetailPage(news: newsList[index])));
          },
          child: _New(index: index, news: newsList[index]),
        );
      },
    );
  }
}

class _New extends StatelessWidget {
  const _New({Key? key, required this.index, required this.news}) : super(key: key);

  final int index;
  final Article news;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TopBarCard(index: index, news: news),
        _CardTitle(news: news),
        _CardImage(news: news),
        _CardBody(news: news),
        const CardButtons(),
        const SizedBox(height: 5),
        const Divider(color: Colors.white),
      ],
    );
  }
}

class _TopBarCard extends StatelessWidget {
  const _TopBarCard({Key? key, required this.index, required this.news}) : super(key: key);

  final int index;
  final Article news;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text('${index + 1}. ', style: const TextStyle(color: Colors.red)),
          Text('${news.source.name}.'),
        ],
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  const _CardTitle({Key? key, required this.news}) : super(key: key);

  final Article news;

  @override
  Widget build(BuildContext context) {
    return Text(news.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700));
  }
}

class _CardImage extends StatelessWidget {
  const _CardImage({Key? key, required this.news}) : super(key: key);

  final Article news;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: FadeInImage(
        placeholder: const AssetImage('assets/giphy.gif'),
        image: NetworkImage(
          news.urlToImage ?? 'https://res.cloudinary.com/brandon-rs/image/upload/v1643560194/no-image_suebjt.jpg',
        ),
      ),
    );
  }
}

class _CardBody extends StatelessWidget {
  const _CardBody({Key? key, required this.news}) : super(key: key);

  final Article news;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(news.description),
    );
  }
}

class CardButtons extends StatelessWidget {
  const CardButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RawMaterialButton(
          onPressed: () {},
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          fillColor: Colors.red,
          child: const Icon(Icons.arrow_forward),
        ),
        const SizedBox(width: 10),
        RawMaterialButton(
          onPressed: () {},
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          fillColor: Colors.blue,
          child: const Icon(Icons.arrow_back),
        ),
      ],
    );
  }
}
