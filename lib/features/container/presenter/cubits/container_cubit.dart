import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../container/domain/entities/container_entity.dart';
import '../../../item/data/models/item_model.dart';

part 'container_state.dart';

class ContainerCubit extends Cubit<ContainerState> {
  ContainerCubit({required ContainerEntity containerEntity})
      : super(ContainerState(containerEntity: containerEntity));

  void addContainer(ContainerEntity containerEntity) {
    state.containerEntity.addContainer(containerEntity);
    emit(ContainerState(containerEntity: state.containerEntity));
  }

  void addItem(ItemModel itemEntity) {
    state.containerEntity.addItem(itemEntity);
    emit(ContainerState(containerEntity: state.containerEntity));
  }
}
