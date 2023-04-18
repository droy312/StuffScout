import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:stuff_scout/core/widgets/snackbar_widget.dart';

import '../../../../service_locator.dart';
import '../../../container/data/models/container_model.dart';
import '../../../house/data/models/house_model.dart';
import '../../../item/data/models/item_model.dart';
import '../../../room/data/models/room_model.dart';
import '../../domain/usecases/search_usecase.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(const SearchState());

  final SearchUsecase _searchUsecase = sl<SearchUsecase>();

  void initSearchList({
    required BuildContext context,
    List<HouseModel>? houseList,
    HouseModel? houseModel,
    RoomModel? roomModel,
    ContainerModel? containerModel,
  }) async {
    emit(state.copyWith(isLoading: true));

    final List<HouseModel> initialHouseList = houseList ?? [];
    final List<RoomModel> initialRoomList = [];
    final List<ContainerModel> initialContainerList = [];
    final List<ItemModel> initialItemList = [];

    if (houseList != null) {
      for (final houseModel in houseList) {
        final result1 = await _searchUsecase.getRoomList(houseModel.roomIdList);
        result1.fold(
          (l) {
            if (l.message != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                  CustomSnackBar(context: context, text: l.message!));
            }
          },
          (roomList) {
            initialRoomList.addAll(roomList);
          },
        );

        final result2 = await _searchUsecase.getItemList(houseModel.itemIdList);
        result2.fold(
          (l) {
            if (l.message != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                  CustomSnackBar(context: context, text: l.message!));
            }
          },
          (itemList) {
            initialItemList.addAll(itemList);
          },
        );
      }
    } else if (houseModel != null) {
      final result1 = await _searchUsecase.getRoomList(houseModel.roomIdList);
      result1.fold(
        (l) {
          if (l.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(context: context, text: l.message!));
          }
        },
        (roomList) {
          initialRoomList.addAll(roomList);
        },
      );

      final result2 = await _searchUsecase.getItemList(houseModel.itemIdList);
      result2.fold(
        (l) {
          if (l.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(context: context, text: l.message!));
          }
        },
        (itemList) {
          initialItemList.addAll(itemList);
        },
      );
    }

    for (final roomModel in initialRoomList) {
      final result1 =
          await _searchUsecase.getContainerList(roomModel.containerIdList);
      result1.fold(
        (l) {
          if (l.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(context: context, text: l.message!));
          }
        },
        (containerList) {
          initialContainerList.addAll(containerList);
        },
      );

      final result2 = await _searchUsecase.getItemList(roomModel.itemIdList);
      result2.fold(
        (l) {
          if (l.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(context: context, text: l.message!));
          }
        },
        (itemList) {
          initialItemList.addAll(itemList);
        },
      );
    }

    if (initialRoomList.isEmpty) {
      if (roomModel != null) {
        final result1 =
            await _searchUsecase.getContainerList(roomModel.containerIdList);
        result1.fold(
          (l) {
            if (l.message != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                  CustomSnackBar(context: context, text: l.message!));
            }
          },
          (containerList) {
            initialContainerList.addAll(containerList);
          },
        );

        final result2 = await _searchUsecase.getItemList(roomModel.itemIdList);
        result2.fold(
          (l) {
            if (l.message != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                  CustomSnackBar(context: context, text: l.message!));
            }
          },
          (itemList) {
            initialItemList.addAll(itemList);
          },
        );
      }
    }

    for (final containerModel in initialContainerList) {
      final result =
          await _searchUsecase.getItemList(containerModel.itemIdList);
      result.fold(
        (l) {
          if (l.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(context: context, text: l.message!));
          }
        },
        (itemList) {
          initialItemList.addAll(itemList);
        },
      );
    }

    if (initialContainerList.isEmpty) {
      if (containerModel != null) {
        final result1 = await _searchUsecase
            .getContainerList(containerModel.containerIdList);
        result1.fold(
          (l) {
            if (l.message != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                  CustomSnackBar(context: context, text: l.message!));
            }
          },
          (containerList) {
            initialContainerList.addAll(containerList);
          },
        );

        final result2 =
            await _searchUsecase.getItemList(containerModel.itemIdList);
        result2.fold(
          (l) {
            if (l.message != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                  CustomSnackBar(context: context, text: l.message!));
            }
          },
          (itemList) {
            initialItemList.addAll(itemList);
          },
        );
      }
    }

    emit(SearchState(
      houseList: initialHouseList,
      roomList: initialRoomList,
      containerList: initialContainerList,
      itemList: initialItemList,
      searchedHouseList: initialHouseList,
      searchedRoomList: initialRoomList,
      searchedContainerList: initialContainerList,
      searchedItemList: initialItemList,
    ));
  }

  void searchModelListFromLists(String searchText) {
    if (searchText.isEmpty) {
      emit(state.copyWith(
        searchedHouseList: state.houseList,
        searchedRoomList: state.roomList,
        searchedContainerList: state.containerList,
        searchedItemList: state.itemList,
      ));
    }

    final List<HouseModel> searchedHouseList =
        _searchUsecase.searchHouseList(state.houseList, searchText);
    final List<RoomModel> searchedRoomList =
        _searchUsecase.searchRoomList(state.roomList, searchText);
    final List<ContainerModel> searchedContainerList =
        _searchUsecase.searchContainerList(state.containerList, searchText);
    final List<ItemModel> searchedItemList =
        _searchUsecase.searchItemList(state.itemList, searchText);

    emit(state.copyWith(
      searchedHouseList: searchedHouseList,
      searchedRoomList: searchedRoomList,
      searchedContainerList: searchedContainerList,
      searchedItemList: searchedItemList,
    ));
  }
}
