import 'package:flutter/material.dart';
import 'package:stuff_scout/core/nums.dart';

class MorePopupMenuButton extends PopupMenuButton {
  MorePopupMenuButton({
    Key? key,
    Function()? onMovePressed,
    Function()? onEditPressed,
    Function()? onDeletePressed,
    required BuildContext context,
    double size = Nums.iconSize,
    Color? iconColor,
  }) : super(
          key: key,
          icon: Icon(
            Icons.more_vert_rounded,
            color: iconColor ?? Theme.of(context).colorScheme.primary,
            size: size,
          ),
          onSelected: (value) {
            if (value != null) {
              switch (value) {
                case 'move':
                  if (onMovePressed != null) {
                    onMovePressed();
                  }
                  break;
                case 'edit':
                  if (onEditPressed != null) {
                    onEditPressed();
                  }
                  break;
                case 'delete':
                  if (onDeletePressed != null) {
                    onDeletePressed();
                  }
                  break;
              }
            }
          },
          itemBuilder: (context) {
            return [
              if (onMovePressed != null)
                const PopupMenuItem(
                  value: 'move',
                  child: Text('Move'),
                ),
              if (onEditPressed != null)
                const PopupMenuItem(
                  value: 'edit',
                  child: Text('Edit'),
                ),
              if (onDeletePressed != null)
                const PopupMenuItem(
                  value: 'delete',
                  child: Text('Delete'),
                ),
            ];
          },
        );
}
