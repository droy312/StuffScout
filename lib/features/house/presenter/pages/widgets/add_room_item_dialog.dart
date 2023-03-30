import 'package:flutter/material.dart';

import '../../../../../core/widgets/custom_elevated_button.dart';

class AddRoomItemAlertDialog extends AlertDialog {
  AddRoomItemAlertDialog({
    Key? key,
    required BuildContext context,
    Function()? onRoomPressed,
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
                  onPressed: onRoomPressed,
                  child: Text(
                    'Room',
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
