import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuff_scout/core/models/location_model.dart';
import 'package:stuff_scout/core/nums.dart';
import 'package:stuff_scout/core/services/id_service.dart';
import 'package:stuff_scout/core/widgets/back_search_notification_app_bar.dart';
import 'package:stuff_scout/features/house/domain/entities/house_entity.dart';
import 'package:stuff_scout/features/house/presenter/cubits/house_cubit.dart';
import 'package:stuff_scout/features/house/presenter/pages/widgets/room_card_widget.dart';

import '../../../../core/service_locator.dart';
import '../../../../core/widgets/add_floating_action_button.dart';
import '../../../room/domain/entities/room_entity.dart';
import 'add_room_page.dart';

class HousePage extends StatelessWidget {
  HousePage({
    Key? key,
    required this.housePageArguments,
  }) : super(key: key) {
    _houseCubit = HouseCubit(houseEntity: housePageArguments.houseEntity);
  }

  static const String routeName = '/house';

  static const double _titleContainerTopAndBottomPadding = 16;

  late final HouseCubit _houseCubit;

  final IdService _idService = sl<IdService>();

  final HousePageArguments housePageArguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HouseCubit>.value(
      value: _houseCubit,
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
                  const SizedBox(height: _titleContainerTopAndBottomPadding),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<HouseCubit, HouseState>(
                builder: (context, state) {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.houseEntity.roomList.length + 1,
                    // 1 extra for the top SizedBox
                    itemBuilder: (_, index) {
                      if (index == 0) {
                        return const SizedBox(height: 16);
                      }
                      index--;
                      final RoomEntity roomEntity = state.houseEntity.roomList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                                horizontal: Nums.horizontalPaddingWidth)
                            .copyWith(bottom: 16),
                        child: RoomCardWidget(roomEntity: roomEntity),
                      );
                    },
                  );
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
              house: housePageArguments.houseEntity.name,
            );

            Navigator.pushNamed(
              context,
              AddRoomPage.routeName,
              arguments: AddRoomPageArguments(
                onAddRoomPressed: (roomEntity) {
                  _houseCubit.addRoom(roomEntity);
                },
                roomLocationModel: roomLocationModel,
              ),
            );
          },
        ),
      ),
    );
  }
}

class HousePageArguments {
  const HousePageArguments({required this.houseEntity});

  final HouseEntity houseEntity;
}
