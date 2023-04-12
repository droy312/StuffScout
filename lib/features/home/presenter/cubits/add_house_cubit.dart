import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:stuff_scout/core/widgets/snackbar_widget.dart';
import 'package:stuff_scout/features/home/domain/usercases/home_usecase.dart';

import '../../../../service_locator.dart';

part 'add_house_state.dart';

class AddHouseCubit extends Cubit<AddHouseState> {
  AddHouseCubit({required this.context}) : super(const AddHouseState());

  final HomeUsecase _homeUsecase = sl<HomeUsecase>();

  final BuildContext context;

  void addHouseName(String name) {
    if (name.isEmpty) {
      emit(const AddHouseState());
    } else {
      emit(AddHouseState(name: name));
    }
  }

  void addImageUrlFromCamera() async {
    final result = await _homeUsecase.getImageFileFromCamera();
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

  void addImageUrlFromGallery() async {
    final result = await _homeUsecase.getImageFileFromGallery();
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

  void addImageUrlFromHouse(String imageUrl) {
    emit(state.copyWith(imageUrl: imageUrl));
  }

  void removeImageFile() {
    emit(state.copyWith(imageUrl: null));
  }

  Future<void> addHouse(Future addHouse) async {
    emit(state.copyWith(isLoading: true));

    await addHouse;

    emit(state.copyWith(isLoading: false));

    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  Future<void> updateHouse(Future updateHouse) async {
    emit(state.copyWith(isLoading: true));

    await updateHouse;

    emit(state.copyWith(isLoading: false));

    if (context.mounted) {
      Navigator.pop(context);
    }
  }
}
