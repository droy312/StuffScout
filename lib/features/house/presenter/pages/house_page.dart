import 'package:flutter/material.dart';
import 'package:stuff_scout/core/nums.dart';
import 'package:stuff_scout/features/house/presenter/pages/widgets/room_card_widget.dart';

class HousePage extends StatelessWidget {
  const HousePage({Key? key}) : super(key: key);

  static const String routeName = '/house';

  static const double _titleContainerTopAndBottomPadding = 16;

  static const String _testHouseDescription =
      'This is the description of my house. My house is located in Haldia, West Bengal, India. It is a industrial town with many chemical, oil and sugar industries.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Theme.of(context).colorScheme.onPrimary,
            size: Nums.iconSize,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.onPrimary,
              size: Nums.iconSize,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications,
              color: Theme.of(context).colorScheme.onPrimary,
              size: Nums.iconSize,
            ),
          ),
        ],
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
                const SizedBox(height: _titleContainerTopAndBottomPadding),
                Text(
                  'House Name',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  _testHouseDescription,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        child: Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimaryContainer),
      ),
    );
  }
}
