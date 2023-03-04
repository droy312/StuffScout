import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuff_scout/core/models/location_model.dart';
import 'package:stuff_scout/core/nums.dart';
import 'package:stuff_scout/core/services/id_service.dart';
import 'package:stuff_scout/core/widgets/custom_elevated_button.dart';
import 'package:stuff_scout/core/widgets/input_text_field.dart';
import 'package:stuff_scout/features/house/presenter/cubits/add_room_cubit.dart';
import 'package:stuff_scout/features/room/data/models/room_model.dart';

import '../../../../service_locator.dart';
import '../../../../core/widgets/back_icon_button.dart';

class AddRoomPageArguments {
  const AddRoomPageArguments({
    required this.onAddRoomPressed,
    required this.roomLocationModel,
  });

  final Function(RoomModel) onAddRoomPressed;
  final LocationModel roomLocationModel;
}

class AddRoomPage extends StatelessWidget {
  AddRoomPage({
    Key? key,
    required this.addRoomPageArguments,
  }) : super(key: key);

  static const String routeName = '/add_room';

  final AddRoomPageArguments addRoomPageArguments;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final IdService _idService = sl<IdService>();

  final AddRoomCubit _addRoomCubit = AddRoomCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddRoomCubit>.value(
      value: _addRoomCubit,
      child: Scaffold(
        appBar: AppBar(
          leading: BackIconButton(
            context: context,
            iconColor: Theme.of(context).colorScheme.primary,
          ),
          title: Text(
            'Add Room',
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
                    _addRoomCubit.addRoomName(name);
                  },
                  hintText: 'Enter room name',
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
                  hintText: 'Enter room description',
                ),
                const SizedBox(height: 32),
                BlocBuilder<AddRoomCubit, AddRoomState>(
                  builder: (context, state) {
                    final bool isAddButtonEnabled = state.name != null;

                    // Add house elevated button
                    return CustomElevatedButton(
                      context: context,
                      onPressed: isAddButtonEnabled
                          ? () {
                              final RoomModel roomEntity = RoomModel(
                                id: _idService.generateRandomId(),
                                name: _nameController.text,
                                description:
                                    _descriptionController.text.isNotEmpty
                                        ? _descriptionController.text
                                        : null,
                                locationModel: addRoomPageArguments.roomLocationModel,
                              );
                              addRoomPageArguments.onAddRoomPressed(roomEntity);
                              Navigator.pop(context);
                            }
                          : null,
                      child: Center(
                        child: Text(
                          'Add Room',
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
