import 'package:flutter/material.dart';
import 'package:weather_app/constants/colors.dart';
import 'package:weather_app/extension/context_extension.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 0.75,
      color: ColorData.customDividerColor,
      indent: context.getDynamicWidth(0.05),
      endIndent: context.getDynamicWidth(0.05),
      height: context.lowPaddingValue(),
    );
  }
}
