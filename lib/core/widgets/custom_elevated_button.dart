import 'package:flutter/material.dart';
import 'package:stuff_scout/core/nums.dart';

class CustomElevatedButton extends ElevatedButton {
  CustomElevatedButton({
    Key? key,
    required BuildContext context,
    Function()? onPressed,
    Widget? child,
    Color? backgroundColor,
  }) : super(
          key: key,
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                backgroundColor ?? Theme.of(context).colorScheme.primary,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(Nums.textFieldElevatedButtonBorderRadius))),
          ),
          child: child,
        );
}
