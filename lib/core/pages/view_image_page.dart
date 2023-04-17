import 'dart:io';

import 'package:flutter/material.dart';

import '../widgets/back_icon_button.dart';

class ViewImagePageArguments {
  const ViewImagePageArguments({required this.imageUrl});

  final String imageUrl;
}

class ViewImagePage extends StatelessWidget {
  const ViewImagePage({
    Key? key,
    required this.viewImagePageArguments,
  }) : super(key: key);

  static const String routeName = '/view_image';

  final ViewImagePageArguments viewImagePageArguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: key,
        elevation: 0,
        scrolledUnderElevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: BackIconButton(
          context: context,
          iconColor: Theme.of(context).colorScheme.onBackground,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.file(
              File(viewImagePageArguments.imageUrl),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
