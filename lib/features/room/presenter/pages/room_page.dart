import 'package:flutter/material.dart';
import 'package:stuff_scout/core/widgets/room_container_page_widget.dart';

class RoomPage extends StatelessWidget {
  const RoomPage({Key? key}) : super(key: key);

  static const String routeName = '/room';

  @override
  Widget build(BuildContext context) {
    return const RoomContainerPageWidget(
      title: 'Room name 123',
      location: 'House name 321',
    );
  }
}
