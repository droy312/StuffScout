import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuff_scout/core/models/location_model.dart';
import 'package:stuff_scout/core/nums.dart';
import 'package:stuff_scout/core/services/id_service.dart';
import 'package:stuff_scout/core/widgets/back_search_edit_app_bar.dart';
import 'package:stuff_scout/core/widgets/loading_widget.dart';
import 'package:stuff_scout/features/house/presenter/cubits/house_cubit.dart';
import 'package:stuff_scout/features/house/presenter/pages/widgets/add_room_item_dialog.dart';
import 'package:stuff_scout/features/house/presenter/pages/widgets/room_card_widget.dart';

import '../../../../core/pages/add_item_page.dart';
import '../../../../core/widgets/item_card_widget.dart';
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
  static const double _titleContainerTopAndBottomPadding = 16;

  late final HouseCubit _houseCubit;

  final IdService _idService = sl<IdService>();

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

    _houseCubit = HouseCubit(
      context: context,
      houseModel: widget.housePageArguments.houseModel,
    );
    _houseCubit.init();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HouseCubit>.value(
      value: _houseCubit,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: BackSearchEditAppBar(context: context),
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
                    const SizedBox(height: _titleContainerTopAndBottomPadding),
                    Text(
                      widget.housePageArguments.houseModel.name,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                    const SizedBox(height: 4),

                    // Description
                    if (widget.housePageArguments.houseModel.description !=
                        null)
                      Text(
                        widget.housePageArguments.houseModel.description!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimary
                                  .withOpacity(.6),
                            ),
                      ),
                    const SizedBox(height: 16),
                    Text(
                      'Location',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'https://goo.gl/maps/HdRczVX9i6sPaJsR8',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.blue[400]),
                    ),
                    const SizedBox(height: _titleContainerTopAndBottomPadding),
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
                child: BlocBuilder<HouseCubit, HouseState>(
                  builder: (context, state) {
                    return TabBarView(
                      controller: _tabController,
                      children: !state.isLoading
                          ? [
                              state.houseModel.roomList.isNotEmpty
                                  ? _listOfWidgetsInGridView(state
                                      .houseModel.roomList
                                      .map((roomModel) {
                                      return RoomCardWidget(
                                          roomModel: roomModel);
                                    }).toList())
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
                                  ? _listOfWidgetsInGridView(state
                                      .houseModel.itemList
                                      .map((itemModel) {
                                      return ItemCardWidget(
                                          itemModel: itemModel);
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
                              const Center(child: LoadingWidget(size: 24)),
                              const Center(child: LoadingWidget(size: 24)),
                            ],
                    );
                  },
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
                  return AddRoomItemAlertDialog(
                    context: context,
                    onRoomPressed: () async {
                      final LocationModel roomLocationModel = LocationModel(
                        id: _idService.generateRandomId(),
                        house: widget.housePageArguments.houseModel.name,
                      );

                      Navigator.pop(context);
                      await Navigator.pushNamed(
                        context,
                        AddRoomPage.routeName,
                        arguments: AddRoomPageArguments(
                          onAddRoomPressed: _houseCubit.addRoom,
                          roomLocationModel: roomLocationModel,
                        ),
                      );
                      _tabController.animateTo(0);
                    },
                    onItemPressed: () async {
                      final LocationModel itemLocationModel = LocationModel(
                        id: _idService.generateRandomId(),
                        house: widget.housePageArguments.houseModel.name,
                      );

                      Navigator.pop(context);
                      await Navigator.pushNamed(
                        context,
                        AddItemPage.routeName,
                        arguments: AddItemPageArguments(
                          onAddItemPressed: _houseCubit.addItem,
                          itemLocationModel: itemLocationModel,
                        ),
                      );
                      _tabController.animateTo(1);
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
