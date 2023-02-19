import 'package:flutter/material.dart';
import 'package:stuff_scout/core/nums.dart';

class NotificationIconButton extends IconButton {
  NotificationIconButton({
    Key? key,
    Function()? onPressed,
    required BuildContext context,
    double size = Nums.iconSize,
  }) : super(
          key: key,
          onPressed: onPressed,
          icon: Icon(
            Icons.notifications_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: size,
          ),
        );
}
