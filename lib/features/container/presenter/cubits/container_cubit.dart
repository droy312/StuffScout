import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/container_model.dart';
import '../../../item/data/models/item_model.dart';

part 'container_state.dart';

class ContainerCubit extends Cubit<ContainerState> {
  ContainerCubit({required ContainerModel containerModel})
      : super(ContainerState(containerModel: containerModel));

  void addContainer(ContainerModel containerModel) {
    state.containerModel.addContainer(containerModel);
    emit(ContainerState(containerModel: state.containerModel));
  }

  void addItem(ItemModel itemModel) {
    state.containerModel.addItem(itemModel);
    emit(ContainerState(containerModel: state.containerModel));
  }
}
