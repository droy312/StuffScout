import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../container/domain/entities/container_entity.dart';
import '../../../item/domain/entities/item_entity.dart';

part 'container_state.dart';

class ContainerCubit extends Cubit<ContainerState> {
  ContainerCubit({required ContainerEntity containerEntity})
      : super(ContainerState(containerEntity: containerEntity));

  void addContainer(ContainerEntity containerEntity) {
    state.containerEntity.addContainer(containerEntity);
    emit(ContainerState(containerEntity: state.containerEntity));
  }

  void addItem(ItemEntity itemEntity) {
    state.containerEntity.addItem(itemEntity);
    emit(ContainerState(containerEntity: state.containerEntity));
  }
}
