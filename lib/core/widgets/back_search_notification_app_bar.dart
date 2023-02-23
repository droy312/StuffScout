import 'package:flutter/material.dart';

import '../nums.dart';

class BackSearchNotificationAppBar extends AppBar {
  BackSearchNotificationAppBar({
    Key? key,
    required BuildContext context,
  }) : super(
          key: key,
          elevation: 0,
          scrolledUnderElevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: Theme.of(context).colorScheme.primary,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Theme.of(context).colorScheme.onPrimary,
              size: Nums.iconSize,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Theme.of(context).colorScheme.onPrimary,
                size: Nums.iconSize,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
                color: Theme.of(context).colorScheme.onPrimary,
                size: Nums.iconSize,
              ),
            ),
          ],
        );
}
