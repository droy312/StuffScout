import 'package:flutter/material.dart';
import 'package:stuff_scout/core/widgets/unsplash_ink_well.dart';
import 'package:stuff_scout/features/room/domain/entities/room_entity.dart';
import 'package:stuff_scout/features/room/presenter/pages/room_page.dart';

class RoomCardWidget extends StatelessWidget {
  const RoomCardWidget({
    Key? key,
    required this.roomEntity,
  }) : super(key: key);

  final RoomEntity roomEntity;

  @override
  Widget build(BuildContext context) {
    final Color borderColor =
        Theme.of(context).colorScheme.onBackground.withOpacity(.2);

    return UnsplashInkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          RoomPage.routeName,
          arguments:
              RoomPageArguments(roomEntity: roomEntity),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              roomEntity.name,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ],
        ),
      ),
    );
  }
}
