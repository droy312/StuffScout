import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuff_scout/core/cubits/add_item_cubit.dart';
import 'package:stuff_scout/core/models/location_model.dart';
import 'package:stuff_scout/core/nums.dart';
import 'package:stuff_scout/core/services/id_service.dart';
import 'package:stuff_scout/core/widgets/custom_elevated_button.dart';
import 'package:stuff_scout/core/widgets/input_text_field.dart';
import 'package:stuff_scout/features/item/data/models/item_model.dart';

import '../../service_locator.dart';
import '../widgets/back_icon_button.dart';

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
    return BlocProvider<AddItemCubit>.value(
      value: _addItemCubit,
      child: Scaffold(
        appBar: AppBar(
          leading: BackIconButton(
            context: context,
            iconColor: Theme.of(context).colorScheme.primary,
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
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
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
                const SizedBox(height: 32),
                BlocBuilder<AddItemCubit, AddItemState>(
                  builder: (context, state) {
                    final bool isAddButtonEnabled = state.name != null;

                    // Add house elevated button
                    return CustomElevatedButton(
                      context: context,
                      onPressed: isAddButtonEnabled
                          ? () {
                              final int? quantity = int.tryParse(_quantityController.text);
                              final double? pricePerItem = double.tryParse(_pricePerItemController.text);
                              final ItemModel itemEntity = ItemModel(
                                id: _idService.generateRandomId(),
                                name: _nameController.text,
                                description: _descriptionController.text.isNotEmpty ? _descriptionController.text : null,
                                brand: _brandController.text.isNotEmpty ? _brandController.text : null,
                                model: _modelController.text.isNotEmpty ? _modelController.text : null,
                                serialNumber: _serialNumberController.text.isNotEmpty ? _serialNumberController.text : null,
                                quantity: quantity,
                                pricePerItem: pricePerItem,
                                locationModel: addItemPageArguments.itemLocationModel,
                              );
                              addItemPageArguments.onAddItemPressed(itemEntity);
                              Navigator.pop(context);
                            }
                          : null,
                      child: Center(
                        child: Text(
                          'Add Item',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
