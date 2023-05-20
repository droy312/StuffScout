import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuff_scout/core/pages/add_item_page.dart';
import 'package:stuff_scout/core/widgets/loading_widget.dart';
import 'package:stuff_scout/features/container/presenter/cubits/container_cubit.dart';

import '../../../../core/nums.dart';
import '../../../../core/pages/add_container_page.dart';
import '../../../../core/widgets/add_container_item_alert_dialog.dart';
import '../../../../core/widgets/add_floating_action_button.dart';
import '../../../../core/widgets/back_search_sliver_app_bar.dart';
import '../../../../core/widgets/container_card_widget.dart';
import '../../../../core/widgets/item_card_widget.dart';
import '../../../../core/widgets/move_here_bottom_sheet.dart';
import '../../../item/data/models/item_model.dart';
import '../../../move/presenter/cubits/move_cubit.dart';
import '../../../search/presenter/pages/search_page.dart';
import '../../data/models/container_model.dart';

class ContainerPageArguments {
  const ContainerPageArguments({required this.containerModel});

  final ContainerModel containerModel;
}

class ContainerPage extends StatefulWidget {
  const ContainerPage({
    Key? key,
    required this.containerPageArguments,
  }) : super(key: key);

  static const String routeName = '/container';

  final ContainerPageArguments containerPageArguments;

  @override
  State<ContainerPage> createState() => _ContainerPageState();
}

class _ContainerPageState extends State<ContainerPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  late final ContainerCubit _containerCubit;

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

    _containerCubit = ContainerCubit(
      context: context,
      containerModel: widget.containerPageArguments.containerModel,
    );
    _containerCubit.init();
    _tabController = TabController(length: 2, vsync: this);

    if (context.mounted) {
      context
          .read<MoveCubit>()
          .setParentStorageModel(widget.containerPageArguments.containerModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContainerCubit>.value(
      value: _containerCubit,
      child: DefaultTabController(
        length: 2,
        child: BlocBuilder<ContainerCubit, ContainerState>(
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
                                  'Search in ${widget.containerPageArguments.containerModel.name}',
                              hintText: 'Search containers, items...',
                              containerModel:
                                  widget.containerPageArguments.containerModel,
                            ),
                          );
                        },
                        title:
                            widget.containerPageArguments.containerModel.name,
                        description: widget
                            .containerPageArguments.containerModel.description,
                        backgroundImageFilePath: widget
                            .containerPageArguments.containerModel.imageUrl,
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
                          state.containerModel.containerList.isNotEmpty
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
                                            .containerModel.containerList
                                            .map((containerModel) {
                                          return ContainerCardWidget(
                                            containerModel: containerModel,
                                            onDeletePressed: () {
                                              _containerCubit.deleteContainer(
                                                  containerModel);
                                            },
                                            onEditPressed: () {
                                              Navigator.pushNamed(
                                                context,
                                                AddContainerPage.routeName,
                                                arguments:
                                                    AddContainerPageArguments(
                                                  onContainerPressed:
                                                      (containerModel) async {
                                                    _containerCubit
                                                        .updateContainer(
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
                                                _containerCubit.addContainer(
                                                    containerModel,
                                                    showSuccessSnackbar: false);
                                              }, () {
                                                _containerCubit.deleteContainer(
                                                    containerModel,
                                                    showSuccessSnackbar: false);
                                              }, state.containerModel,
                                                      containerModel);
                                            },
                                            onNavigateBack: () {
                                              context
                                                  .read<MoveCubit>()
                                                  .setParentStorageModel(
                                                      state.containerModel);
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
                          state.containerModel.itemList.isNotEmpty
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
                                            .containerModel.itemList
                                            .map((itemModel) {
                                          return ItemCardWidget(
                                            itemModel: itemModel,
                                            onDeletePressed: () {
                                              _containerCubit
                                                  .deleteItem(itemModel);
                                            },
                                            onEditPressed: () {
                                              Navigator.pushNamed(
                                                context,
                                                AddItemPage.routeName,
                                                arguments: AddItemPageArguments(
                                                  onItemPressed:
                                                      (itemModel) async {
                                                    _containerCubit
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
                                                _containerCubit.addItem(
                                                    itemModel,
                                                    showSuccessSnackbar: false);
                                              }, () {
                                                _containerCubit.deleteItem(
                                                    itemModel,
                                                    showSuccessSnackbar: false);
                                              }, state.containerModel,
                                                      itemModel);
                                            },
                                            onNavigateBack: () {
                                              context
                                                  .read<MoveCubit>()
                                                  .setParentStorageModel(
                                                      state.containerModel);
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
                                  _containerCubit.addContainer(containerModel),
                              containerLocationModel: state
                                  .containerModel.locationModel
                                  .addContainer(state.containerModel),
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
                                  _containerCubit.addItem(itemModel),
                              itemLocationModel: state
                                  .containerModel.locationModel
                                  .addContainer(state.containerModel),
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
                                  _containerCubit.addContainer(
                                      state.storageModel as ContainerModel,
                                      showSuccessSnackbar: false);
                                } else if (state.storageModel is ItemModel) {
                                  _containerCubit.addItem(
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
