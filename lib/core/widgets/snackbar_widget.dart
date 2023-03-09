import 'package:flutter/material.dart';

class SnackBarWidget extends SnackBar {
  SnackBarWidget({
    Key? key,
    required BuildContext context,
    required String text,
    Widget? content,
    bool isError = false,
  }) : super(
          key: key,
          backgroundColor: isError
              ? Theme.of(context).colorScheme.error
              : Theme.of(context).colorScheme.secondary,
          content: content ??
              Text(
                text,
                style: TextStyle(
                  color: isError
                      ? Theme.of(context).colorScheme.onError
                      : Theme.of(context).colorScheme.onSecondary,
                ),
              ),
        );
}
