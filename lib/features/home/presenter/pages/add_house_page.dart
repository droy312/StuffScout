import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuff_scout/core/nums.dart';
import 'package:stuff_scout/core/services/id_service.dart';
import 'package:stuff_scout/core/widgets/custom_elevated_button.dart';
import 'package:stuff_scout/core/widgets/get_image_from_camera_outlined_button.dart';
import 'package:stuff_scout/core/widgets/get_image_from_gallery_outlined_button.dart';
import 'package:stuff_scout/core/widgets/input_text_field.dart';
import 'package:stuff_scout/core/widgets/loading_widget.dart';
import 'package:stuff_scout/features/home/presenter/cubits/add_house_cubit.dart';

import '../../../../service_locator.dart';
import '../../../../core/widgets/back_icon_button.dart';
import '../../../house/data/models/house_model.dart';

/// [onHousePressed] should be a function to add a house when [isEditing] is
/// false else [onHousePressed] should be a function to edit a given house
class AddHousePageArguments {
  const AddHousePageArguments({
    required this.onHousePressed,
    this.isEditing = false,
    this.houseModel,
  }) : assert((isEditing && houseModel != null) ||
            (!isEditing && houseModel == null));

  final Function(HouseModel) onHousePressed;
  final bool isEditing;
  final HouseModel? houseModel;
}

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
  late final TextEditingController _nameController;

  late final TextEditingController _descriptionController;

  late final IdService _idService;

  late final AddHouseCubit _addHouseCubit;

  @override
  void initState() {
    super.initState();

    _idService = sl<IdService>();
    _addHouseCubit = AddHouseCubit(context: context);

    if (widget.addHousePageArguments.isEditing) {
      _nameController = TextEditingController(
          text: widget.addHousePageArguments.houseModel!.name);
      _descriptionController = TextEditingController(
          text: widget.addHousePageArguments.houseModel!.description);

      _addHouseCubit
          .addHouseName(widget.addHousePageArguments.houseModel!.name);
      if (widget.addHousePageArguments.houseModel!.imageUrl != null) {
        _addHouseCubit.addImageUrlFromHouse(
            widget.addHousePageArguments.houseModel!.imageUrl!);
      }
    } else {
      _nameController = TextEditingController();
      _descriptionController = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double imageContainerHeight =
        MediaQuery.of(context).size.width - (2 * Nums.horizontalPaddingWidth);

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
                      const SizedBox(height: 16),

                      // Image display
                      BlocBuilder<AddHouseCubit, AddHouseState>(
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
                                          _addHouseCubit.removeImageFile();
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
                                _addHouseCubit.addImageUrlFromCamera();
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: GetImageFromGalleryOutlinedButton(
                              context: context,
                              onPressed: () {
                                _addHouseCubit.addImageUrlFromGallery();
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
                            ? () async {
                                final HouseModel houseModel = HouseModel(
                                  id: widget.addHousePageArguments.houseModel !=
                                          null
                                      ? widget
                                          .addHousePageArguments.houseModel!.id
                                      : _idService.generateRandomId(),
                                  name: _nameController.text,
                                  description:
                                      _descriptionController.text.isNotEmpty
                                          ? _descriptionController.text
                                          : null,
                                  imageUrl: state.imageUrl,
                                );

                                if (!widget.addHousePageArguments.isEditing) {
                                  await _addHouseCubit.addHouse(widget
                                      .addHousePageArguments
                                      .onHousePressed(houseModel));
                                } else {
                                  await _addHouseCubit.updateHouse(widget
                                      .addHousePageArguments
                                      .onHousePressed(houseModel));
                                }
                              }
                            : null,
                        child: Center(
                          child: !state.isLoading
                              ? Text(
                                  !widget.addHousePageArguments.isEditing
                                      ? 'Add House'
                                      : 'Update House',
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
