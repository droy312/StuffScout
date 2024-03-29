import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuff_scout/core/nums.dart';
import 'package:stuff_scout/core/widgets/delete_alert_dialog.dart';
import 'package:stuff_scout/core/widgets/more_popup_menu_button.dart';
import 'package:stuff_scout/core/widgets/unsplash_ink_well.dart';
import 'package:stuff_scout/features/home/presenter/cubits/home_cubit.dart';
import 'package:stuff_scout/features/home/presenter/pages/add_house_page.dart';
import 'package:stuff_scout/features/house/presenter/pages/house_page.dart';

import '../../../../house/data/models/house_model.dart';

class HouseCardWidget extends StatelessWidget {
  const HouseCardWidget({
    Key? key,
    required this.houseModel,
  }) : super(key: key);

  static const double _imageContainerBorderRadius =
      Nums.textFieldElevatedButtonBorderRadius * .75;
  static const double _cardPadding = 12;

  final HouseModel houseModel;

  @override
  Widget build(BuildContext context) {
    final double imageContainerSize = min(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height) *
        .25;
    final double containerHeight = imageContainerSize + 2 * _cardPadding;

    return UnsplashInkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          HousePage.routeName,
          arguments: HousePageArguments(houseModel: houseModel),
        );
      },
      child: Container(
        height: containerHeight,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 4,
              color: Theme.of(context).colorScheme.shadow,
            ),
          ],
          borderRadius: const BorderRadius.all(
              Radius.circular(Nums.textFieldElevatedButtonBorderRadius)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: _cardPadding,
            bottom: _cardPadding,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: _cardPadding),
                child: Container(
                  height: imageContainerSize,
                  width: imageContainerSize,
                  decoration: BoxDecoration(
                    color: houseModel.imageUrl == null
                        ? Theme.of(context).colorScheme.secondaryContainer
                        : null,
                    borderRadius: const BorderRadius.all(
                        Radius.circular(_imageContainerBorderRadius)),
                  ),
                  child: houseModel.imageUrl != null
                      ? ClipRRect(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(_imageContainerBorderRadius)),
                          child: Image.file(
                            File(houseModel.imageUrl!),
                            fit: BoxFit.cover,
                          ),
                        )
                      : Center(
                          child: Text(
                            houseModel.name[0].toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondaryContainer),
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: _cardPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        houseModel.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      if (houseModel.description != null)
                        Expanded(
                          child: Text(
                            houseModel.description!,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              MorePopupMenuButton(
                context: context,
                onDeletePressed: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return DeleteAlertDialog(
                        context: context,
                        label: 'Do you want to delete ${houseModel.name} House?',
                        onDeletePressed: () {
                          context.read<HomeCubit>().deleteHouse(houseModel);

                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        },
                        onCancelPressed: () {
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
                onEditPressed: () {
                  Navigator.pushNamed(
                    context,
                    AddHousePage.routeName,
                    arguments: AddHousePageArguments(
                      onHousePressed: (houseModel) async {
                        context.read<HomeCubit>().updateHouse(houseModel);
                      },
                      isEditing: true,
                      houseModel: houseModel,
                    ),
                  );
                },
                iconColor: Theme.of(context).colorScheme.onBackground,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
