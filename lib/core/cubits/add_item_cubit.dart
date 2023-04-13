import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:stuff_scout/features/item/data/models/item_model.dart';
import 'package:stuff_scout/features/room/domain/usecases/room_usecase.dart';

import '../../service_locator.dart';
import '../widgets/snackbar_widget.dart';

part 'add_item_state.dart';

class AddItemCubit extends Cubit<AddItemState> {
  AddItemCubit({required this.context}) : super(const AddItemState());

  final RoomUsecase _roomUsecase = sl<RoomUsecase>();

  final BuildContext context;

  void addItemFromItemModel(ItemModel itemModel) {
    emit(AddItemState(name: itemModel.name, imageUrl: itemModel.imageUrl));
  }

  void addItemName(String name) {
    if (name.isEmpty) {
      emit(const AddItemState());
    } else {
      emit(AddItemState(name: name));
    }
  }

  void addItem(Future addItem) async {
    emit(state.copyWith(isLoading: true));

    await addItem;

    emit(state.copyWith(isLoading: false));

    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  void addImageUrlFromCamera() async {
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

  void addImageUrlFromGallery() async {
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
