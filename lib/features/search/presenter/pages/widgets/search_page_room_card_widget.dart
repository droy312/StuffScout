import 'package:flutter/material.dart';
import 'package:stuff_scout/core/widgets/unsplash_ink_well.dart';

import '../../../../room/data/models/room_model.dart';
import '../../../../room/presenter/pages/room_page.dart';

class SearchPageRoomCardWidget extends StatelessWidget {
  const SearchPageRoomCardWidget({
    Key? key,
    required this.roomModel,
  }) : super(key: key);

  final RoomModel roomModel;

  @override
  Widget build(BuildContext context) {
    final Color borderColor =
    Theme.of(context).colorScheme.onBackground.withOpacity(.2);

    return UnsplashInkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          RoomPage.routeName,
          arguments: RoomPageArguments(roomModel: roomModel),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(
            width: 1,
            color: borderColor,
          ),
        ),
        child: Text(roomModel.name),
      ),
    );
  }
}
