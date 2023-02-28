import 'package:flutter/material.dart';
import 'package:stuff_scout/core/widgets/back_icon_button.dart';
import 'package:stuff_scout/core/widgets/edit_icon_button.dart';
import 'package:stuff_scout/core/widgets/search_icon_button.dart';

class BackSearchEditAppBar extends AppBar {
  BackSearchEditAppBar({
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
            EditIconButton(
              context: context,
              iconColor: Theme.of(context).colorScheme.onPrimary,
            ),
          ],
        );
}
