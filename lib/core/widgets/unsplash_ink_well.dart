import 'package:flutter/material.dart';

class UnsplashInkWell extends InkWell {
  UnsplashInkWell({
    Key? key,
    Function()? onTap,
    Widget? child,
  }) : super(
          key: key,
          onTap: onTap,
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          child: child,
        );
}
