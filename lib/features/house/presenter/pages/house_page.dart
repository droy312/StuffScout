import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuff_scout/core/models/location_model.dart';
import 'package:stuff_scout/core/nums.dart';
import 'package:stuff_scout/core/services/id_service.dart';
import 'package:stuff_scout/core/widgets/back_search_sliver_app_bar.dart';
import 'package:stuff_scout/core/widgets/loading_widget.dart';
import 'package:stuff_scout/features/house/presenter/cubits/house_cubit.dart';
import 'package:stuff_scout/features/house/presenter/pages/widgets/add_room_item_alert_dialog.dart';
import 'package:stuff_scout/features/room/data/models/room_model.dart';

import '../../../../core/pages/add_item_page.dart';
import '../../../../core/widgets/item_card_widget.dart';
import '../../../../core/widgets/move_here_bottom_sheet.dart';
import '../../../item/data/models/item_model.dart';
import '../../../move/presenter/cubits/move_cubit.dart';
import '../../../search/presenter/pages/search_page.dart';
import 'widgets/room_card_widget.dart';
import '../../../../service_locator.dart';
import '../../../../core/widgets/add_floating_action_button.dart';
import '../../data/models/house_model.dart';
import 'add_room_page.dart';

class HousePageArguments {
  const HousePageArguments({required this.houseModel});

  final HouseModel houseModel;
}

class HousePage extends StatefulWidget {
  const HousePage({
    Key? key,
    required this.housePageArguments,
  }) : super(key: key);

  static const String routeName = '/house';

  final HousePageArguments housePageArguments;

  @override
  State<HousePage> createState() => _HousePageState();
}

