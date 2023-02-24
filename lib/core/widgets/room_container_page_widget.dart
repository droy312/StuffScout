import 'package:flutter/material.dart';
import 'package:stuff_scout/core/nums.dart';
import 'package:stuff_scout/core/widgets/add_floating_action_button.dart';
import 'package:stuff_scout/core/widgets/container_card_widget.dart';
import 'package:stuff_scout/core/widgets/item_card_widget.dart';

import 'back_search_notification_app_bar.dart';

class RoomContainerPageWidget extends StatelessWidget {
  const RoomContainerPageWidget({
    Key? key,
    required this.title,
    required this.location,
  }) : super(key: key);

  static const double _titleContainerTopAndBottomPadding = 16;

  final String title;
  final String location;

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
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
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
                    location,
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
            const TabBar(
              labelPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              tabs: [
                Text('Containers'),
                Text('Items'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _listOfWidgetsInGridView(List.generate(
                    10,
                    (index) {
                      return const ContainerCardWidget(
                          containerName: 'Container Name');
                    },
                  )),
                  _listOfWidgetsInGridView(List.generate(
                    10,
                    (index) {
                      return const ItemCardWidget(itemName: 'Item Name');
                    },
                  )),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: AddFloatingActionButton(
          context: context,
          onPressed: () {},
        ),
      ),
    );
  }
}
