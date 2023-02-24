import 'package:flutter/material.dart';
import 'package:stuff_scout/core/nums.dart';
import 'package:stuff_scout/core/widgets/back_search_notification_app_bar.dart';
import 'package:stuff_scout/features/house/domain/entities/house_entity.dart';
import 'package:stuff_scout/features/house/presenter/pages/widgets/room_card_widget.dart';

import '../../../../core/widgets/add_floating_action_button.dart';

class HousePage extends StatelessWidget {
  const HousePage({
    Key? key,
    required this.housePageArguments,
  }) : super(key: key);

  static const String routeName = '/house';

  static const double _titleContainerTopAndBottomPadding = 16;
  
  final HousePageArguments housePageArguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  housePageArguments.houseEntity.name,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                const SizedBox(height: 4),
                if (housePageArguments.houseEntity.description != null)
                  Text(
                    housePageArguments.houseEntity.description!,
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
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Theme.of(context).colorScheme.onPrimary),
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
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 10 + 1, // 1 extra for the top SizedBox
              itemBuilder: (_, index) {
                if (index == 0) {
                  return const SizedBox(height: 16);
                }
                index--;
                return Padding(
                  padding: const EdgeInsets.symmetric(
                          horizontal: Nums.horizontalPaddingWidth)
                      .copyWith(bottom: 16),
                  child: const RoomCardWidget(roomName: 'Bed Rooom'),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: AddFloatingActionButton(
        context: context,
        onPressed: () {},
      ),
    );
  }
}

class HousePageArguments {
  const HousePageArguments({required this.houseEntity});

  final HouseEntity houseEntity;
}
