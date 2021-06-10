import 'package:flutter/material.dart';
import 'package:navigator2/screen/home.dart';
import 'package:navigator2/screen/mypage.dart';
import 'package:navigator2/screen/settings.dart';
import 'package:navigator2/screen/unknown.dart';
import 'package:routemaster/routemaster.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  //urlの#を消す
  setPathUrlStrategy();
  runApp(MyApp());
}

final routes = RouteMap(
  onUnknownRoute: (_) {
    return MaterialPage(child: UnknownScreen());
  },
  routes: {
    '/': (_) => MaterialPage(
          child: HomeScreen(),
        ),
    '/mypage': (_) => MaterialPage(child: MypageScreen()),
    '/mypage/settings': (_) => MaterialPage(child: SettingsScreen()),
    '/settings': (_) => MaterialPage(child: SettingsScreen()),
  },
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Nav2',
      routerDelegate: RoutemasterDelegate(routesBuilder: (_) => routes),
      routeInformationParser: RoutemasterParser(),
    );
  }
}
