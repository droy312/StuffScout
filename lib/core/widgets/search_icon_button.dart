import 'package:flutter/material.dart';
import 'package:stuff_scout/core/nums.dart';

class SearchIconButton extends IconButton {
  SearchIconButton({
    Key? key,
    required BuildContext context,
    Function()? onPressed,
    double size = Nums.iconSize,
    Color? iconColor,
  }) : super(
    key: key,
    onPressed: onPressed,
    icon: Icon(
      Icons.search,
      color: iconColor ?? Theme.of(context).colorScheme.primary,
      size: Nums.iconSize,
    ),
  );
}
