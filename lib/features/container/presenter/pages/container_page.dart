import 'package:flutter/material.dart';
import 'package:stuff_scout/core/widgets/room_container_page_widget.dart';

class ContainerPage extends StatelessWidget {
  const ContainerPage({Key? key}) : super(key: key);

  static const String routeName = '/container';

  @override
  Widget build(BuildContext context) {
    return const RoomContainerPageWidget(
      title: 'Container name 123',
      location: 'House name 321 > Room name 123',
    );
  }
}
