import 'dart:io';

import 'package:flutter/material.dart';

import '../pages/view_image_page.dart';

class HeaderTitleImageWidget extends StatelessWidget {
  const HeaderTitleImageWidget({
    Key? key,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);

  final String title;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
        ),
        if (imageUrl != null) ...[
          const SizedBox(width: 4),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                ViewImagePage.routeName,
                arguments: ViewImagePageArguments(
                    imageUrl: imageUrl!),
              );
            },
            child: Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                child: Image.file(
                  File(imageUrl!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
