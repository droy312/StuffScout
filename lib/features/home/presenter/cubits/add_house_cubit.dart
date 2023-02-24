import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_house_state.dart';

class AddHouseCubit extends Cubit<AddHouseState> {
  AddHouseCubit() : super(const AddHouseState(name: ''));

  void addHouseName(String name) {
    emit(AddHouseState(name: name));
  }
}
