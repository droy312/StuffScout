import 'package:flutter/material.dart';
import 'package:stuff_scout/features/home/presenter/pages/home.dart';

class RouteGenerator {
  static Route generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.routeName:
        return MaterialPageRoute(builder: (_) => const HomePage());
      default:
        return MaterialPageRoute(
            builder: (_) => _NoRoutePage(settings: settings));
    }
  }
}

class _NoRoutePage extends StatelessWidget {
  const _NoRoutePage({
    Key? key,
    required this.settings,
  }) : super(key: key);

  final RouteSettings settings;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Text(
                'No route with name: ${settings.name} and arguments: ${settings
                    .arguments}')));
  }
}

