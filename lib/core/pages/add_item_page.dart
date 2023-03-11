import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuff_scout/core/cubits/add_item_cubit.dart';
import 'package:stuff_scout/core/models/location_model.dart';
import 'package:stuff_scout/core/nums.dart';
import 'package:stuff_scout/core/services/id_service.dart';
import 'package:stuff_scout/core/widgets/custom_elevated_button.dart';
import 'package:stuff_scout/core/widgets/input_text_field.dart';
import 'package:stuff_scout/core/widgets/loading_widget.dart';
import 'package:stuff_scout/features/item/data/models/item_model.dart';

import '../../service_locator.dart';
import '../widgets/back_icon_button.dart';
import '../widgets/get_image_from_camera_outlined_button.dart';
import '../widgets/get_image_from_gallery_outlined_button.dart';

class AddItemPageArguments {
  const AddItemPageArguments({
    required this.onAddItemPressed,
    required this.itemLocationModel,
  });

  final Function(ItemModel) onAddItemPressed;
  final LocationModel itemLocationModel;
}

class AddItemPage extends StatelessWidget {
  AddItemPage({
    Key? key,
    required this.addItemPageArguments,
  }) : super(key: key);

  static const String routeName = '/add_item';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _serialNumberController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _pricePerItemController = TextEditingController();

  final IdService _idService = sl<IdService>();

  final AddItemCubit _addItemCubit = AddItemCubit();

  final AddItemPageArguments addItemPageArguments;

  @override
  Widget build(BuildContext context) {
    final double imageContainerHeight =
        MediaQuery.of(context).size.width - (2 * Nums.horizontalPaddingWidth);

    return BlocProvider<AddItemCubit>.value(
      value: _addItemCubit,
      child: BlocBuilder<AddItemCubit, AddItemState>(
        builder: (context, state) {
          final bool isAddButtonEnabled = state.name != null;

          return WillPopScope(
            onWillPop: () async {
              return !state.isLoading;
            },
            child: Scaffold(
              appBar: AppBar(
                leading: BackIconButton(
                  context: context,
                  iconColor: Theme.of(context).colorScheme.primary,
                  enabled: !state.isLoading,
                ),
                title: Text(
                  'Add Item',
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
                      // Name text field
                      InputTextField(
                        controller: _nameController,
                        context: context,
                        onChanged: (name) {
                          _addItemCubit.addItemName(name);
                        },
                        hintText: 'Enter item name',
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          '* required',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Description text field
                      InputTextField(
                        controller: _descriptionController,
                        context: context,
                        hintText: 'Enter item description',
                      ),
                      const SizedBox(height: 16),

                      // Brand text field
                      InputTextField(
                        controller: _brandController,
                        context: context,
                        hintText: 'Enter item brand',
                      ),
                      const SizedBox(height: 16),

                      // Model text field
                      InputTextField(
                        controller: _modelController,
                        context: context,
                        hintText: 'Enter item model',
                      ),
                      const SizedBox(height: 16),

                      // Serial number text field
                      InputTextField(
                        controller: _serialNumberController,
                        context: context,
                        hintText: 'Enter item serial number',
                      ),
                      const SizedBox(height: 16),

                      // Quantity text field
                      InputTextField(
                        controller: _quantityController,
                        context: context,
                        keyboardType: TextInputType.number,
                        hintText: 'Enter item quantity',
                      ),
                      const SizedBox(height: 16),

                      // Price per item text field
                      InputTextField(
                        controller: _pricePerItemController,
                        context: context,
                        keyboardType: TextInputType.number,
                        hintText: 'Enter price per item',
                      ),
                      const SizedBox(height: 16),

                      // Image display
                      BlocBuilder<AddItemCubit, AddItemState>(
                        builder: (context, state) {
                          if (state.imageUrl != null) {
                            return Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: imageContainerHeight,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(16)),
                                        border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          width: 1,
                                        ),
                                      ),
                                      child: ClipRRect(
                                          borderRadius:
                                          const BorderRadius.all(
                                              Radius.circular(16)),
                                          child:
                                          Center(child: Image.file(File(state.imageUrl!)))),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: IconButton(
                                        onPressed: () {
                                          _addItemCubit.removeImageFile();
                                        },
                                        icon: Container(
                                          width: 24,
                                          height: 24,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.clear,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onError,
                                            size: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                              ],
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),

                      // Image adding button
                      Row(
                        children: [
                          Expanded(
                            child: GetImageFromCameraOutlinedButton(
                              context: context,
                              onPressed: () {
                                _addItemCubit.addImageUrlFromCamera(context);
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: GetImageFromGalleryOutlinedButton(
                              context: context,
                              onPressed: () {
                                _addItemCubit.addImageUrlFromGallery(context);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // Add house elevated button
                      CustomElevatedButton(
                        context: context,
                        onPressed: isAddButtonEnabled
                            ? () {
                                final int? quantity =
                                    int.tryParse(_quantityController.text);
                                final double? pricePerItem = double.tryParse(
                                    _pricePerItemController.text);
                                final ItemModel itemModel = ItemModel(
                                  id: _idService.generateRandomId(),
                                  name: _nameController.text,
                                  description:
                                      _descriptionController.text.isNotEmpty
                                          ? _descriptionController.text
                                          : null,
                                  brand: _brandController.text.isNotEmpty
                                      ? _brandController.text
                                      : null,
                                  model: _modelController.text.isNotEmpty
                                      ? _modelController.text
                                      : null,
                                  serialNumber:
                                      _serialNumberController.text.isNotEmpty
                                          ? _serialNumberController.text
                                          : null,
                                  quantity: quantity,
                                  pricePerItem: pricePerItem,
                                  locationModel:
                                      addItemPageArguments.itemLocationModel,
                                );
                                _addItemCubit.addItem(
                                    context,
                                    addItemPageArguments
                                        .onAddItemPressed(itemModel));
                              }
                            : null,
                        child: Center(
                          child: !state.isLoading
                              ? Text(
                                  'Add Item',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary),
                                )
                              : LoadingWidget(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  size: 14,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
