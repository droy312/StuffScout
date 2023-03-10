import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'add_item_state.dart';

class AddItemCubit extends Cubit<AddItemState> {
  AddItemCubit() : super(const AddItemState());

  void addItemName(String name) {
    if (name.isEmpty) {
      emit(const AddItemState());
    } else {
      emit(AddItemState(name: name));
    }
  }

  void addItem(BuildContext context, Future addItem) async {
    emit(state.copyWith(isLoading: true));

    await addItem;

    emit(state.copyWith(isLoading: false));

    if (context.mounted) {
      Navigator.pop(context);
    }
  }
}
