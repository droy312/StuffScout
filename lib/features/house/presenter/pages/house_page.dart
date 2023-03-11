import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuff_scout/core/models/location_model.dart';
import 'package:stuff_scout/core/nums.dart';
import 'package:stuff_scout/core/services/id_service.dart';
import 'package:stuff_scout/core/widgets/back_search_edit_app_bar.dart';
import 'package:stuff_scout/core/widgets/loading_widget.dart';
import 'package:stuff_scout/features/house/presenter/cubits/house_cubit.dart';
import 'package:stuff_scout/features/house/presenter/pages/widgets/room_card_widget.dart';

import '../../../../service_locator.dart';
import '../../../../core/widgets/add_floating_action_button.dart';
import '../../../room/data/models/room_model.dart';
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

class _HousePageState extends State<HousePage> {
  static const double _titleContainerTopAndBottomPadding = 16;

  late final HouseCubit _houseCubit;

  final IdService _idService = sl<IdService>();

  @override
  void initState() {
    super.initState();

    _houseCubit = HouseCubit(
      context: context,
      houseModel: widget.housePageArguments.houseModel,
    );
    _houseCubit.init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HouseCubit>.value(
      value: _houseCubit,
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
                  const SizedBox(
                      height: _titleContainerTopAndBottomPadding),
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
                      style:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
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
                  const SizedBox(
                      height: _titleContainerTopAndBottomPadding),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<HouseCubit, HouseState>(
                builder: (context, state) {
                  if (state.houseModel.roomList.isEmpty) {
                    return Center(
                        child: Text(
                          'No Rooms present',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.onBackground),
                        ));
                  }
                  return !state.isLoading
                      ? ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.houseModel.roomList.length + 1,
                          // 1 extra for the top SizedBox
                          itemBuilder: (_, index) {
                            if (index == 0) {
                              return const SizedBox(height: 16);
                            }
                            index--;
                            final RoomModel roomModel =
                                state.houseModel.roomList[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                      horizontal: Nums.horizontalPaddingWidth)
                                  .copyWith(bottom: 16),
                              child: RoomCardWidget(roomModel: roomModel),
                            );
                          },
                        )
                      : const Center(child: LoadingWidget(size: 24));
                },
              ),
            ),
          ],
        ),
        floatingActionButton: AddFloatingActionButton(
          context: context,
          onPressed: () {
            final LocationModel roomLocationModel = LocationModel(
              id: _idService.generateRandomId(),
              house: widget.housePageArguments.houseModel.name,
            );

            Navigator.pushNamed(
              context,
              AddRoomPage.routeName,
              arguments: AddRoomPageArguments(
                onAddRoomPressed: _houseCubit.addRoom,
                roomLocationModel: roomLocationModel,
              ),
            );
          },
        ),
      ),
    );
  }
}
