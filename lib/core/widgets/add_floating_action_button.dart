import 'package:flutter/material.dart';

class AddFloatingActionButton extends FloatingActionButton {
  AddFloatingActionButton({
    Key? key,
    required BuildContext context,
    Function()? onPressed,
  }) : super(
          key: key,
          onPressed: onPressed,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Icon(Icons.add,
              color: Theme.of(context).colorScheme.onPrimaryContainer),
        );
}
