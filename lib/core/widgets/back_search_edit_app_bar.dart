import 'package:flutter/material.dart';
import 'package:stuff_scout/core/nums.dart';
import 'package:stuff_scout/core/widgets/back_icon_button.dart';
import 'package:stuff_scout/core/widgets/search_icon_button.dart';

class BackSearchSliverAppBar extends SliverAppBar {
  BackSearchSliverAppBar({
    Key? key,
    required BuildContext context,
    required String title,
    String? description,
    String? backgroundImageUrl,
    PreferredSize? bottom,
    Function()? onSearchPressed,
  }) : super(
          key: key,
          elevation: 0,
          expandedHeight: 220,
          scrolledUnderElevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: Theme.of(context).colorScheme.primary,
          pinned: true,
          leading: BackIconButton(
            context: context,
            iconColor: Theme.of(context).colorScheme.onPrimary,
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
          actions: [
            SearchIconButton(
              context: context,
              iconColor: Theme.of(context).colorScheme.onPrimary,
              onPressed: onSearchPressed,
            )
          ],
          bottom: bottom,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Stack(
                children: [
                  if (backgroundImageUrl != null) ...[
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      child: Image.network(
                        backgroundImageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(color: Colors.black38),
                  ],
                  Positioned(
                    bottom: Nums.horizontalPaddingWidth + 36,
                    right: Nums.horizontalPaddingWidth,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              key: key,
                              elevation: 4,
                              shadowColor: Theme.of(context).colorScheme.shadow,
                              backgroundColor:
                                  Theme.of(context).colorScheme.background,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16))),
                              title: Text(
                                'Description',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                              ),
                              content: Text(
                                description ?? 'No description present',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                              ),
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .onPrimary
                            .withOpacity(.4),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                      ),
                      child: Text(
                        'Description',
                        style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
}
