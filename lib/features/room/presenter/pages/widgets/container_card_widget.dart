import 'package:flutter/material.dart';
import 'package:stuff_scout/features/room/presenter/pages/widgets/container_item_card_widget.dart';

import '../../../../../core/widgets/unsplash_ink_well.dart';

class ContainerCardWidget extends StatelessWidget {
  const ContainerCardWidget({
    Key? key,
    this.size = 40,
    required this.containerName,
    this.imageUrl,
  }) : super(key: key);

  final double size;
  final String containerName;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return UnsplashInkWell(
      onTap: () {},
      child: ContainerItemCardWidget(
        label: containerName,
        imageUrl: imageUrl,
      ),
    );
  }
}
