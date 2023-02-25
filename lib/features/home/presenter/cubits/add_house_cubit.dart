import 'package:bloc/bloc.dart';
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
}
