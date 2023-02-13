import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Palette will give the primary, primaryDark
/// secondary, secondaryDark colors of the app.
///
/// These colors will not change whatever the theme is.
class Palette extends Cubit {
  Palette() : super(null);

  late final Color primary;
  late final Color primaryDark;
  late final Color secondary;
  late final Color secondaryDark;

  /// Get colors from backend
  Future<void> getColors() async {
    primary = const Color(0xff6C00FF);
    primaryDark = const Color(0xff5E00DE);
    secondary = const Color(0xff3C79F5);
    secondaryDark = const Color(0xff3468D0);
  }
}