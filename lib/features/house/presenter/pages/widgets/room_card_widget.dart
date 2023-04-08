import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuff_scout/core/widgets/room_container_item_card_widget.dart';
import 'package:stuff_scout/features/house/presenter/cubits/house_cubit.dart';

import '../../../../room/data/models/room_model.dart';
import '../../../../room/presenter/pages/room_page.dart';
import '../../../../../core/widgets/unsplash_ink_well.dart';

class RoomCardWidget extends StatelessWidget {
  const RoomCardWidget({
    Key? key,
    this.size = 40,
    required this.roomModel,
  }) : super(key: key);

  final double size;
  final RoomModel roomModel;

  @override
  Widget build(BuildContext context) {
    return UnsplashInkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          RoomPage.routeName,
          arguments: RoomPageArguments(roomModel: roomModel),
        );
      },
      child: RoomContainerItemCardWidget(
        label: roomModel.name,
        imageUrl: roomModel.imageUrl,
        onDeletePressed: () {
          context.read<HouseCubit>().deleteRoom(roomModel);
        },
      ),
    );
  }
}
