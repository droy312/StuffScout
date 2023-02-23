import 'package:flutter/material.dart';

class ContainerItemCardWidget extends StatelessWidget {
  const ContainerItemCardWidget({
    Key? key,
    this.size = 40,
    required this.label,
    this.imageUrl,
  }) : super(key: key);

  final double size;
  final String label;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final Color borderColor =
        Theme.of(context).colorScheme.onBackground.withOpacity(.2);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      height: size,
      width: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        border: Border.all(color: borderColor),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
    );
  }
}
