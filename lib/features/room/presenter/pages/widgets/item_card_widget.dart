import 'package:flutter/material.dart';
import 'package:stuff_scout/features/room/presenter/pages/widgets/container_item_card_widget.dart';

import '../../../../../core/widgets/unsplash_ink_well.dart';

class ItemCardWidget extends StatelessWidget {
  const ItemCardWidget({
    Key? key,
    this.size = 40,
    required this.itemName,
    this.imageUrl,
  }) : super(key: key);

  final double size;
  final String itemName;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return UnsplashInkWell(
      onTap: () {},
      child: ContainerItemCardWidget(
        label: itemName,
        imageUrl: imageUrl,
      ),
    );
  }
}
