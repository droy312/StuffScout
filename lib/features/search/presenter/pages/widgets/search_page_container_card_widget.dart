import 'package:flutter/material.dart';
import 'package:stuff_scout/core/widgets/unsplash_ink_well.dart';
import 'package:stuff_scout/features/container/data/models/container_model.dart';

import '../../../../container/presenter/pages/container_page.dart';

class SearchPageContainerCardWidget extends StatelessWidget {
  const SearchPageContainerCardWidget({
    Key? key,
    required this.containerModel,
  }) : super(key: key);

  final ContainerModel containerModel;

  @override
  Widget build(BuildContext context) {
    final Color borderColor =
    Theme.of(context).colorScheme.onBackground.withOpacity(.2);

    return UnsplashInkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          ContainerPage.routeName,
          arguments: ContainerPageArguments(containerModel: containerModel),
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
        child: Text(containerModel.name),
      ),
    );
  }
}
