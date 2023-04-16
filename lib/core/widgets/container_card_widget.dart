import 'package:flutter/material.dart';
import 'package:stuff_scout/core/widgets/room_container_item_card_widget.dart';
import 'package:stuff_scout/features/container/data/models/container_model.dart';
import 'package:stuff_scout/features/container/presenter/pages/container_page.dart';

import 'delete_alert_dialog.dart';
import 'unsplash_ink_well.dart';

class ContainerCardWidget extends StatelessWidget {
  const ContainerCardWidget({
    Key? key,
    this.size = 40,
    required this.containerModel,
    required this.onDeletePressed,
    required this.onEditPressed,
    required this.onMovePressed,
    required this.onNavigateBack,
  }) : super(key: key);

  final double size;
  final ContainerModel containerModel;
  final Function() onDeletePressed;
  final Function() onEditPressed;
  final Function() onMovePressed;
  /// The function which will be called when the user goes back to room page
  /// or parent container page from container page
  final Function() onNavigateBack;

  @override
  Widget build(BuildContext context) {
    return UnsplashInkWell(
      onTap: () async {
        await Navigator.pushNamed(
          context,
          ContainerPage.routeName,
          arguments: ContainerPageArguments(containerModel: containerModel),
        );

        onNavigateBack();
      },
      child: RoomContainerItemCardWidget(
        label: containerModel.name,
        imageUrl: containerModel.imageUrl,
        onDeletePressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return DeleteAlertDialog(
                context: context,
                label: 'Do you want to delete ${containerModel.name} Container?',
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
