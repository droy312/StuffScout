import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/widgets/snackbar_widget.dart';
import '../../../../service_locator.dart';
import '../../../house/data/models/house_model.dart';
import '../../../house/presenter/cubits/house_cubit.dart';
import '../../data/models/item_model.dart';
import '../../domain/usecases/item_usecase.dart';

part 'item_state.dart';

class ItemCubit extends Cubit<ItemState> {
  ItemCubit({
    required this.context,
    required ItemModel itemModel,
  }) : super(ItemState(itemModel: itemModel));

  final ItemUsecase _itemUsecase = sl<ItemUsecase>();

  final BuildContext context;

  Future<void> deleteRoom() async {
    final HouseModel houseModel = context.read<HouseCubit>().state.houseModel;
    final result = await _itemUsecase.deleteItemModel(houseModel, state.itemModel);
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
        context.read<HouseCubit>().deleteItem(state.itemModel);
        if (context.mounted) {
          Navigator.pop(context);
        }
      },
    );
  }
}
