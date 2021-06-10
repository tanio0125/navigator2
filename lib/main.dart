import 'package:flutter/material.dart';
import 'package:navigator2/screen/home.dart';
import 'package:navigator2/screen/mypage.dart';
import 'package:navigator2/screen/settings.dart';
import 'package:navigator2/screen/unknown.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  //urlの#を消す
  setPathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _routeInformationParser = AppRouteInformationParser();
    final _routerDelegate = AppRouterDelegate();
    return MaterialApp.router(
      title: 'Nav2',
      routeInformationParser: _routeInformationParser,
      routerDelegate: _routerDelegate,
    );
  }
}

class AppRouteInformationParser extends RouteInformationParser<AppRouteState> {
  //RouteInformationをAppRouteStateに変換
  @override
  Future<AppRouteState> parseRouteInformation(
      RouteInformation routeInformation) async {
    final location = routeInformation.location;
    Uri? uri;

    if (location != null) {
      uri = Uri.parse(location);
      print(uri);
    }

    var state = AppRouteState();

    if (uri != null) {
      for (final path in uri.pathSegments) {
        switch (path) {
          case 'mypage':
            state = state.copyWith(isMypage: true);
            break;
          case 'settings':
            state = state.copyWith(isSettings: true);
            break;
          default:
            state = state.copyWith(isUnknown: true);
            break;
        }
      }
    }
    return state;
  }

  //AppRouteStateをRouteInformationに変換
  @override
  RouteInformation restoreRouteInformation(AppRouteState state) {
    var location = '';
    if (state.isMypage) {
      location += '/mypage';
    }
    if (state.isSettings) {
      location += '/settings';
    }
    if (state.isUnknown) {
      location += '/404';
    }
    return RouteInformation(location: location);
  }
}

class AppRouterDelegate extends RouterDelegate<AppRouteState>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRouteState> {
  final GlobalKey<NavigatorState> navigatorKey;

  //この状態は別で切り離してもいい
  bool isMypage = false;
  bool isSettings = false;
  bool isUnknown = false;

  AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  //RouteInformation復元用
  AppRouteState get currentConfiguration {
    var state = AppRouteState();
    if (isMypage) {
      state = state.copyWith(isMypage: true);
    }
    if (isSettings) {
      state = state.copyWith(isSettings: true);
    }
    if (isUnknown) {
      state = state.copyWith(isUnknown: true);
    }
    return state;
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          key: ValueKey('Home'),
          child: HomeScreen(
            onMypagePressed: () {
              isMypage = true;
              notifyListeners();
            },
            onSettingsPressed: () {
              isSettings = true;
              notifyListeners();
            },
          ),
        ),
        if (isMypage)
          MaterialPage(
            key: ValueKey('Mypage'),
            child: MypageScreen(),
          ),
        if (isSettings)
          MaterialPage(
            key: ValueKey('Settings'),
            child: SettingsScreen(),
          ),
        if (isUnknown)
          MaterialPage(
            key: ValueKey('404'),
            child: UnknownScreen(),
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        // TODO: 一番上にスタック順に戻る必要あり？
        isMypage = false;
        isSettings = false;
        isUnknown = false;

        notifyListeners();
        return true;
      },
    );
  }

  //ParseRouteInformationで変換されたら呼び出される
  @override
  Future<void> setNewRoutePath(AppRouteState appRouteState) async {
    isMypage = appRouteState.isMypage;
    isSettings = appRouteState.isSettings;
    isUnknown = appRouteState.isUnknown;
    notifyListeners();
  }
}

// Routeの状態モデル
class AppRouteState {
  final bool isMypage;
  final bool isSettings;
  final bool isUnknown;

  AppRouteState({
    this.isMypage = false,
    this.isSettings = false,
    this.isUnknown = false,
  });

  AppRouteState copyWith({
    bool? isMypage,
    bool? isSettings,
    bool? isUnknown,
  }) {
    return AppRouteState(
      isMypage: isMypage ?? this.isMypage,
      isSettings: isSettings ?? this.isSettings,
      isUnknown: isUnknown ?? this.isUnknown,
    );
  }
}
