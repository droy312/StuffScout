import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'add_house_state.dart';

class AddHouseCubit extends Cubit<AddHouseState> {
  AddHouseCubit() : super(const AddHouseState());

  void addHouseName(String name) {
    if (name.isEmpty) {
      emit(const AddHouseState());
    } else {
      emit(AddHouseState(name: name));
    }
  }

  Future<void> addHouse(BuildContext context, Future addHouse) async {
    emit(state.copyWith(isLoading: true));

    await addHouse;

    emit(state.copyWith(isLoading: false));

    if (context.mounted) {
      Navigator.pop(context);
    }
  }
}