class _HousePageState extends State<HousePage>
    with SingleTickerProviderStateMixin {
  final IdService _idService = sl<IdService>();

  late final TabController _tabController;

  late final HouseCubit _houseCubit;

  Widget _listOfWidgetsInGridView(List<Widget> list) {
    return SliverGrid.count(
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      crossAxisCount: 2,
      children: list,
    );
  }

  @override
  void initState() {
    super.initState();

    _houseCubit = HouseCubit(
      context: context,
      houseModel: widget.housePageArguments.houseModel,
    );
    _houseCubit.init();
    _tabController = TabController(length: 2, vsync: this);

    if (context.mounted) {
      context
          .read<MoveCubit>()
          .setParentStorageModel(widget.housePageArguments.houseModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HouseCubit>.value(
      value: _houseCubit,
      child: DefaultTabController(
        length: 2,
        child: BlocBuilder<HouseCubit, HouseState>(
          builder: (context, state) {
            return Scaffold(
              body: NestedScrollView(
                headerSliverBuilder: (context, value) {
                  return [
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                      sliver: BackSearchSliverAppBar(
                        context: context,
                        onSearchPressed: () {
                          Navigator.pushNamed(
                            context,
                            SearchPage.routeName,
                            arguments: SearchPageArguments(
                              title:
                                  'Search in ${widget.housePageArguments.houseModel.name}',
                              hintText: 'Search rooms, containers, items...',
                              houseModel: widget.housePageArguments.houseModel,
                            ),
                          );
                        },
                        title: widget.housePageArguments.houseModel.name,
                        description:
                            widget.housePageArguments.houseModel.description,
                        backgroundImageFilePath:
                            widget.housePageArguments.houseModel.imageUrl,
                        bottom: PreferredSize(
                          preferredSize: Size(
                            MediaQuery.of(context).size.width,
                            50,
                          ),
                          child: Container(
                            color: Theme.of(context).colorScheme.background,
                            child: TabBar(
                              controller: _tabController,
                              labelPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                              tabs: const [
                                Text('Rooms'),
                                Text('Items'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  controller: _tabController,
                  children: !state.isLoading
                      ? [
                          state.houseModel.roomList.isNotEmpty
                              ? Builder(builder: (context) {
                                  return CustomScrollView(
                                    key: const PageStorageKey('roomList'),
                                    slivers: [
                                      SliverOverlapInjector(
                                          handle: NestedScrollView
                                              .sliverOverlapAbsorberHandleFor(
                                                  context)),
                                      SliverPadding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal:
                                              Nums.horizontalPaddingWidth,
                                          vertical: 16,
                                        ),
                                        sliver: _listOfWidgetsInGridView(state
                                            .houseModel.roomList
                                            .map((roomModel) {
                                          return RoomCardWidget(
                                            roomModel: roomModel,
                                            onDeletePressed: () {
                                              _houseCubit.deleteRoom(roomModel);
                                            },
                                            onEditPressed: () {
                                              Navigator.pushNamed(
                                                context,
                                                AddRoomPage.routeName,
                                                arguments: AddRoomPageArguments(
                                                  onRoomPressed:
                                                      (roomModel) async {
                                                    _houseCubit
                                                        .updateRoom(roomModel);
                                                  },
                                                  roomLocationModel:
                                                      roomModel.locationModel,
                                                  isEditing: true,
                                                  roomModel: roomModel,
                                                ),
                                              );
                                            },
                                            onMovePressed: () {
                                              context
                                                  .read<MoveCubit>()
                                                  .copyStorageModel(() {
                                                _houseCubit.addRoom(roomModel,
                                                    showSuccessSnackbar: false);
                                              }, () {
                                                _houseCubit.deleteRoom(
                                                    roomModel,
                                                    showSuccessSnackbar: false);
                                              }, state.houseModel, roomModel);
                                            },
                                            onNavigateBack: () {
                                              context
                                                  .read<MoveCubit>()
                                                  .setParentStorageModel(
                                                      state.houseModel);
                                            },
                                          );
                                        }).toList()),
                                      ),
                                    ],
                                  );
                                })
                              : Center(
                                  child: Text(
                                  'No Rooms present',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground),
                                )),
                          state.houseModel.itemList.isNotEmpty
                              ? Builder(builder: (context) {
                                  return CustomScrollView(
                                    key: const PageStorageKey('itemList'),
                                    slivers: [
                                      SliverOverlapInjector(
                                          handle: NestedScrollView
                                              .sliverOverlapAbsorberHandleFor(
                                                  context)),
                                      SliverPadding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal:
                                              Nums.horizontalPaddingWidth,
                                          vertical: 16,
                                        ),
                                        sliver: _listOfWidgetsInGridView(state
                                            .houseModel.itemList
                                            .map((itemModel) {
                                          return ItemCardWidget(
                                            itemModel: itemModel,
                                            onDeletePressed: () {
                                              _houseCubit.deleteItem(itemModel);
                                            },
                                            onEditPressed: () {
                                              Navigator.pushNamed(
                                                context,
                                                AddItemPage.routeName,
                                                arguments: AddItemPageArguments(
                                                  onItemPressed:
                                                      (itemModel) async {
                                                    _houseCubit
                                                        .updateItem(itemModel);
                                                  },
                                                  itemLocationModel:
                                                      itemModel.locationModel,
                                                  isEditing: true,
                                                  itemModel: itemModel,
                                                ),
                                              );
                                            },
                                            onMovePressed: () {
                                              context
                                                  .read<MoveCubit>()
                                                  .copyStorageModel(() {
                                                _houseCubit.addItem(itemModel,
                                                    showSuccessSnackbar: false);
                                              }, () {
                                                _houseCubit.deleteItem(
                                                    itemModel,
                                                    showSuccessSnackbar: false);
                                              }, state.houseModel, itemModel);
                                            },
                                            onNavigateBack: () {
                                              context
                                                  .read<MoveCubit>()
                                                  .setParentStorageModel(
                                                      state.houseModel);
                                            },
                                          );
                                        }).toList()),
                                      ),
                                    ],
                                  );
                                })
                              : Center(
                                  child: Text(
                                  'No Items present',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground),
                                )),
                        ]
                      : [
                          const Center(child: LoadingWidget()),
                          const Center(child: LoadingWidget()),
                        ],
                ),
              ),
              floatingActionButton: AddFloatingActionButton(
                context: context,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AddRoomItemAlertDialog(
                        context: context,
                        onRoomPressed: () async {
                          final LocationModel roomLocationModel = LocationModel(
                            id: _idService.generateRandomId(),
                            house: widget.housePageArguments.houseModel.name,
                          );

                          await Navigator.pushNamed(
                            context,
                            AddRoomPage.routeName,
                            arguments: AddRoomPageArguments(
                              onRoomPressed: (roomModel) =>
                                  _houseCubit.addRoom(roomModel),
                              roomLocationModel: roomLocationModel,
                            ),
                          );
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                          _tabController.animateTo(0);
                        },
                        onItemPressed: () async {
                          final LocationModel itemLocationModel = LocationModel(
                            id: _idService.generateRandomId(),
                            house: widget.housePageArguments.houseModel.name,
                          );

                          await Navigator.pushNamed(
                            context,
                            AddItemPage.routeName,
                            arguments: AddItemPageArguments(
                              onItemPressed: (itemModel) =>
                                  _houseCubit.addItem(itemModel),
                              itemLocationModel: itemLocationModel,
                            ),
                          );
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                          _tabController.animateTo(1);
                        },
                      );
                    },
                  );
                },
              ),
              bottomSheet: BlocBuilder<MoveCubit, MoveState>(
                builder: (context, state) {
                  return context.read<MoveCubit>().canMoveHere()
                      ? MoveHereBottomSheet(
                          onCancelPressed: () {
                            context.read<MoveCubit>().cancelMove();
                          },
                          onMoveHerePressed: () {
                            context.read<MoveCubit>().moveStorageModel(
                              context,
                              () {
                                if (state.storageModel is RoomModel) {
                                  _houseCubit.addRoom(
                                      state.storageModel as RoomModel,
                                      showSuccessSnackbar: false);
                                } else if (state.storageModel is ItemModel) {
                                  _houseCubit.addItem(
                                      state.storageModel as ItemModel,
                                      showSuccessSnackbar: false);
                                }
                              },
                            );
                          },
                        )
                      : const SizedBox();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
