import 'package:flutter/material.dart';

import 'custom_elevated_button.dart';

class AddContainerItemAlertDialog extends AlertDialog {
  AddContainerItemAlertDialog({
    Key? key,
    required BuildContext context,
    Function()? onContainerPressed,
    Function()? onItemPressed,
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
                  'Add',
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        context: context,
                        onPressed: onContainerPressed,
                        child: Text(
                          'Container',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomElevatedButton(
                        context: context,
                        onPressed: onItemPressed,
                        child: Text(
                          'Item',
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
