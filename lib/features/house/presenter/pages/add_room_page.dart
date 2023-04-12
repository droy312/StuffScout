import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuff_scout/core/models/location_model.dart';
import 'package:stuff_scout/core/nums.dart';
import 'package:stuff_scout/core/services/id_service.dart';
import 'package:stuff_scout/core/widgets/custom_elevated_button.dart';
import 'package:stuff_scout/core/widgets/input_text_field.dart';
import 'package:stuff_scout/core/widgets/loading_widget.dart';
import 'package:stuff_scout/features/house/presenter/cubits/add_room_cubit.dart';
import 'package:stuff_scout/features/room/data/models/room_model.dart';

import '../../../../core/widgets/get_image_from_camera_outlined_button.dart';
import '../../../../core/widgets/get_image_from_gallery_outlined_button.dart';
import '../../../../service_locator.dart';
import '../../../../core/widgets/back_icon_button.dart';

class AddRoomPageArguments {
  const AddRoomPageArguments({
    required this.onRoomPressed,
    required this.roomLocationModel,
    this.isEditing = false,
    this.roomModel,
  }) : assert((isEditing && roomModel != null) ||
            (!isEditing && roomModel == null));

  final Function(RoomModel) onRoomPressed;
  final LocationModel roomLocationModel;
  final bool isEditing;
  final RoomModel? roomModel;
}

class AddRoomPage extends StatefulWidget {
  AddRoomPage({
    Key? key,
    required this.addRoomPageArguments,
  }) : super(key: key);

  static const String routeName = '/add_room';

  final AddRoomPageArguments addRoomPageArguments;

  @override
  State<AddRoomPage> createState() => _AddRoomPageState();
}

class _AddRoomPageState extends State<AddRoomPage> {
  late final TextEditingController _nameController;

  late final TextEditingController _descriptionController;

  late final IdService _idService;

  late final AddRoomCubit _addRoomCubit;

  @override
  void initState() {
    super.initState();

    _idService = sl<IdService>();
    _addRoomCubit = AddRoomCubit();

    if (widget.addRoomPageArguments.isEditing) {
      _nameController = TextEditingController(
          text: widget.addRoomPageArguments.roomModel!.name);
      _descriptionController = TextEditingController(
          text: widget.addRoomPageArguments.roomModel!.description);
      _addRoomCubit
          .addRoomFromRoomModel(widget.addRoomPageArguments.roomModel!);
    } else {
      _nameController = TextEditingController();
      _descriptionController = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double imageContainerHeight =
        MediaQuery.of(context).size.width - (2 * Nums.horizontalPaddingWidth);

    return BlocProvider<AddRoomCubit>.value(
      value: _addRoomCubit,
      child: BlocBuilder<AddRoomCubit, AddRoomState>(
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
                  !widget.addRoomPageArguments.isEditing
                      ? 'Add Room'
                      : 'Update Room',
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
                        hintText: 'Enter room description',
                      ),
                      const SizedBox(height: 16),

                      // Image display
                      BlocBuilder<AddRoomCubit, AddRoomState>(
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
                                          _addRoomCubit.removeImageFile();
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
                                _addRoomCubit.addImageUrlFromCamera(context);
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: GetImageFromGalleryOutlinedButton(
                              context: context,
                              onPressed: () {
                                _addRoomCubit.addImageUrlFromGallery(context);
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
                                final RoomModel roomModel = RoomModel(
                                  id: widget.addRoomPageArguments.isEditing
                                      ? widget
                                          .addRoomPageArguments.roomModel!.id
                                      : _idService.generateRandomId(),
                                  name: _nameController.text,
                                  description:
                                      _descriptionController.text.isNotEmpty
                                          ? _descriptionController.text
                                          : null,
                                  locationModel: widget
                                      .addRoomPageArguments.roomLocationModel,
                                  imageUrl: state.imageUrl,
                                );
                                _addRoomCubit.addRoom(
                                    context,
                                    widget.addRoomPageArguments
                                        .onRoomPressed(roomModel));
                              }
                            : null,
                        child: Center(
                          child: !state.isLoading
                              ? Text(
                                  !widget.addRoomPageArguments.isEditing
                                      ? 'Add Room'
                                      : 'Update Room',
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
