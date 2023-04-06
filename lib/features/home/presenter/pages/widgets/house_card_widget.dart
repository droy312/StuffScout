import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stuff_scout/core/nums.dart';
import 'package:stuff_scout/core/widgets/unsplash_ink_well.dart';
import 'package:stuff_scout/features/house/presenter/pages/house_page.dart';

import '../../../../house/data/models/house_model.dart';

class HouseCardWidget extends StatelessWidget {
  const HouseCardWidget({
    Key? key,
    required this.houseModel,
  }) : super(key: key);

  static const double _imageContainerBorderRadius =
      Nums.textFieldElevatedButtonBorderRadius * .75;
  static const double _cardPadding = 12;

  final HouseModel houseModel;

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
          arguments: HousePageArguments(houseModel: houseModel),
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
                decoration: BoxDecoration(
                  color: houseModel.imageUrl == null
                      ? Theme.of(context).colorScheme.secondaryContainer
                      : null,
                  borderRadius: const BorderRadius.all(
                      Radius.circular(_imageContainerBorderRadius)),
                ),
                child: houseModel.imageUrl != null
                    ? ClipRRect(
                        borderRadius: const BorderRadius.all(
                            Radius.circular(_imageContainerBorderRadius)),
                        child: Image.file(
                          File(houseModel.imageUrl!),
                          fit: BoxFit.cover,
                        ),
                      )
                    : Center(
                        child: Text(
                          houseModel.name[0].toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondaryContainer),
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
                      houseModel.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4),
                    if (houseModel.description != null)
                      Expanded(
                        child: Text(
                          houseModel.description!,
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
