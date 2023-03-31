import 'package:flutter/material.dart';
import 'package:stuff_scout/core/nums.dart';

/// When tapped on the search bar the search bar will navigate to search page
class SearchBarTextField extends TextField {
  SearchBarTextField({
    Key? key,
    required BuildContext context,
    String? hintText,
    TextStyle? hintStyle,
    Function(String)? onChanged,
    bool obscureText = false,
    bool enabled = true,
  }) : super(
          key: key,
          onChanged: onChanged,
          obscureText: obscureText,
          cursorColor: Theme.of(context).colorScheme.primary,
          cursorRadius: const Radius.circular(10),
          enabled: enabled,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            hintText: hintText,
            hintStyle: hintStyle ??
                Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
            enabledBorder: _border(context, 1),
            focusedBorder: _border(context, 2),
            disabledBorder: _border(context, 1),
            suffixIcon: Icon(
              Icons.search,
              size: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        );

  static OutlineInputBorder _border(BuildContext context, double width) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(
          Radius.circular(Nums.textFieldElevatedButtonBorderRadius)),
      borderSide: BorderSide(
        width: width,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
