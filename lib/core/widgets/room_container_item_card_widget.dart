import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stuff_scout/core/widgets/more_popup_menu_button.dart';

class RoomContainerItemCardWidget extends StatelessWidget {
  const RoomContainerItemCardWidget({
    Key? key,
    this.size = 40,
    required this.label,
    this.imageUrl,
    this.onDeletePressed,
    this.onEditPressed,
    this.onMovePressed,
  }) : super(key: key);

  final double size;
  final String label;
  final String? imageUrl;
  final Function()? onDeletePressed;
  final Function()? onEditPressed;
  final Function()? onMovePressed;

  static const double _borderRadius = 16;

  @override
  Widget build(BuildContext context) {
    final Color borderColor =
        Theme.of(context).colorScheme.onBackground.withOpacity(.2);

    return Container(
      height: size,
      width: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.all(Radius.circular(_borderRadius)),
        border: Border.all(color: borderColor),
      ),
      child: Stack(
        children: [
          if (imageUrl != null) ...[
            ClipRRect(
              borderRadius:
                  const BorderRadius.all(Radius.circular(_borderRadius * .95)),
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Image.file(
                  File(imageUrl!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
              ),
            ),
          ],
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            alignment: Alignment.center,
            child: Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: imageUrl != null
                      ? Colors.white
                      : Theme.of(context).colorScheme.onBackground),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: MorePopupMenuButton(
              context: context,
              onDeletePressed: onDeletePressed,
              onEditPressed: onEditPressed,
              onMovePressed: onMovePressed,
            ),
          ),
        ],
      ),
    );
  }
}
