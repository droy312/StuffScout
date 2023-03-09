import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuff_scout/core/nums.dart';
import 'package:stuff_scout/core/services/id_service.dart';
import 'package:stuff_scout/core/widgets/custom_elevated_button.dart';
import 'package:stuff_scout/core/widgets/input_text_field.dart';
import 'package:stuff_scout/core/widgets/loading_widget.dart';
import 'package:stuff_scout/features/home/presenter/cubits/add_house_cubit.dart';

import '../../../../service_locator.dart';
import '../../../../core/widgets/back_icon_button.dart';
import '../../../house/data/models/house_model.dart';

class AddHousePageArguments {
  const AddHousePageArguments({required this.onAddHousePressed});

  final Function(HouseModel) onAddHousePressed;
}

class AddHousePage extends StatelessWidget {
  AddHousePage({
    Key? key,
    required this.addHousePageArguments,
  }) : super(key: key);

  static const String routeName = '/add_house';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final IdService _idService = sl<IdService>();

  final AddHouseCubit _addHouseCubit = AddHouseCubit();

  final AddHousePageArguments addHousePageArguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddHouseCubit>.value(
      value: _addHouseCubit,
      child: BlocBuilder<AddHouseCubit, AddHouseState>(
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
                  'Add House',
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
                          _addHouseCubit.addHouseName(name);
                        },
                        hintText: 'Enter house name',
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
                        hintText: 'Enter house description',
                      ),
                      const SizedBox(height: 32),
                      // Add house elevated button
                      CustomElevatedButton(
                        context: context,
                        onPressed: isAddButtonEnabled
                            ? () async {
                                final HouseModel houseModel = HouseModel(
                                  id: _idService.generateRandomId(),
                                  name: _nameController.text,
                                  description:
                                      _descriptionController.text.isNotEmpty
                                          ? _descriptionController.text
                                          : null,
                                );
                                await _addHouseCubit.addHouse(
                                    context, addHousePageArguments.onAddHousePressed(houseModel));
                              }
                            : null,
                        child: Center(
                          child: !state.isLoading
                              ? Text(
                                  'Add House',
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
