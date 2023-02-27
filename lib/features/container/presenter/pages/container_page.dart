import 'package:flutter/material.dart';

import '../../../../core/nums.dart';
import '../../../../core/pages/add_container_page.dart';
import '../../../../core/widgets/add_container_item_alert_dialog.dart';
import '../../../../core/widgets/add_floating_action_button.dart';
import '../../../../core/widgets/back_search_notification_app_bar.dart';
import '../../../../core/widgets/container_card_widget.dart';
import '../../../../core/widgets/item_card_widget.dart';
import '../../domain/entities/container_entity.dart';

class ContainerPageArguments {
  const ContainerPageArguments({required this.containerEntity});

  final ContainerEntity containerEntity;
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
                  const SizedBox(height: 16),

                  // Title
                  Text(
                    widget.containerPageArguments.containerEntity.name,
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
                    widget.containerPageArguments.containerEntity.locationModel
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
                children: [
                  _listOfWidgetsInGridView(widget
                      .containerPageArguments.containerEntity.containerList
                      .map((containerEntity) {
                    return ContainerCardWidget(
                        containerEntity: containerEntity);
                  }).toList()),
                  _listOfWidgetsInGridView(widget
                      .containerPageArguments.containerEntity.itemList
                      .map((itemEntity) {
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
                    await Navigator.pushNamed(
                      context,
                      AddContainerPage.routeName,
                      arguments: AddContainerPageArguments(
                        onAddContainerPressed: (containerEntity) {
                          // TODO: Add container to container
                        },
                        containerLocationModel: widget.containerPageArguments
                            .containerEntity.locationModel
                            .addContainer(
                                widget.containerPageArguments.containerEntity),
                      ),
                    );
                    _tabController.animateTo(0);
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
