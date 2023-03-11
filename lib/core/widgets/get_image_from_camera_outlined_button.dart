import 'package:flutter/material.dart';
import 'package:stuff_scout/core/nums.dart';

class GetImageFromCameraOutlinedButton extends OutlinedButton {
  GetImageFromCameraOutlinedButton({
    Key? key,
    required BuildContext context,
    Function()? onPressed,
  }) : super(
          key: key,
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 12),
            side: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 1,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(Nums.textFieldElevatedButtonBorderRadius)),
            ),
          ),
          child: Center(
            child: Icon(
              Icons.add_a_photo_outlined,
              color: Theme.of(context).colorScheme.primary,
              size: 20,
            ),
          ),
        );
}
