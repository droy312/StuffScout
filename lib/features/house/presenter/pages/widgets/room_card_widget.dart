import 'package:flutter/material.dart';
import 'package:stuff_scout/core/widgets/room_container_item_card_widget.dart';

import '../../../../../core/widgets/delete_alert_dialog.dart';
import '../../../../room/data/models/room_model.dart';
import '../../../../room/presenter/pages/room_page.dart';
import '../../../../../core/widgets/unsplash_ink_well.dart';

class RoomCardWidget extends StatelessWidget {
  const RoomCardWidget({
    Key? key,
    this.size = 40,
    required this.roomModel,
    required this.onDeletePressed,
    required this.onEditPressed,
    required this.onMovePressed,
    required this.onNavigateBack,
  }) : super(key: key);

  final double size;
  final RoomModel roomModel;
  final Function() onDeletePressed;
  final Function() onEditPressed;
  final Function() onMovePressed;
  /// The function which will be called when the user goes back to house page
  /// from room page
  final Function() onNavigateBack;

  @override
  Widget build(BuildContext context) {
    return UnsplashInkWell(
      onTap: () async {
        await Navigator.pushNamed(
          context,
          RoomPage.routeName,
          arguments: RoomPageArguments(roomModel: roomModel),
        );

        onNavigateBack();
      },
      child: RoomContainerItemCardWidget(
        label: roomModel.name,
        imageUrl: roomModel.imageUrl,
        onDeletePressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return DeleteAlertDialog(
                context: context,
                label: 'Do you want to delete ${roomModel.name} Room?',
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
