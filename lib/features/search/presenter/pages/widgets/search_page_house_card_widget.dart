import 'package:flutter/material.dart';
import 'package:stuff_scout/core/widgets/unsplash_ink_well.dart';
import 'package:stuff_scout/features/house/data/models/house_model.dart';
import 'package:stuff_scout/features/house/presenter/pages/house_page.dart';

class SearchPageHouseCardWidget extends StatelessWidget {
  const SearchPageHouseCardWidget({
    Key? key,
    required this.houseModel,
  }) : super(key: key);

  final HouseModel houseModel;

  @override
  Widget build(BuildContext context) {
    final Color borderColor =
        Theme.of(context).colorScheme.onBackground.withOpacity(.2);

    return UnsplashInkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          HousePage.routeName,
          arguments: HousePageArguments(houseModel: houseModel),
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
        child: Text(houseModel.name),
      ),
    );
  }
}
