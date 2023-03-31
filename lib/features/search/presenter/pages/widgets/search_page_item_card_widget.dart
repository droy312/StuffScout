import 'package:flutter/material.dart';
import 'package:stuff_scout/core/widgets/unsplash_ink_well.dart';

import '../../../../item/data/models/item_model.dart';
import '../../../../item/presenter/pages/item_page.dart';

class SearchPageItemCardWidget extends StatelessWidget {
  const SearchPageItemCardWidget({
    Key? key,
    required this.itemModel,
  }) : super(key: key);

  final ItemModel itemModel;

  @override
  Widget build(BuildContext context) {
    final Color borderColor =
    Theme.of(context).colorScheme.onBackground.withOpacity(.2);

    return UnsplashInkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          ItemPage.routeName,
          arguments: ItemPageArguments(itemModel: itemModel),
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
        child: Text(itemModel.name),
      ),
    );
  }
}
