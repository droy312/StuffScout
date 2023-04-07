import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuff_scout/core/enums/storage_enums.dart';
import 'package:stuff_scout/core/widgets/back_icon_button.dart';
import 'package:stuff_scout/core/widgets/more_popup_menu_button.dart';
import 'package:stuff_scout/features/item/data/models/item_model.dart';
import 'package:stuff_scout/features/item/presenter/cubits/item_cubit.dart';

import '../../../../core/nums.dart';

class ItemPageArguments {
  const ItemPageArguments({
    required this.itemModel,
    required this.itemStorage,
  });

  final ItemModel itemModel;
  final ItemStorage itemStorage;
}

class ItemPage extends StatefulWidget {
  const ItemPage({
    Key? key,
    required this.itemPageArguments,
  }) : super(key: key);

  static const String routeName = '/item';

  final ItemPageArguments itemPageArguments;

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  static const double _imageContainerBorderRadius = 16;

  late final ItemCubit _itemCubit;

  @override
  void initState() {
    super.initState();

    _itemCubit = ItemCubit(
      context: context,
      itemModel: widget.itemPageArguments.itemModel,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double imageContainerHeight =
        MediaQuery.of(context).size.width - (2 * Nums.horizontalPaddingWidth);

    return BlocProvider<ItemCubit>.value(
      value: _itemCubit,
      child: BlocBuilder<ItemCubit, ItemState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: BackIconButton(context: context),
              actions: [
                MorePopupMenuButton(
                  context: context,
                  onMovePressed: () {},
                  onEditPressed: () {},
                  onDeletePressed: () {
                    context.read<ItemCubit>().deleteItem(widget.itemPageArguments.itemStorage);
                  },
                )
              ],
              title: Text(
                state.itemModel.name,
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
                    if (state.itemModel.imageUrl != null) ...[
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
                              File(state.itemModel.imageUrl!),
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
                      state.itemModel.locationModel.toLocationString(),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    const SizedBox(height: 16),

                    // Item description
                    if (state.itemModel.description != null) ...[
                      Text(
                        'Description',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground
                                    .withOpacity(.6)),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        state.itemModel.description!,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Item brand
                    if (state.itemModel.brand != null) ...[
                      Text(
                        'Brand',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground
                                    .withOpacity(.6)),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        state.itemModel.brand!,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Item model
                    if (state.itemModel.model != null) ...[
                      Text(
                        'Model',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground
                                    .withOpacity(.6)),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        state.itemModel.model!,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Item serialNumber
                    if (state.itemModel.serialNumber != null) ...[
                      Text(
                        'Serial Number',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground
                                    .withOpacity(.6)),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        state.itemModel.serialNumber!,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Item serialNumber
                    if (state.itemModel.quantity != null) ...[
                      Text(
                        'Quantity',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground
                                    .withOpacity(.6)),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        state.itemModel.quantity!.toString(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Item serialNumber
                    if (state.itemModel.pricePerItem != null) ...[
                      Text(
                        'Price Per Item',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground
                                    .withOpacity(.6)),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        state.itemModel.pricePerItem!.toString(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Item serialNumber
                    if (state.itemModel.serialNumber != null) ...[
                      Text(
                        'Serial Number',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground
                                    .withOpacity(.6)),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        state.itemModel.serialNumber!,
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
        },
      ),
    );
  }
}
