import 'package:flutter/material.dart';
import 'package:weather_app/constants/colors.dart';
import 'package:weather_app/extension/context_extension.dart';

class ForecastCustomButton extends StatelessWidget {
  const ForecastCustomButton({
    Key? key,
    required this.onPressed,
    required this.title,
  }) : super(key: key);

  final Function onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: context.smallBorderRadius(),
      onTap: () {
        onPressed();
      },
      child: Ink(
        height: context.getDynamicHeight(0.05),
        decoration: BoxDecoration(
          color: ColorData.forecastButtonBackgroundColor,
          borderRadius: context.smallBorderRadius(),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(context.lowPaddingValue()),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
      ),
    );
  }
}
