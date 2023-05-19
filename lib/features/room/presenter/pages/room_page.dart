import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuff_scout/core/widgets/loading_widget.dart';
import 'package:stuff_scout/core/widgets/move_here_bottom_sheet.dart';
import 'package:stuff_scout/features/container/data/models/container_model.dart';
import 'package:stuff_scout/features/item/data/models/item_model.dart';
import 'package:stuff_scout/features/room/data/models/room_model.dart';
import 'package:stuff_scout/features/room/presenter/cubits/room_cubit.dart';
import 'package:stuff_scout/features/search/presenter/pages/search_page.dart';

import '../../../../core/nums.dart';
import '../../../../core/pages/add_container_page.dart';
import '../../../../core/pages/add_item_page.dart';
import '../../../../core/widgets/add_container_item_alert_dialog.dart';
import '../../../../core/widgets/add_floating_action_button.dart';
import '../../../../core/widgets/back_search_edit_app_bar.dart';
import '../../../../core/widgets/container_card_widget.dart';
import '../../../../core/widgets/item_card_widget.dart';
import '../../../move/presenter/cubits/move_cubit.dart';

class RoomPageArguments {
  const RoomPageArguments({required this.roomModel});

  final RoomModel roomModel;
}

class RoomPage extends StatefulWidget {
  const RoomPage({
    Key? key,
    required this.roomPageArguments,
  }) : super(key: key);

  static const String routeName = '/room';

  final RoomPageArguments roomPageArguments;

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  late final RoomCubit _roomCubit;

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

    _roomCubit = RoomCubit(
      context: context,
      roomModel: widget.roomPageArguments.roomModel,
    );
    _roomCubit.init();
    _tabController = TabController(length: 2, vsync: this);

    if (context.mounted) {
      context
          .read<MoveCubit>()
          .setParentStorageModel(widget.roomPageArguments.roomModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RoomCubit>.value(
      value: _roomCubit,
      child: DefaultTabController(
        length: 2,
        child: BlocBuilder<RoomCubit, RoomState>(
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
                                  'Search in ${widget.roomPageArguments.roomModel.name}',
                              hintText: 'Search containers, items...',
                              roomModel: widget.roomPageArguments.roomModel,
                            ),
                          );
                        },
                        title: widget.roomPageArguments.roomModel.name,
                        description:
                            widget.roomPageArguments.roomModel.description,
                        backgroundImageUrl:
                            widget.roomPageArguments.roomModel.imageUrl,
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
                                Text('Containers'),
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
                          state.roomModel.containerList.isNotEmpty
                              ? Builder(builder: (context) {
                                  return CustomScrollView(
                                    key: const PageStorageKey('containerList'),
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
                                            .roomModel.containerList
                                            .map((containerModel) {
                                          return ContainerCardWidget(
                                            containerModel: containerModel,
                                            onDeletePressed: () {
                                              _roomCubit.deleteContainer(
                                                  containerModel);
                                            },
                                            onEditPressed: () async {
                                              Navigator.pushNamed(
                                                context,
                                                AddContainerPage.routeName,
                                                arguments:
                                                    AddContainerPageArguments(
                                                  onContainerPressed:
                                                      (containerModel) async {
                                                    _roomCubit.updateContainer(
                                                        containerModel);
                                                  },
                                                  containerLocationModel:
                                                      containerModel
                                                          .locationModel,
                                                  isEditing: true,
                                                  containerModel:
                                                      containerModel,
                                                ),
                                              );
                                            },
                                            onMovePressed: () {
                                              context
                                                  .read<MoveCubit>()
                                                  .copyStorageModel(() {
                                                _roomCubit.addContainer(
                                                    containerModel,
                                                    showSuccessSnackbar: false);
                                              }, () {
                                                _roomCubit.deleteContainer(
                                                    containerModel,
                                                    showSuccessSnackbar: false);
                                              }, state.roomModel,
                                                      containerModel);
                                            },
                                            onNavigateBack: () {
                                              context
                                                  .read<MoveCubit>()
                                                  .setParentStorageModel(
                                                      state.roomModel);
                                            },
                                          );
                                        }).toList()),
                                      ),
                                    ],
                                  );
                                })
                              : Center(
                                  child: Text(
                                  'No Containers present',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground),
                                )),
                          state.roomModel.itemList.isNotEmpty
                              ? Builder(builder: (context) {
                                  return CustomScrollView(
                                    key: const PageStorageKey('itemList'),
                                    slivers: [
                                      SliverOverlapInjector(
                                        handle: NestedScrollView
                                            .sliverOverlapAbsorberHandleFor(
                                                context),
                                      ),
                                      SliverPadding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal:
                                              Nums.horizontalPaddingWidth,
                                          vertical: 16,
                                        ),
                                        sliver: _listOfWidgetsInGridView(state
                                            .roomModel.itemList
                                            .map((itemModel) {
                                          return ItemCardWidget(
                                            itemModel: itemModel,
                                            onDeletePressed: () {
                                              _roomCubit.deleteItem(itemModel);
                                            },
                                            onEditPressed: () async {
                                              Navigator.pushNamed(
                                                context,
                                                AddItemPage.routeName,
                                                arguments: AddItemPageArguments(
                                                  onItemPressed:
                                                      (itemModel) async {
                                                    _roomCubit
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
                                                _roomCubit.addItem(itemModel,
                                                    showSuccessSnackbar: false);
                                              }, () {
                                                _roomCubit.deleteItem(itemModel,
                                                    showSuccessSnackbar: false);
                                              }, state.roomModel, itemModel);
                                            },
                                            onNavigateBack: () {
                                              context
                                                  .read<MoveCubit>()
                                                  .setParentStorageModel(
                                                      state.roomModel);
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
                      return AddContainerItemAlertDialog(
                        context: context,
                        onContainerPressed: () async {
                          await Navigator.pushNamed(
                            context,
                            AddContainerPage.routeName,
                            arguments: AddContainerPageArguments(
                              onContainerPressed: (containerModel) =>
                                  _roomCubit.addContainer(containerModel),
                              containerLocationModel: state
                                  .roomModel.locationModel
                                  .addRoom(state.roomModel),
                            ),
                          );
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                          _tabController.animateTo(0);
                        },
                        onItemPressed: () async {
                          await Navigator.pushNamed(
                            context,
                            AddItemPage.routeName,
                            arguments: AddItemPageArguments(
                              onItemPressed: (itemModel) =>
                                  _roomCubit.addItem(itemModel),
                              itemLocationModel: state.roomModel.locationModel
                                  .addRoom(state.roomModel),
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
                                if (state.storageModel is ContainerModel) {
                                  _roomCubit.addContainer(
                                      state.storageModel as ContainerModel,
                                      showSuccessSnackbar: false);
                                } else if (state.storageModel is ItemModel) {
                                  _roomCubit.addItem(
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
