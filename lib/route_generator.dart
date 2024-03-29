import 'package:flutter/material.dart';
import 'package:stuff_scout/core/pages/add_item_page.dart';
import 'package:stuff_scout/core/pages/view_image_page.dart';
import 'package:stuff_scout/features/container/presenter/pages/container_page.dart';
import 'package:stuff_scout/features/home/presenter/pages/add_house_page.dart';
import 'package:stuff_scout/features/home/presenter/pages/home_page.dart';
import 'package:stuff_scout/features/house/presenter/pages/house_page.dart';
import 'package:stuff_scout/features/item/presenter/pages/item_page.dart';
import 'package:stuff_scout/core/pages/add_container_page.dart';
import 'package:stuff_scout/features/room/presenter/pages/room_page.dart';
import 'package:stuff_scout/features/search/presenter/pages/search_page.dart';

import 'features/house/presenter/pages/add_room_page.dart';

class RouteGenerator {
  static List<Route> generateInitialRoutes(String route) {
    return [MaterialPageRoute(builder: (_) => const HomePage())];
  }

  static Route generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.routeName:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case HousePage.routeName:
        return MaterialPageRoute(
            builder: (_) => HousePage(
                housePageArguments: settings.arguments as HousePageArguments));
      case RoomPage.routeName:
        return MaterialPageRoute(
            builder: (_) => RoomPage(
                roomPageArguments: settings.arguments as RoomPageArguments));
      case ContainerPage.routeName:
        return MaterialPageRoute(
            builder: (_) => ContainerPage(
                containerPageArguments:
                    settings.arguments as ContainerPageArguments));
      case ItemPage.routeName:
        return MaterialPageRoute(
            builder: (_) => ItemPage(
                itemPageArguments: settings.arguments as ItemPageArguments));
      case AddHousePage.routeName:
        return MaterialPageRoute(
            builder: (_) => AddHousePage(
                addHousePageArguments:
                    settings.arguments as AddHousePageArguments));
      case AddRoomPage.routeName:
        return MaterialPageRoute(
            builder: (_) => AddRoomPage(
                addRoomPageArguments:
                    settings.arguments as AddRoomPageArguments));
      case AddContainerPage.routeName:
        return MaterialPageRoute(
            builder: (_) => AddContainerPage(
                addContainerPageArguments:
                    settings.arguments as AddContainerPageArguments));
      case AddItemPage.routeName:
        return MaterialPageRoute(
            builder: (_) => AddItemPage(
                addItemPageArguments:
                    settings.arguments as AddItemPageArguments));
      case SearchPage.routeName:
        return MaterialPageRoute(
            builder: (_) => SearchPage(
                searchPageArguments:
                    settings.arguments as SearchPageArguments));
      case ViewImagePage.routeName:
        return MaterialPageRoute(
            builder: (_) => ViewImagePage(
                viewImagePageArguments: settings.arguments as ViewImagePageArguments));
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
