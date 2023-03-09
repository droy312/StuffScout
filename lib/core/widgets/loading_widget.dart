import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
    this.color,
    this.size = 20,
  }) : super(key: key);

  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SpinKitThreeBounce(
      color: color ?? Theme.of(context).colorScheme.primary,
      size: size,
    );
  }
}
