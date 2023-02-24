import 'package:flutter/material.dart';
import 'package:stuff_scout/core/nums.dart';

class BackIconButton extends IconButton {
  BackIconButton({
    Key? key,
    required BuildContext context,
    double size = Nums.iconSize,
    Color? iconColor,
  }) : super(
    key: key,
    onPressed: () {
      Navigator.pop(context);
    },
    icon: Icon(
      Icons.arrow_back_ios_new_rounded,
      color: iconColor ?? Theme.of(context).colorScheme.primary,
      size: size,
    ),
  );
}
