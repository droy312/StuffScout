import 'package:flutter/material.dart';
import 'package:stuff_scout/core/nums.dart';
import 'package:stuff_scout/core/widgets/menu_icon_button.dart';
import 'package:stuff_scout/core/widgets/notification_icon_button.dart';
import 'package:stuff_scout/features/home/presenter/pages/widgets/house_card_widget.dart';
import 'package:stuff_scout/features/home/presenter/pages/widgets/search_bar_widget.dart';
import 'package:stuff_scout/features/home/presenter/pages/widgets/user_image_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String routeName = '/home';
  static const double _userImageSize = 80;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: MenuIconButton(
          context: context,
          onPressed: () {},
        ),
        actions: [
          NotificationIconButton(
            context: context,
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: Nums.horizontalPaddingWidth),
              SizedBox(
                height: _userImageSize + 16,
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text(
                    'Welcome\nDhritiman',
                    style: TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ),
              const Spacer(),
              const UserImageWidget(size: _userImageSize),
              const SizedBox(width: Nums.horizontalPaddingWidth),
            ],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Nums.horizontalPaddingWidth),
            child: SearchBarWidget(
              context: context,
              hintText: 'Search Rooms, Containers, Items...',
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Nums.horizontalPaddingWidth + 12),
                  child: Text(
                    'Houses',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                const SizedBox(height: 12),
                const Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Nums.horizontalPaddingWidth),
                  child: HouseCardWidget(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
