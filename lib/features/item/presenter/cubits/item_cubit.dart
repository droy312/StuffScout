import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../data/models/item_model.dart';

part 'item_state.dart';

class ItemCubit extends Cubit<ItemState> {
  ItemCubit({
    required this.context,
    required ItemModel itemModel,
  }) : super(ItemState(itemModel: itemModel));

  final BuildContext context;
}
