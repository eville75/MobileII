import 'package:flutter_application_1/Shared/colors.dart';
import 'package:flutter_application_1/Shared/sytle.dart';

import 'action_button_view_model.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final ActionButtonViewModel viewModel;

  const ActionButton({Key? key, required this.viewModel}) : super(key: key);

  static Widget instance({required ActionButtonViewModel viewModel,}) {
    return ActionButton(viewModel: viewModel);
  }

  @override
  Widget build(BuildContext context) {

    double verticalPadding = 12.0;
    double horizontalPadding = 16.0;
    Color backgroundColor = primaryColor;
    double size = 16; 
    TextStyle textStyle = regular;

    switch (viewModel.style) {
      case ActionButtonStyle.primary:
        backgroundColor = primaryColor;
      case ActionButtonStyle.secondary:
        backgroundColor = secondaryColor;
      case ActionButtonStyle.tertiary:
        backgroundColor = tertiaryColor;
    }
    switch (viewModel.size) {
      case ActionButtonSize.small:
        size =16;
      case ActionButtonSize.medium:
        size = 24;
      case ActionButtonSize.large:
        size = 32;
    }

    return ElevatedButton(
      onPressed: viewModel.onPressed,
      style: ElevatedButton.styleFrom(
        textStyle: regular,
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: horizontalPadding,
        ),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (viewModel.icon != null)
            Icon(viewModel.icon, size: size),
          SizedBox(width: 8.0),
          Text(
            viewModel.text,
            style: textStyle.copyWith(fontSize: size),
          ),
        ],
      ),
    );
  }
}