import 'package:flutter/material.dart';
import 'package:stuff_scout/core/widgets/room_container_item_card_widget.dart';
import 'package:stuff_scout/features/container/data/models/container_model.dart';
import 'package:stuff_scout/features/container/presenter/pages/container_page.dart';

import 'unsplash_ink_well.dart';

class ContainerCardWidget extends StatelessWidget {
  const ContainerCardWidget({
    Key? key,
    this.size = 40,
    required this.containerModel,
  }) : super(key: key);

  final double size;
  final ContainerModel containerModel;

  @override
  Widget build(BuildContext context) {
    return UnsplashInkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          ContainerPage.routeName,
          arguments: ContainerPageArguments(containerModel: containerModel),
        );
      },
      child: RoomContainerItemCardWidget(
        label: containerModel.name,
        imageUrl: containerModel.imageUrl,
      ),
    );
  }
}
