import 'package:flutter/material.dart';
import 'package:stuff_scout/core/widgets/unsplash_ink_well.dart';

import 'custom_elevated_button.dart';

class MoveHereBottomSheet extends BottomSheet {
  MoveHereBottomSheet({
    Key? key,
    Function()? onMoveHerePressed,
    Function()? onCancelPressed,
  }) : super(
          key: key,
          onClosing: () {},
          builder: (context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  UnsplashInkWell(
                    onTap: onCancelPressed,
                    child: Container(
                      width: 44,
                      height: 44,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.error,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.clear_rounded,
                        size: 20,
                        color: Theme.of(context).colorScheme.onError,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomElevatedButton(
                      context: context,
                      backgroundColor: Theme.of(context).colorScheme.onPrimary,
                      onPressed: onMoveHerePressed,
                      child: Text(
                        'Move here',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
}
