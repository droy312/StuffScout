import 'package:bloc/bloc.dart';
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
}
