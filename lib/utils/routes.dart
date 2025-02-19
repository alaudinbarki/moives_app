import 'package:flutter/material.dart';
import 'package:movies_app/views/ui/bottom_bar/custom_bottom_bar.dart';
import 'package:movies_app/views/ui/home/genre_screen.dart';

class AppRoutes {
  static final _instance = AppRoutes._();
  static const home = '/home';
  static const genreScreen = '/genre';

  AppRoutes._();
  factory AppRoutes() => _instance;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const HomeMasterScreen());

      case genreScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const GenreScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
