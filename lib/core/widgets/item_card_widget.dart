import 'package:flutter/material.dart';
import 'package:stuff_scout/core/widgets/room_container_item_card_widget.dart';
import 'package:stuff_scout/features/item/data/models/item_model.dart';
import 'package:stuff_scout/features/item/presenter/pages/item_page.dart';

import 'delete_alert_dialog.dart';
import 'unsplash_ink_well.dart';

class ItemCardWidget extends StatelessWidget {
  const ItemCardWidget({
    Key? key,
    this.size = 40,
    required this.itemModel,
    required this.onDeletePressed,
    required this.onEditPressed,
    required this.onMovePressed,
    required this.onNavigateBack,
  }) : super(key: key);

  final double size;
  final ItemModel itemModel;
  final Function() onDeletePressed;
  final Function() onEditPressed;
  final Function() onMovePressed;
  /// The function which will be called when the user goes back to house page
  /// or room page or container page from item page
  final Function() onNavigateBack;

  @override
  Widget build(BuildContext context) {
    return UnsplashInkWell(
      onTap: () async {
        await Navigator.pushNamed(
          context,
          ItemPage.routeName,
          arguments: ItemPageArguments(itemModel: itemModel),
        );

        onNavigateBack();
      },
      child: RoomContainerItemCardWidget(
        label: itemModel.name,
        imageUrl: itemModel.imageUrl,
        onDeletePressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return DeleteAlertDialog(
                context: context,
                label: 'Do you want to delete ${itemModel.name} Item?',
                onDeletePressed: () {
                  onDeletePressed();

                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                onCancelPressed: () {
                  Navigator.pop(context);
                },
              );
            },
          );
        },
        onEditPressed: onEditPressed,
        onMovePressed: onMovePressed,
      ),
    );
  }
}
