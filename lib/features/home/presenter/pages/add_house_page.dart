import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuff_scout/core/nums.dart';
import 'package:stuff_scout/core/services/id_service.dart';
import 'package:stuff_scout/core/widgets/custom_elevated_button.dart';
import 'package:stuff_scout/core/widgets/input_text_field.dart';
import 'package:stuff_scout/features/home/presenter/cubits/add_house_cubit.dart';
import 'package:stuff_scout/features/home/presenter/cubits/home_cubit.dart';

import '../../../../core/service_locator.dart';
import '../../../../core/widgets/back_icon_button.dart';
import '../../../house/domain/entities/house_entity.dart';

class AddHousePage extends StatefulWidget {
  const AddHousePage({
    Key? key,
    required this.addHousePageArguments,
  }) : super(key: key);

  static const String routeName = '/add_house';

  final AddHousePageArguments addHousePageArguments;

  @override
  State<AddHousePage> createState() => _AddHousePageState();
}

class _AddHousePageState extends State<AddHousePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final IdService _idService = sl<IdService>();

  final AddHouseCubit _addHouseCubit = AddHouseCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddHouseCubit>.value(
      value: _addHouseCubit,
      child: Scaffold(
        appBar: AppBar(
          leading: BackIconButton(
            context: context,
            iconColor: Theme.of(context).colorScheme.primary,
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
                  hintText: 'Enter house description',
                ),
                const SizedBox(height: 32),
                BlocBuilder<AddHouseCubit, AddHouseState>(
                  builder: (context, state) {
                    final bool isAddButtonEnabled = state.name.isNotEmpty;

                    // Add house elevated button
                    return CustomElevatedButton(
                      context: context,
                      onPressed: isAddButtonEnabled
                          ? () {
                              final HouseEntity houseEntity = HouseEntity(
                                id: _idService.generateRandomId(),
                                name: _nameController.text,
                                description:
                                    _descriptionController.text.isNotEmpty
                                        ? _descriptionController.text
                                        : null,
                              );
                              widget.addHousePageArguments.homeCubit
                                  .addHouse(houseEntity);
                              Navigator.pop(context);
                            }
                          : null,
                      child: Center(
                        child: Text(
                          'Add House',
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

class AddHousePageArguments {
  const AddHousePageArguments({required this.homeCubit});

  final HomeCubit homeCubit;
}
