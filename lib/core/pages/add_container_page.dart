import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuff_scout/core/cubits/add_container_cubit.dart';
import 'package:stuff_scout/core/models/location_model.dart';
import 'package:stuff_scout/core/nums.dart';
import 'package:stuff_scout/core/services/id_service.dart';
import 'package:stuff_scout/core/widgets/custom_elevated_button.dart';
import 'package:stuff_scout/core/widgets/input_text_field.dart';
import 'package:stuff_scout/core/widgets/loading_widget.dart';
import 'package:stuff_scout/features/container/data/models/container_model.dart';

import '../../service_locator.dart';
import '../widgets/back_icon_button.dart';
import '../widgets/get_image_from_camera_outlined_button.dart';
import '../widgets/get_image_from_gallery_outlined_button.dart';

class AddContainerPageArguments {
  const AddContainerPageArguments({
    required this.onContainerPressed,
    required this.containerLocationModel,
    this.isEditing = false,
    this.containerModel,
  });

  final Function(ContainerModel) onContainerPressed;
  final LocationModel containerLocationModel;
  final bool isEditing;
  final ContainerModel? containerModel;
}

class AddContainerPage extends StatefulWidget {
  AddContainerPage({
    Key? key,
    required this.addContainerPageArguments,
  }) : super(key: key);

  static const String routeName = '/add_container';

  final AddContainerPageArguments addContainerPageArguments;

  @override
  State<AddContainerPage> createState() => _AddContainerPageState();
}

class _AddContainerPageState extends State<AddContainerPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;

  late final IdService _idService;

  late final AddContainerCubit _addContainerCubit;

  @override
  void initState() {
    super.initState();

    _idService = sl<IdService>();
    _addContainerCubit = AddContainerCubit(context: context);

    if (widget.addContainerPageArguments.isEditing) {
      _nameController = TextEditingController(
          text: widget.addContainerPageArguments.containerModel!.name);
      _descriptionController = TextEditingController(
          text: widget.addContainerPageArguments.containerModel!.description);

      _addContainerCubit.addContainerFromContainerModel(
          widget.addContainerPageArguments.containerModel!);
    } else {
      _nameController = TextEditingController();
      _descriptionController = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double imageContainerHeight =
        MediaQuery.of(context).size.width - (2 * Nums.horizontalPaddingWidth);

    return BlocProvider<AddContainerCubit>.value(
      value: _addContainerCubit,
      child: BlocBuilder<AddContainerCubit, AddContainerState>(
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
                  !widget.addContainerPageArguments.isEditing
                      ? 'Add Container'
                      : 'Update Container',
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
                          _addContainerCubit.addContainerName(name);
                        },
                        hintText: 'Enter container name',
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
                        hintText: 'Enter container description',
                      ),
                      const SizedBox(height: 16),

                      // Image display
                      BlocBuilder<AddContainerCubit, AddContainerState>(
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
                                          _addContainerCubit.removeImageFile();
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
                                _addContainerCubit.addImageUrlFromCamera();
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: GetImageFromGalleryOutlinedButton(
                              context: context,
                              onPressed: () {
                                _addContainerCubit.addImageUrlFromGallery();
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
                                final ContainerModel containerModel =
                                    ContainerModel(
                                  id: !widget
                                          .addContainerPageArguments.isEditing
                                      ? _idService.generateRandomId()
                                      : widget.addContainerPageArguments
                                          .containerModel!.id,
                                  name: _nameController.text,
                                  description:
                                      _descriptionController.text.isNotEmpty
                                          ? _descriptionController.text
                                          : null,
                                  locationModel: widget
                                      .addContainerPageArguments
                                      .containerLocationModel,
                                  imageUrl: state.imageUrl,
                                );
                                _addContainerCubit.addContainer(widget
                                    .addContainerPageArguments
                                    .onContainerPressed(containerModel));
                              }
                            : null,
                        child: Center(
                          child: !state.isLoading
                              ? Text(
                                  !widget.addContainerPageArguments.isEditing
                                      ? 'Add Container'
                                      : 'Update Container',
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
