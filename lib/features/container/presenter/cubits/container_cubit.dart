import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:stuff_scout/features/container/domain/container_usecases/container_usecase.dart';
import 'package:stuff_scout/features/item/domain/usecases/item_usecase.dart';

import '../../../../core/widgets/snackbar_widget.dart';
import '../../../../service_locator.dart';
import '../../data/models/container_model.dart';
import '../../../item/data/models/item_model.dart';

part 'container_state.dart';

class ContainerCubit extends Cubit<ContainerState> {
  ContainerCubit({
    required this.context,
    required ContainerModel containerModel,
  }) : super(ContainerState(containerModel: containerModel));

  final ContainerUsecase _containerUsecase = sl<ContainerUsecase>();
  final ItemUsecase _itemUsecase = sl<ItemUsecase>();

  final BuildContext context;

  void init() async {
    emit(state.copyWith(isLoading: true));

    final result = await _containerUsecase
        .getContainerModelList(state.containerModel.containerIdList);
    result.fold((l) {
      if (l.message != null) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          context: context,
          text: l.message!,
          isError: true,
        ));
      }
    }, (containerList) {
      state.containerModel.addContainerList(containerList);
    });

    final result2 = await _containerUsecase
        .getItemModelList(state.containerModel.itemIdList);
    result2.fold((l) {
      if (l.message != null) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          context: context,
          text: l.message!,
          isError: true,
        ));
      }
    }, (itemList) {
      state.containerModel.addItemList(itemList);
    });

    emit(ContainerState(containerModel: state.containerModel));
  }

  Future<void> addContainer(ContainerModel containerModel, {bool showSuccessSnackbar = true}) async {
    final result = await _containerUsecase.putContainerModel(
        state.containerModel.id, containerModel);
    result.fold((l) {
      if (l.message != null) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          context: context,
          text: l.message!,
          isError: true,
        ));
      }
    }, (r) {
      state.containerModel.addContainer(containerModel);
      emit(ContainerState(containerModel: state.containerModel));

      if (r.message != null && showSuccessSnackbar) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          context: context,
          text: r.message!,
        ));
      }
    });
  }

  Future<void> addItem(ItemModel itemModel, {bool showSuccessSnackbar = true}) async {
    final result = await _containerUsecase.putItemModel(
        state.containerModel.id, itemModel);
    result.fold((l) {
      if (l.message != null) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          context: context,
          text: l.message!,
          isError: true,
        ));
      }
    }, (r) {
      state.containerModel.addItem(itemModel);
      emit(ContainerState(containerModel: state.containerModel));

      if (r.message != null && showSuccessSnackbar) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          context: context,
          text: r.message!,
        ));
      }
    });
  }

  Future<void> deleteContainer(ContainerModel containerModel, {bool showSuccessSnackbar = true}) async {
    emit(state.copyWith(isLoading: true));

    final result = await _containerUsecase.deleteContainerModelFromContainerModel(
        state.containerModel, containerModel);

    result.fold(
          (l) {
        if (l.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
            context: context,
            text: l.message!,
            isError: true,
          ));
        }
      },
          (r) {
        if (r.message != null && showSuccessSnackbar) {
          ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
            context: context,
            text: r.message!,
          ));
        }

        state.containerModel.deleteContainer(containerModel);
      },
    );

    emit(ContainerState(containerModel: state.containerModel));
  }

  Future<void> deleteItem(ItemModel itemModel, {bool showSuccessSnackbar = true}) async {
    emit(state.copyWith(isLoading: true));

    final result = await _containerUsecase.deleteItemModelFromContainerModel(
        state.containerModel, itemModel);

    result.fold(
          (l) {
        if (l.message != null && showSuccessSnackbar) {
          ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
            context: context,
            text: l.message!,
            isError: true,
          ));
        }
      },
          (r) {
        if (r.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
            context: context,
            text: r.message!,
          ));
        }

        state.containerModel.deleteItem(itemModel);
      },
    );

    emit(ContainerState(containerModel: state.containerModel));
  }

  Future<void> updateContainer(ContainerModel containerModel) async {
    final result = await _containerUsecase.updateContainerModel(containerModel);
    result.fold(
          (l) {
        if (l.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
            context: context,
            text: l.message!,
            isError: true,
          ));
        }
      },
          (r) {
        if (r.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
            context: context,
            text: r.message!,
          ));
        }

        final List<ContainerModel> containerList = [];
        for (final container in state.containerModel.containerList) {
          if (container.id != containerModel.id) {
            containerList.add(container);
          } else {
            containerList.add(containerModel);
          }
        }

        state.containerModel.addContainerList(containerList);
        emit(ContainerState(containerModel: state.containerModel));
      },
    );
  }

  Future<void> updateItem(ItemModel itemModel) async {
    final result = await _itemUsecase.updateItemModel(itemModel);
    result.fold(
          (l) {
        if (l.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
            context: context,
            text: l.message!,
            isError: true,
          ));
        }
      },
          (r) {
        if (r.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
            context: context,
            text: r.message!,
          ));
        }

        final List<ItemModel> itemList = [];
        for (final item in state.containerModel.itemList) {
          if (item.id != itemModel.id) {
            itemList.add(item);
          } else {
            itemList.add(itemModel);
          }
        }

        state.containerModel.addItemList(itemList);
        emit(ContainerState(containerModel: state.containerModel));
      },
    );
  }
}
