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
    required this.onItemPressed,
    required this.itemLocationModel,
    this.isEditing = false,
    this.itemModel,
  }) : assert((isEditing && itemModel != null) ||
            (!isEditing && itemModel == null));

  final Function(ItemModel) onItemPressed;
  final LocationModel itemLocationModel;
  final bool isEditing;
  final ItemModel? itemModel;
}

class AddItemPage extends StatefulWidget {
  AddItemPage({
    Key? key,
    required this.addItemPageArguments,
  }) : super(key: key);

  static const String routeName = '/add_item';

  final AddItemPageArguments addItemPageArguments;

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _brandController;
  late final TextEditingController _modelController;
  late final TextEditingController _serialNumberController;
  late final TextEditingController _quantityController;
  late final TextEditingController _pricePerItemController;

  late final IdService _idService;

  late final AddItemCubit _addItemCubit;

  @override
  void initState() {
    super.initState();

    _idService = sl<IdService>();
    _addItemCubit = AddItemCubit(context: context);

    if (widget.addItemPageArguments.isEditing) {
      _nameController = TextEditingController(
          text: widget.addItemPageArguments.itemModel!.name);
      _descriptionController = TextEditingController(
          text: widget.addItemPageArguments.itemModel!.description);
      _brandController = TextEditingController(
          text: widget.addItemPageArguments.itemModel!.brand);
      _modelController = TextEditingController(
          text: widget.addItemPageArguments.itemModel!.model);
      _serialNumberController = TextEditingController(
          text: widget.addItemPageArguments.itemModel!.serialNumber);
      _quantityController = TextEditingController(
          text: widget.addItemPageArguments.itemModel!.quantity.toString());
      _pricePerItemController = TextEditingController(
          text: widget.addItemPageArguments.itemModel!.pricePerItem.toString());

      _addItemCubit
          .addItemFromItemModel(widget.addItemPageArguments.itemModel!);
    } else {
      _nameController = TextEditingController();
      _descriptionController = TextEditingController();
      _brandController = TextEditingController();
      _modelController = TextEditingController();
      _serialNumberController = TextEditingController();
      _quantityController = TextEditingController();
      _pricePerItemController = TextEditingController();
    }
  }

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
                  !widget.addItemPageArguments.isEditing
                      ? 'Add Item'
                      : 'Update Item',
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
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(16)),
                                          child: Center(
                                              child: Image.file(
                                                  File(state.imageUrl!)))),
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
                                _addItemCubit.addImageUrlFromCamera();
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: GetImageFromGalleryOutlinedButton(
                              context: context,
                              onPressed: () {
                                _addItemCubit.addImageUrlFromGallery();
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
                                  id: !widget.addItemPageArguments.isEditing
                                      ? _idService.generateRandomId()
                                      : widget
                                          .addItemPageArguments.itemModel!.id,
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
                                  locationModel: widget
                                      .addItemPageArguments.itemLocationModel,
                                  imageUrl: state.imageUrl,
                                );
                                _addItemCubit.addItem(
                                    widget.addItemPageArguments
                                        .onItemPressed(itemModel));
                              }
                            : null,
                        child: Center(
                          child: !state.isLoading
                              ? Text(
                                  !widget.addItemPageArguments.isEditing
                                      ? 'Add Item'
                                      : 'Update Item',
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
