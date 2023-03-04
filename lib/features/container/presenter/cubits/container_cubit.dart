import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/container_model.dart';
import '../../../item/data/models/item_model.dart';

part 'container_state.dart';

class ContainerCubit extends Cubit<ContainerState> {
  ContainerCubit({required ContainerModel containerEntity})
      : super(ContainerState(containerEntity: containerEntity));

  void addContainer(ContainerModel containerEntity) {
    state.containerEntity.addContainer(containerEntity);
    emit(ContainerState(containerEntity: state.containerEntity));
  }

  void addItem(ItemModel itemEntity) {
    state.containerEntity.addItem(itemEntity);
    emit(ContainerState(containerEntity: state.containerEntity));
  }
}
