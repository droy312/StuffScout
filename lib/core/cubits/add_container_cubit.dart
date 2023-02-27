import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_container_state.dart';

class AddContainerCubit extends Cubit<AddContainerState> {
  AddContainerCubit() : super(const AddContainerState());

  void addContainerName(String name) {
    if (name.isEmpty) {
      emit(const AddContainerState());
    } else {
      emit(AddContainerState(name: name));
    }
  }
}
