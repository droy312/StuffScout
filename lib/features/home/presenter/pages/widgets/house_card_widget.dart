import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stuff_scout/core/nums.dart';
import 'package:stuff_scout/core/widgets/unsplash_ink_well.dart';
import 'package:stuff_scout/features/house/domain/entities/house_entity.dart';
import 'package:stuff_scout/features/house/presenter/pages/house_page.dart';

class HouseCardWidget extends StatelessWidget {
  const HouseCardWidget({
    Key? key,
    required this.houseEntity,
  }) : super(key: key);

  static const String _testImageUrl =
      'https://images.pexels.com/photos/2102587/pexels-photo-2102587.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';

  static const double _imageContainerBorderRadius =
      Nums.textFieldElevatedButtonBorderRadius * .75;
  static const double _cardPadding = 12;

  final HouseEntity houseEntity;

  @override
  Widget build(BuildContext context) {
    final double imageContainerSize = min(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height) *
        .25;
    final double containerHeight = imageContainerSize + 2 * _cardPadding;

    return UnsplashInkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          HousePage.routeName,
          arguments: HousePageArguments(houseEntity: houseEntity),
        );
      },
      child: Container(
        height: containerHeight,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 4,
              color: Theme.of(context).colorScheme.shadow,
            ),
          ],
          borderRadius: const BorderRadius.all(
              Radius.circular(Nums.textFieldElevatedButtonBorderRadius)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(_cardPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: imageContainerSize,
                width: imageContainerSize,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(_imageContainerBorderRadius))),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                      Radius.circular(_imageContainerBorderRadius)),
                  child: Image.network(
                    _testImageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      houseEntity.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4),
                    if (houseEntity.description != null)
                      Expanded(
                        child: Text(
                          houseEntity.description!,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
