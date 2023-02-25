import 'package:flutter/material.dart';
import 'package:stuff_scout/core/models/location_model.dart';
import 'package:stuff_scout/core/nums.dart';
import 'package:stuff_scout/core/widgets/add_floating_action_button.dart';
import 'back_search_notification_app_bar.dart';

class RoomContainerPageWidget extends StatelessWidget {
  const RoomContainerPageWidget({
    Key? key,
    required this.title,
    required this.locationModel,
  }) : super(key: key);

  static const double _titleContainerTopAndBottomPadding = 16;

  final String title;
  final LocationModel locationModel;

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

                  // Title
                  Text(
                    title,
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
                    locationModel.toLocationString(),
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
              // Containers and Items
              child: TabBarView(
                children: [
                  _listOfWidgetsInGridView([]),
                  _listOfWidgetsInGridView([]),
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
