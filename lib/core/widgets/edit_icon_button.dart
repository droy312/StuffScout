import 'package:flutter/material.dart';
import 'package:stuff_scout/core/nums.dart';

class EditIconButton extends IconButton {
  EditIconButton({
    Key? key,
    required BuildContext context,
    Function()? onPressed,
    double size = Nums.iconSize,
    Color? iconColor,
  }) : super(
    key: key,
    onPressed: onPressed,
    icon: Icon(
      Icons.edit,
      color: iconColor ?? Theme.of(context).colorScheme.primary,
      size: Nums.iconSize,
    ),
  );
}
