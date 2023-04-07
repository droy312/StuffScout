import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuff_scout/core/enums/storage_enums.dart';
import 'package:stuff_scout/core/widgets/loading_widget.dart';
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

  Widget _listOfWidgetsInGridView(List<Widget> list) {
    return GridView.count(
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      padding: const EdgeInsets.symmetric(
        horizontal: Nums.horizontalPaddingWidth,
        vertical: 16,
      ),
      crossAxisCount: 2,
      physics: const BouncingScrollPhysics(),
      children: list,
    );
  }

  @override
  void initState() {
    super.initState();

    context.read<RoomCubit>().init(context, widget.roomPageArguments.roomModel);
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: BlocBuilder<RoomCubit, RoomState>(
        builder: (context, state) {
          return Scaffold(
            appBar: BackSearchEditAppBar(
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
              onMovePressed: () {},
              onEditPressed: () {},
              onDeletePressed: () {
                context.read<RoomCubit>().deleteRoom(context);
              },
            ),
            body: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).colorScheme.primary,
                  padding: const EdgeInsets.symmetric(
                      horizontal: Nums.horizontalPaddingWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),

                      // Title
                      Text(
                        widget.roomPageArguments.roomModel.name,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                      const SizedBox(height: 4),

                      // Description
                      if (widget.roomPageArguments.roomModel.description !=
                          null)
                        Text(
                          widget.roomPageArguments.roomModel.description!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary
                                        .withOpacity(.6),
                                  ),
                        ),
                      const SizedBox(height: 16),

                      // Location
                      Text(
                        'Location',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.roomPageArguments.roomModel.locationModel
                            .toLocationString(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimary
                                .withOpacity(.6)),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                TabBar(
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
                Expanded(
                  // Containers and Items
                  child: TabBarView(
                    controller: _tabController,
                    children: !state.isLoading
                        ? [
                            state.roomModel.containerList.isNotEmpty
                                ? _listOfWidgetsInGridView(state
                                    .roomModel.containerList
                                    .map((containerModel) {
                                    return ContainerCardWidget(
                                        containerModel: containerModel);
                                  }).toList())
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
                                ? _listOfWidgetsInGridView(
                                    state.roomModel.itemList.map((itemModel) {
                                    return ItemCardWidget(
                                      itemModel: itemModel,
                                      itemStorage: ItemStorage.room,
                                    );
                                  }).toList())
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
              ],
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
                            onAddContainerPressed: (containerModel) => context
                                .read<RoomCubit>()
                                .addContainer(context, containerModel),
                            containerLocationModel: widget
                                .roomPageArguments.roomModel.locationModel
                                .addRoom(widget.roomPageArguments.roomModel),
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
                            onAddItemPressed: (itemModel) => context
                                .read<RoomCubit>()
                                .addItem(context, itemModel),
                            itemLocationModel: widget
                                .roomPageArguments.roomModel.locationModel
                                .addRoom(widget.roomPageArguments.roomModel),
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
          );
        },
      ),
    );
  }
}
