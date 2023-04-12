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
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
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
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          context: context,
          text: l.message!,
          isError: true,
        ));
      }
    }, (r) {
      houseList.add(houseModel);
      emit(state.copyWith(houseList: houseList));

      if (r.message != null) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          context: context,
          text: r.message!,
        ));
      }
    });
  }

  Future<void> deleteHouse(HouseModel houseModel) async {
    emit(state.copyWith(isLoading: true));

    List<HouseModel> updatedHouseList = state.houseList.toList();

    final result = await _homeUsecase.deleteHouseModel(houseModel);
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
        updatedHouseList.remove(houseModel);
      },
    );

    emit(HomeState(houseList: updatedHouseList));
  }

  Future<void> updateHouse(HouseModel houseModel) async {
    final result = await _homeUsecase.updateHouseModel(houseModel);
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

        final List<HouseModel> houseList = [];
        for (final house in state.houseList) {
          if (house.id != houseModel.id) {
            houseList.add(house);
          } else {
            houseList.add(houseModel);
          }
        }

        emit(HomeState(houseList: houseList));
      },
    );
  }
}
