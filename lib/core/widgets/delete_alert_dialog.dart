import 'package:flutter/material.dart';
import 'package:stuff_scout/core/nums.dart';

import '../../../../../core/widgets/custom_elevated_button.dart';

class DeleteAlertDialog extends AlertDialog {
  DeleteAlertDialog({
    Key? key,
    required BuildContext context,
    required String label,
    Function()? onDeletePressed,
    Function()? onCancelPressed,
  }) : super(
          key: key,
          elevation: 4,
          shadowColor: Theme.of(context).colorScheme.shadow,
          backgroundColor: Theme.of(context).colorScheme.background,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          content: SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: onCancelPressed,
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(
                                    Nums.textFieldElevatedButtonBorderRadius)),
                            side: BorderSide(
                              width: 1,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground
                                  .withOpacity(.2),
                            ),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onBackground),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomElevatedButton(
                        context: context,
                        onPressed: onDeletePressed,
                        child: Text(
                          'Delete',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
}
