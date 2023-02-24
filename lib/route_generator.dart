import 'package:flutter/material.dart';
import 'package:stuff_scout/features/container/presenter/pages/container_page.dart';
import 'package:stuff_scout/features/home/presenter/pages/add_house_page.dart';
import 'package:stuff_scout/features/home/presenter/pages/home_page.dart';
import 'package:stuff_scout/features/house/presenter/pages/house_page.dart';
import 'package:stuff_scout/features/item/presenter/pages/item_page.dart';
import 'package:stuff_scout/features/room/presenter/pages/room_page.dart';

class RouteGenerator {
  static Route generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.routeName:
        return MaterialPageRoute(builder: (_) => HomePage());
      case HousePage.routeName:
        return MaterialPageRoute(
            builder: (_) => HousePage(
                housePageArguments: settings.arguments as HousePageArguments));
      case RoomPage.routeName:
        return MaterialPageRoute(builder: (_) => const RoomPage());
      case ContainerPage.routeName:
        return MaterialPageRoute(builder: (_) => const ContainerPage());
      case ItemPage.routeName:
        return MaterialPageRoute(builder: (_) => const ItemPage());
      case AddHousePage.routeName:
        return MaterialPageRoute(
            builder: (_) => AddHousePage(
                addHousePageArguments:
                    settings.arguments as AddHousePageArguments));
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
                'No route with name: ${settings.name} and arguments: ${settings.arguments}')));
  }
}
