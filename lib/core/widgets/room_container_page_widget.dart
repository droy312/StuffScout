import 'package:flutter/material.dart';
import 'package:stuff_scout/core/models/location_model.dart';
import 'package:stuff_scout/core/nums.dart';
import 'package:stuff_scout/core/widgets/add_container_item_alert_dialog.dart';
import 'package:stuff_scout/core/widgets/add_floating_action_button.dart';
import 'package:stuff_scout/core/widgets/container_card_widget.dart';
import 'package:stuff_scout/features/container/domain/entities/container_entity.dart';
import 'package:stuff_scout/features/room/presenter/cubits/room_cubit.dart';
import '../../features/item/domain/entities/item_entity.dart';
import '../../features/room/presenter/pages/add_container_page.dart';
import 'back_search_notification_app_bar.dart';
import 'item_card_widget.dart';

class RoomContainerPageWidget extends StatefulWidget {
  const RoomContainerPageWidget({
    Key? key,
    required this.title,
    required this.locationModel,
    this.roomCubit,
    this.containerList = const [],
    this.itemList = const [],
  }) : super(key: key);

  final String title;
  final LocationModel locationModel;
  final RoomCubit? roomCubit;
  final List<ContainerEntity> containerList;
  final List<ItemEntity> itemList;

  @override
  State<RoomContainerPageWidget> createState() =>
      _RoomContainerPageWidgetState();
}

class _RoomContainerPageWidgetState extends State<RoomContainerPageWidget>
    with SingleTickerProviderStateMixin {
  static const double _titleContainerTopAndBottomPadding = 16;

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

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: BackSearchNotificationAppBar(context: context),
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

                  // Title
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
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
                    widget.locationModel.toLocationString(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimary
                            .withOpacity(.6)),
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
              // Containers and Items
              child: TabBarView(
                controller: _tabController,
                children: [
                  _listOfWidgetsInGridView(
                      widget.containerList.map((containerEntity) {
                    return ContainerCardWidget(
                        containerEntity: containerEntity);
                  }).toList()),
                  _listOfWidgetsInGridView(widget.itemList.map((itemEntity) {
                    return ItemCardWidget(itemEntity: itemEntity);
                  }).toList()),
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
                    Navigator.pop(context);
                    if (widget.roomCubit != null) {
                      await Navigator.pushNamed(
                        context,
                        AddContainerPage.routeName,
                        arguments: AddContainerPageArguments(
                          roomCubit: widget.roomCubit!,
                          locationModel: widget.locationModel,
                        ),
                      );
                      _tabController.animateTo(0);
                    }
                  },
                  // TODO: Add functionality for adding item in room
                  onItemPressed: () {},
                );
              },
            );
          },
        ),
      ),
    );
  }
}
