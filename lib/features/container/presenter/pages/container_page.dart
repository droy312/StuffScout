import 'package:flutter/material.dart';
import 'package:stuff_scout/core/widgets/room_container_page_widget.dart';
import 'package:stuff_scout/features/container/domain/entities/container_entity.dart';

class ContainerPageArguments {
  const ContainerPageArguments({required this.containerEntity});

  final ContainerEntity containerEntity;
}

class ContainerPage extends StatelessWidget {
  const ContainerPage({
    Key? key,
    required this.containerPageArguments,
  }) : super(key: key);

  static const String routeName = '/container';

  final ContainerPageArguments containerPageArguments;

  @override
  Widget build(BuildContext context) {
    return RoomContainerPageWidget(
      title: containerPageArguments.containerEntity.name,
      locationModel: containerPageArguments.containerEntity.locationModel,
    );
  }
}
