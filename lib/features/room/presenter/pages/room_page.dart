import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuff_scout/core/widgets/room_container_page_widget.dart';
import 'package:stuff_scout/features/room/domain/entities/room_entity.dart';
import 'package:stuff_scout/features/room/presenter/cubits/room_cubit.dart';

class RoomPageArguments {
  const RoomPageArguments({required this.roomEntity});

  final RoomEntity roomEntity;
}

class RoomPage extends StatelessWidget {
  RoomPage({
    Key? key,
    required this.roomPageArguments,
  }) : super(key: key);

  static const String routeName = '/room';

  final RoomPageArguments roomPageArguments;

  final RoomCubit _roomCubit = RoomCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RoomCubit>.value(
      value: _roomCubit,
      child: BlocBuilder<RoomCubit, RoomState>(
        builder: (context, state) {
          return RoomContainerPageWidget(
            title: roomPageArguments.roomEntity.name,
            locationModel: roomPageArguments.roomEntity.locationModel,
            roomCubit: _roomCubit,
            containerList: state.containerList,
            itemList: state.itemList,
          );
        },
      ),
    );
  }
}
