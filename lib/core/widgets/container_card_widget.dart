import 'package:flutter/material.dart';
import 'package:stuff_scout/core/widgets/container_item_card_widget.dart';
import 'package:stuff_scout/features/container/domain/entities/container_entity.dart';
import 'package:stuff_scout/features/container/presenter/pages/container_page.dart';

import 'unsplash_ink_well.dart';

class ContainerCardWidget extends StatelessWidget {
  const ContainerCardWidget({
    Key? key,
    this.size = 40,
    required this.containerEntity,
    this.imageUrl,
  }) : super(key: key);

  final double size;
  final ContainerEntity containerEntity;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return UnsplashInkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          ContainerPage.routeName,
          arguments: ContainerPageArguments(containerEntity: containerEntity),
        );
      },
      child: ContainerItemCardWidget(
        label: containerEntity.name,
        imageUrl: imageUrl,
      ),
    );
  }
}
