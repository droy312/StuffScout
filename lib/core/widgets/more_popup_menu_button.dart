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
            if (value != null && value == 1) {
              if (onEditPressed != null) {
                print('This is working');
                onEditPressed();
              }
            }
          },
          itemBuilder: (context) {
            return [
              if (onMovePressed != null)
                PopupMenuItem(
                  onTap: onMovePressed,
                  child: const Text('Move'),
                ),
              if (onEditPressed != null)
                const PopupMenuItem(
                  value: 1,
                  child: Text('Edit'),
                ),
              if (onDeletePressed != null)
                PopupMenuItem(
                  onTap: onDeletePressed,
                  child: const Text('Delete'),
                ),
            ];
          },
        );
}
