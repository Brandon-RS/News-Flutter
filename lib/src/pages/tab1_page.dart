import 'package:flutter/material.dart';
import 'package:news_app/src/services/news_services.dart';
import 'package:news_app/src/widgets/news_list.dart';
import 'package:provider/provider.dart';

class Tab1Page extends StatefulWidget {
  const Tab1Page({Key? key}) : super(key: key);

  @override
  State<Tab1Page> createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final newsService = Provider.of<NewsServices>(context);

    return newsService.headLines.isEmpty
        ? const Center(child: CircularProgressIndicator(color: Colors.red))
        : NewsList(newsList: newsService.headLines);
  }

  @override
  bool get wantKeepAlive => true;
}
