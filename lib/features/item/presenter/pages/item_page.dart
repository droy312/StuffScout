import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stuff_scout/core/widgets/back_icon_button.dart';
import 'package:stuff_scout/core/widgets/more_popup_menu_button.dart';
import 'package:stuff_scout/features/item/data/models/item_model.dart';

import '../../../../core/nums.dart';

class ItemPageArguments {
  const ItemPageArguments({required this.itemModel});

  final ItemModel itemModel;
}

class ItemPage extends StatelessWidget {
  const ItemPage({
    Key? key,
    required this.itemPageArguments,
  }) : super(key: key);

  static const String routeName = '/item';

  final ItemPageArguments itemPageArguments;

  static const double _imageContainerBorderRadius = 16;

  @override
  Widget build(BuildContext context) {
    final double imageContainerHeight =
        MediaQuery.of(context).size.width - (2 * Nums.horizontalPaddingWidth);

    return Scaffold(
      appBar: AppBar(
        leading: BackIconButton(context: context),
        actions: [
          MorePopupMenuButton(
            context: context,
            onMovePressed: () {},
            onEditPressed: () {},
            onDeletePressed: () {},
          )
        ],
        title: Text(
          itemPageArguments.itemModel.name,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Nums.horizontalPaddingWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Item image
              if (itemPageArguments.itemModel.imageUrl != null) ...[
                Container(
                  height: imageContainerHeight,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                        Radius.circular(_imageContainerBorderRadius)),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                        Radius.circular(_imageContainerBorderRadius)),
                    child: Center(
                      child: Image.file(
                        File(itemPageArguments.itemModel.imageUrl!),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Item location
              Text(
                'Location',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(.6)),
              ),
              const SizedBox(height: 4),
              Text(
                itemPageArguments.itemModel.locationModel.toLocationString(),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              const SizedBox(height: 16),

              // Item description
              if (itemPageArguments.itemModel.description != null) ...[
                Text(
                  'Description',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(.6)),
                ),
                const SizedBox(height: 4),
                Text(
                  itemPageArguments.itemModel.description!,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                const SizedBox(height: 16),
              ],

              // Item brand
              if (itemPageArguments.itemModel.brand != null) ...[
                Text(
                  'Brand',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(.6)),
                ),
                const SizedBox(height: 4),
                Text(
                  itemPageArguments.itemModel.brand!,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                const SizedBox(height: 16),
              ],

              // Item model
              if (itemPageArguments.itemModel.model != null) ...[
                Text(
                  'Model',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(.6)),
                ),
                const SizedBox(height: 4),
                Text(
                  itemPageArguments.itemModel.model!,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                const SizedBox(height: 16),
              ],

              // Item serialNumber
              if (itemPageArguments.itemModel.serialNumber != null) ...[
                Text(
                  'Serial Number',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(.6)),
                ),
                const SizedBox(height: 4),
                Text(
                  itemPageArguments.itemModel.serialNumber!,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                const SizedBox(height: 16),
              ],

              // Item serialNumber
              if (itemPageArguments.itemModel.quantity != null) ...[
                Text(
                  'Quantity',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(.6)),
                ),
                const SizedBox(height: 4),
                Text(
                  itemPageArguments.itemModel.quantity!.toString(),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                const SizedBox(height: 16),
              ],

              // Item serialNumber
              if (itemPageArguments.itemModel.pricePerItem != null) ...[
                Text(
                  'Price Per Item',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(.6)),
                ),
                const SizedBox(height: 4),
                Text(
                  itemPageArguments.itemModel.pricePerItem!.toString(),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                const SizedBox(height: 16),
              ],

              // Item serialNumber
              if (itemPageArguments.itemModel.serialNumber != null) ...[
                Text(
                  'Serial Number',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(.6)),
                ),
                const SizedBox(height: 4),
                Text(
                  itemPageArguments.itemModel.serialNumber!,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                const SizedBox(height: 16),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
