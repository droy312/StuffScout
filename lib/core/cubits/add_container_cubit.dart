import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:stuff_scout/features/room/domain/usecases/room_usecase.dart';

import '../../service_locator.dart';
import '../widgets/snackbar_widget.dart';

part 'add_container_state.dart';

class AddContainerCubit extends Cubit<AddContainerState> {
  AddContainerCubit() : super(const AddContainerState());

  final RoomUsecase _roomUsecase = sl<RoomUsecase>();

  void addContainerName(String name) {
    if (name.isEmpty) {
      emit(const AddContainerState());
    } else {
      emit(AddContainerState(name: name));
    }
  }

  void addContainer(BuildContext context, Future addContainer) async {
    emit(state.copyWith(isLoading: true));

    await addContainer;

    emit(state.copyWith(isLoading: false));

    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  void addImageUrlFromCamera(BuildContext context) async {
    final result = await _roomUsecase.getImageFileFromCamera();
    result.fold((l) {
      if (l.message != null) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          context: context,
          text: l.message!,
          isError: true,
        ));
      }
    }, (imageFile) {
      if (imageFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          context: context,
          text: 'No Image selected',
        ));
      } else {
        emit(state.copyWith(imageUrl: imageFile.path));
      }
    });
  }

  void addImageUrlFromGallery(BuildContext context) async {
    final result = await _roomUsecase.getImageFileFromGallery();
    result.fold((l) {
      if (l.message != null) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          context: context,
          text: l.message!,
          isError: true,
        ));
      }
    }, (imageFile) {
      if (imageFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          context: context,
          text: 'No Image selected',
        ));
      } else {
        emit(state.copyWith(imageUrl: imageFile.path));
      }
    });
  }

  void removeImageFile() {
    emit(state.copyWith(imageUrl: null));
  }
}
