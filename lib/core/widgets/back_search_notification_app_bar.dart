import 'package:flutter/material.dart';
import 'package:stuff_scout/core/widgets/back_icon_button.dart';
import 'package:stuff_scout/core/widgets/notification_icon_button.dart';
import 'package:stuff_scout/core/widgets/search_icon_button.dart';

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
          leading: BackIconButton(
            context: context,
            iconColor: Theme.of(context).colorScheme.onPrimary,
          ),
          actions: [
            SearchIconButton(
              context: context,
              iconColor: Theme.of(context).colorScheme.onPrimary,
            ),
            NotificationIconButton(
              context: context,
              iconColor: Theme.of(context).colorScheme.onPrimary,
            ),
          ],
        );
}
