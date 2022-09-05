import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/colors.dart';
import 'package:weather_app/constants/string_datas.dart';
import 'package:weather_app/extension/context_extension.dart';
import 'package:weather_app/model/forecast_model.dart';
import 'package:weather_app/provider/main_provider.dart';

class FutureForecastDetailButton extends StatefulWidget {
  const FutureForecastDetailButton({Key? key, required this.index})
      : super(key: key);

  final int index;

  @override
  State<FutureForecastDetailButton> createState() =>
      _FutureForecastDetailButtonState();
}

class _FutureForecastDetailButtonState
    extends State<FutureForecastDetailButton> {
  @override
  Widget build(BuildContext context) {
    List<ForecastModel?> forecastDetailList =
        context.watch<MainProvider>().forecastDetailList;

    int selectedIndex =
        context.watch<MainProvider>().selectedIndexForDetailButtons;

    return InkWell(
      onTap: () {
        if (selectedIndex == widget.index) {
          context.read<MainProvider>().changeSelectedIndexForDetail(-1);
        } else {
          context
              .read<MainProvider>()
              .changeSelectedIndexForDetail(widget.index);
        }
      },
      borderRadius: context.mediumBorderRadius(),
      splashColor: selectedIndex == widget.index
          ? ColorData.blackSplashColor
          : ColorData.whiteSplashColor,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: context.mediumBorderRadius(),
          color: selectedIndex == widget.index
              ? ColorData.whiteSplashColor
              : ColorData.blackSplashColor,
        ),
        child: Padding(
          padding: EdgeInsets.all(context.mediumPaddingValue()),
          child: Column(
            children: [
              Image.network(
                scale: 1,
                forecastDetailList[widget.index]?.iconWithHttps ?? 'Na',
              ),
              Text(
                forecastDetailList[widget.index]?.conditionText ?? 'Na',
                style: Theme.of(context).textTheme.headline3,
              ),
              Text(
                  '${forecastDetailList[widget.index]?.avgTemp}${StringData.tempText}',
                  style: Theme.of(context).textTheme.headline3)
            ],
          ),
        ),
      ),
    );
  }
}
