import 'package:flutter/material.dart';
import 'package:stuff_scout/core/widgets/container_item_card_widget.dart';
import 'package:stuff_scout/features/item/data/models/item_model.dart';
import 'package:stuff_scout/features/item/presenter/pages/item_page.dart';

import 'unsplash_ink_well.dart';

class ItemCardWidget extends StatelessWidget {
  const ItemCardWidget({
    Key? key,
    this.size = 40,
    required this.itemModel,
  }) : super(key: key);

  final double size;
  final ItemModel itemModel;

  @override
  Widget build(BuildContext context) {
    return UnsplashInkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          ItemPage.routeName,
          arguments: ItemPageArguments(itemModel: itemModel),
        );
      },
      child: ContainerItemCardWidget(
        label: itemModel.name,
        imageUrl: itemModel.imageUrl,
      ),
    );
  }
}
