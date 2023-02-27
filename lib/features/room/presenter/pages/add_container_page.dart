import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuff_scout/core/models/location_model.dart';
import 'package:stuff_scout/core/nums.dart';
import 'package:stuff_scout/core/services/id_service.dart';
import 'package:stuff_scout/core/widgets/custom_elevated_button.dart';
import 'package:stuff_scout/core/widgets/input_text_field.dart';
import 'package:stuff_scout/features/container/domain/entities/container_entity.dart';
import 'package:stuff_scout/features/house/presenter/cubits/add_room_cubit.dart';
import 'package:stuff_scout/features/room/presenter/cubits/room_cubit.dart';

import '../../../../core/service_locator.dart';
import '../../../../core/widgets/back_icon_button.dart';

class AddContainerPageArguments {
  const AddContainerPageArguments({
    required this.roomCubit,
    required this.locationModel,
  });

  final RoomCubit roomCubit;
  final LocationModel locationModel;
}

class AddContainerPage extends StatelessWidget {
  AddContainerPage({
    Key? key,
    required this.addContainerPageArguments,
  }) : super(key: key);

  static const String routeName = '/add_container';

  final AddContainerPageArguments addContainerPageArguments;

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
                  hintText: 'Enter container name',
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
                  hintText: 'Enter container description',
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
                        final ContainerEntity containerEntity = ContainerEntity(
                          id: _idService.generateRandomId(),
                          name: _nameController.text,
                          description:
                          _descriptionController.text.isNotEmpty
                              ? _descriptionController.text
                              : null,
                          locationModel: addContainerPageArguments.locationModel,
                        );
                        addContainerPageArguments.roomCubit
                            .addContainer(containerEntity);
                        Navigator.pop(context);
                      }
                          : null,
                      child: Center(
                        child: Text(
                          'Add Container',
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
