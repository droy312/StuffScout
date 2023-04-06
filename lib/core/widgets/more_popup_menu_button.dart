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
          itemBuilder: (_) {
            return [
              if (onMovePressed != null)
                PopupMenuItem(
                  onTap: onMovePressed,
                  child: const Text('Move'),
                ),
              if (onEditPressed != null)
                PopupMenuItem(
                  onTap: onEditPressed,
                  child: const Text('Edit'),
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
