import 'package:flutter/material.dart';
import 'package:stuff_scout/core/widgets/room_container_page_widget.dart';
import 'package:stuff_scout/features/room/domain/entities/room_entity.dart';

class RoomPageArguments {
  const RoomPageArguments({required this.roomEntity});

  final RoomEntity roomEntity;
}

class RoomPage extends StatelessWidget {
  const RoomPage({
    Key? key,
    required this.roomPageArguments,
  }) : super(key: key);

  static const String routeName = '/room';

  final RoomPageArguments roomPageArguments;

  @override
  Widget build(BuildContext context) {
    return RoomContainerPageWidget(
      title: roomPageArguments.roomEntity.name,
      locationModel: roomPageArguments.roomEntity.locationModel,
    );
  }
}
