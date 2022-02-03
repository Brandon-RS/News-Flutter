import 'dart:io';

import 'package:flutter/material.dart';
import 'package:news_app/src/pages/screens.dart';
import 'package:news_app/src/services/news_services.dart';
import 'package:news_app/src/theme/theme.dart';
import 'package:provider/provider.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsServices()),
      ],
      child: MaterialApp(
        title: 'News App',
        theme: customTheme,
        initialRoute: Tabspage.routeName,
        routes: {
          Tabspage.routeName: (_) => const Tabspage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
