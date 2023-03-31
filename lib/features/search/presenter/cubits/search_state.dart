part of 'search_cubit.dart';

@immutable
class SearchState {
  const SearchState({
    this.houseList = const [],
    this.roomList = const [],
    this.containerList = const [],
    this.itemList = const [],
    this.searchedHouseList = const [],
    this.searchedRoomList = const [],
    this.searchedContainerList = const [],
    this.searchedItemList = const [],
    this.isLoading = false,
  });

  final List<HouseModel> houseList;
  final List<RoomModel> roomList;
  final List<ContainerModel> containerList;
  final List<ItemModel> itemList;
  final List<HouseModel> searchedHouseList;
  final List<RoomModel> searchedRoomList;
  final List<ContainerModel> searchedContainerList;
  final List<ItemModel> searchedItemList;
  final bool isLoading;

  SearchState copyWith({
    List<HouseModel>? houseList,
    List<RoomModel>? roomList,
    List<ContainerModel>? containerList,
    List<ItemModel>? itemList,
    List<HouseModel>? searchedHouseList,
    List<RoomModel>? searchedRoomList,
    List<ContainerModel>? searchedContainerList,
    List<ItemModel>? searchedItemList,
    bool? isLoading,
  }) {
    return SearchState(
      houseList: houseList ?? this.houseList,
      roomList: roomList ?? this.roomList,
      containerList: containerList ?? this.containerList,
      itemList: itemList ?? this.itemList,
      searchedHouseList: searchedHouseList ?? this.searchedHouseList,
      searchedRoomList: searchedRoomList ?? this.searchedRoomList,
      searchedContainerList:
          searchedContainerList ?? this.searchedContainerList,
      searchedItemList: searchedItemList ?? this.searchedItemList,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
