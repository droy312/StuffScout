import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:stuff_scout/features/house/domain/usecases/house_usecase.dart';

import '../../../../core/widgets/snackbar_widget.dart';
import '../../../../service_locator.dart';

part 'add_room_state.dart';

class AddRoomCubit extends Cubit<AddRoomState> {
  AddRoomCubit() : super(const AddRoomState());

  final HouseUsecase _houseUsecase = sl<HouseUsecase>();

  void addRoomName(String name) {
    if (name.isEmpty) {
      emit(const AddRoomState());
    } else {
      emit(AddRoomState(name: name));
    }
  }

  void addImageUrlFromCamera(BuildContext context) async {
    final result = await _houseUsecase.getImageFileFromCamera();
    result.fold((l) {
      if (l.message != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBarWidget(
          context: context,
          text: l.message!,
          isError: true,
        ));
      }
    }, (imageFile) {
      if (imageFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBarWidget(
          context: context,
          text: 'No Image selected',
        ));
      } else {
        emit(state.copyWith(imageUrl: imageFile.path));
      }
    });
  }

  void addImageUrlFromGallery(BuildContext context) async {
    final result = await _houseUsecase.getImageFileFromGallery();
    result.fold((l) {
      if (l.message != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBarWidget(
          context: context,
          text: l.message!,
          isError: true,
        ));
      }
    }, (imageFile) {
      if (imageFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBarWidget(
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

  void addRoom(BuildContext context, Future addRoom) async {
    emit(state.copyWith(isLoading: true));

    await addRoom;

    emit(state.copyWith(isLoading: false));

    if (context.mounted) {
      Navigator.pop(context);
    }
  }
}
