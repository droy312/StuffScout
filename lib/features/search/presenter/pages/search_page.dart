import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuff_scout/core/nums.dart';
import 'package:stuff_scout/core/widgets/back_icon_button.dart';
import 'package:stuff_scout/core/widgets/loading_widget.dart';
import 'package:stuff_scout/features/home/presenter/pages/widgets/search_bar_widget.dart';
import 'package:stuff_scout/features/search/presenter/cubits/search_cubit.dart';
import 'package:stuff_scout/features/search/presenter/pages/widgets/search_page_container_card_widget.dart';
import 'package:stuff_scout/features/search/presenter/pages/widgets/search_page_house_card_widget.dart';
import 'package:stuff_scout/features/search/presenter/pages/widgets/search_page_item_card_widget.dart';
import 'package:stuff_scout/features/search/presenter/pages/widgets/search_page_room_card_widget.dart';

import '../../../container/data/models/container_model.dart';
import '../../../house/data/models/house_model.dart';
import '../../../room/data/models/room_model.dart';

class SearchPageArguments {
  const SearchPageArguments({
    required this.title,
    required this.hintText,
    this.heroTag,
    this.houseList,
    this.houseModel,
    this.roomModel,
    this.containerModel,
  });

  final String title;
  final String hintText;
  final String? heroTag;
  final List<HouseModel>? houseList;
  final HouseModel? houseModel;
  final RoomModel? roomModel;
  final ContainerModel? containerModel;
}

class SearchPage extends StatefulWidget {
  const SearchPage({
    Key? key,
    required this.searchPageArguments,
  }) : super(key: key);

  static const String routeName = '/search';

  final SearchPageArguments searchPageArguments;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();

    context.read<SearchCubit>().initSearchList(
          context: context,
          houseList: widget.searchPageArguments.houseList,
          houseModel: widget.searchPageArguments.houseModel,
          roomModel: widget.searchPageArguments.roomModel,
          containerModel: widget.searchPageArguments.containerModel,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: BackIconButton(context: context),
            titleSpacing: 0,
            actions: const [SizedBox(width: Nums.horizontalPaddingWidth)],
            title: Text(
              widget.searchPageArguments.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Nums.horizontalPaddingWidth),
            child: Column(
              children: [
                Hero(
                  tag: widget.searchPageArguments.heroTag ?? '',
                  child: Material(
                    child: SearchBarTextField(
                      context: context,
                      hintText: widget.searchPageArguments.hintText,
                      onChanged: (searchText) {
                        context
                            .read<SearchCubit>()
                            .searchModelListFromLists(searchText);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: !state.isLoading
                      ? (state.searchedItemList.isNotEmpty ||
                              state.searchedContainerList.isNotEmpty ||
                              state.searchedRoomList.isNotEmpty ||
                              state.searchedHouseList.isNotEmpty)
                          ? SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (state.searchedItemList.isNotEmpty) ...[
                                    const Text('Items'),
                                    const SizedBox(height: 4),
                                    Column(
                                      children: state.searchedItemList
                                          .map((itemModel) => Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8),
                                                child: SearchPageItemCardWidget(
                                                    itemModel: itemModel),
                                              ))
                                          .toList(),
                                    ),
                                    const SizedBox(height: 12),
                                  ],
                                  if (state
                                      .searchedContainerList.isNotEmpty) ...[
                                    const Text('Containers'),
                                    const SizedBox(height: 4),
                                    Column(
                                      children: state.searchedContainerList
                                          .map((containerModel) => Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8),
                                                child:
                                                    SearchPageContainerCardWidget(
                                                        containerModel:
                                                            containerModel),
                                              ))
                                          .toList(),
                                    ),
                                    const SizedBox(height: 12),
                                  ],
                                  if (state.searchedRoomList.isNotEmpty) ...[
                                    const Text('Rooms'),
                                    const SizedBox(height: 4),
                                    Column(
                                      children: state.searchedRoomList
                                          .map((roomModel) => Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8),
                                                child: SearchPageRoomCardWidget(
                                                    roomModel: roomModel),
                                              ))
                                          .toList(),
                                    ),
                                    const SizedBox(height: 12),
                                  ],
                                  if (state.searchedHouseList.isNotEmpty) ...[
                                    const Text('Houses'),
                                    const SizedBox(height: 4),
                                    Column(
                                      children: state.searchedHouseList
                                          .map((houseModel) => Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8),
                                                child:
                                                    SearchPageHouseCardWidget(
                                                        houseModel: houseModel),
                                              ))
                                          .toList(),
                                    ),
                                    const SizedBox(height: 12),
                                  ],
                                  const SizedBox(height: 100),
                                ],
                              ),
                            )
                          : const Center(
                              child: Text(
                                  'No elements present'))
                      : const Center(child: LoadingWidget()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
