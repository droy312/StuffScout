import 'package:flutter/material.dart';

class UserImageWidget extends StatelessWidget {
  const UserImageWidget({
    Key? key,
    this.imageUrl,
    this.size = 80,
  }) : super(key: key);

  final String? imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withOpacity(.4),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        border: Border.all(color: Theme.of(context).colorScheme.primary),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        child: imageUrl != null
            ? Image.network(
                imageUrl!,
                fit: BoxFit.cover,
              )
            : FittedBox(
                fit: BoxFit.contain,
                child: Icon(
                  Icons.person,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
      ),
    );
  }
}
