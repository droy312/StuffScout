import 'package:flutter/material.dart';
import 'package:stuff_scout/core/nums.dart';
import 'package:stuff_scout/core/widgets/add_floating_action_button.dart';
import 'package:stuff_scout/core/widgets/loading_widget.dart';
import 'package:stuff_scout/core/widgets/menu_icon_button.dart';
import 'package:stuff_scout/core/widgets/notification_icon_button.dart';
import 'package:stuff_scout/core/widgets/unsplash_ink_well.dart';
import 'package:stuff_scout/features/home/presenter/cubits/home_cubit.dart';
import 'package:stuff_scout/features/home/presenter/pages/widgets/house_card_widget.dart';
import 'package:stuff_scout/features/home/presenter/pages/widgets/search_bar_widget.dart';
import 'package:stuff_scout/features/home/presenter/pages/widgets/user_image_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../search/presenter/pages/search_page.dart';
import 'add_house_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const double _userImageSize = 80;
  static const String _searchBarHintText =
      'Search houses, rooms, containers, items...';

  late final HomeCubit _homeCubit;

  final String _heroTag = 'searchBarTextField${HomePage.routeName}';

  @override
  void initState() {
    super.initState();

    _homeCubit = HomeCubit(context: context);
    _homeCubit.init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>.value(
      value: _homeCubit,
      child: Scaffold(
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
            // Header
            Row(
              children: [
                const SizedBox(width: Nums.horizontalPaddingWidth),
                SizedBox(
                  height: _userImageSize + 16,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .5,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        'Welcome',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
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
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return Hero(
                    tag: _heroTag,
                    child: Material(
                      child: UnsplashInkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            SearchPage.routeName,
                            arguments: SearchPageArguments(
                              title: 'Search',
                              hintText: _searchBarHintText,
                              heroTag: _heroTag,
                              houseList: state.houseList,
                            ),
                          );
                        },
                        child: SearchBarTextField(
                          context: context,
                          hintText: _searchBarHintText,
                          enabled: false,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),

            // House list
            Expanded(
              child: BlocBuilder<HomeCubit, HomeState>(
                bloc: _homeCubit,
                builder: (context, state) {
                  if (state.houseList.isEmpty) {
                    return Center(
                        child: Text(
                      'No Houses present',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                    ));
                  }
                  return !state.isLoading
                      ? ListView(
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
                            ...state.houseList.map((houseModel) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                        horizontal: Nums.horizontalPaddingWidth)
                                    .copyWith(bottom: 16),
                                child: HouseCardWidget(houseModel: houseModel),
                              );
                            })
                          ],
                        )
                      : const Center(child: LoadingWidget());
                },
              ),
            ),
          ],
        ),
        floatingActionButton: AddFloatingActionButton(
          context: context,
          onPressed: () {
            Navigator.pushNamed(
              context,
              AddHousePage.routeName,
              arguments:
                  AddHousePageArguments(onAddHousePressed: _homeCubit.addHouse),
            );
          },
        ),
      ),
    );
  }
}
