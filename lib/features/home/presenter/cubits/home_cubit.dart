import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:stuff_scout/core/widgets/snackbar_widget.dart';
import 'package:stuff_scout/features/home/domain/usercases/home_usecase.dart';

import '../../../../service_locator.dart';
import '../../../house/data/models/house_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.context}) : super(const HomeState());

  final HomeUsecase _homeUsecase = sl<HomeUsecase>();

  final BuildContext context;

  void init() async {
    emit(state.copyWith(isLoading: true));

    List<HouseModel> houseList = [];
    final result = await _homeUsecase.getHouseModelList();
    result.fold((l) {
      if (l.message != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBarWidget(
          context: context,
          text: l.message!,
          isError: true,
        ));
      }
    }, (r) {
      houseList = r;
    });

    emit(HomeState(houseList: houseList));
  }

  Future<void> addHouse(HouseModel houseModel) async {
    final List<HouseModel> houseList = state.houseList.toList();

    final result = await _homeUsecase.putHouseModel(houseModel);
    result.fold((l) {
      if (l.message != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBarWidget(
          context: context,
          text: l.message!,
          isError: true,
        ));
      }
    }, (r) {
      houseList.add(houseModel);
      emit(state.copyWith(houseList: houseList));

      if (r.message != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBarWidget(
          context: context,
          text: r.message!,
        ));
      }
    });
  }
}
