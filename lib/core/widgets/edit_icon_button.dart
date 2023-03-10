import 'package:flutter/material.dart';
import 'package:stuff_scout/core/nums.dart';

class MoreIconButton extends IconButton {
  MoreIconButton({
    Key? key,
    Function()? onPressed,
    required BuildContext context,
    double size = Nums.iconSize,
    Color? iconColor,
  }) : super(
    key: key,
    onPressed: onPressed,
    icon: Icon(
      Icons.more_vert_rounded,
      color: iconColor ?? Theme.of(context).colorScheme.primary,
      size: size,
    ),
  );
}
