import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/colors.dart';
import 'package:weather_app/constants/string_datas.dart';
import 'package:weather_app/extension/context_extension.dart';
import 'package:weather_app/navigator/nav_routes.dart';
import 'package:weather_app/provider/main_provider.dart';
import 'package:weather_app/screens/main_screen/components/forecast_custom_button.dart';
import 'package:weather_app/screens/main_screen/components/small_data_view.dart';
import 'package:weather_app/screens/main_screen/components/temp_detail_view.dart';
import 'package:weather_app/screens/main_screen/components/weather_temp_view.dart';
import 'package:weather_app/screens/week_forecast_screen/view/week_forecast_view.dart';

import 'custom_divider_view.dart';
import 'other_detail_view.dart';

class BottomSheetView extends StatelessWidget {
  const BottomSheetView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: context.mediumDuration(),
      color: ColorData.bottomNavigationBackgroundColor,
      child: context.watch<MainProvider>().isOpen
          ? Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: context.lowPaddingValue()),
                  child: const WeatherTempView(inDetail: true),
                ),
                const TempDetails(),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: context.lowPaddingValue()),
                  child: const SmallDatas(),
                ),
                const CustomDivider(),
                const OtherDetails(),
                const CustomDivider(),
                Text(
                  StringData.hourly,
                  style: Theme.of(context).textTheme.headline5,
                ),
                const Expanded(
                  child: HourlyDataListView(isCurrent: true),
                ),
              ],
            )
          : Padding(
              padding:
                  EdgeInsets.symmetric(vertical: context.lowPaddingValue()),
              child: Column(
                children: [
                  const SmallDatas(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.mediumPaddingValue(),
                      vertical: context.lowPaddingValue(),
                    ),
                    child: ForecastCustomButton(
                      title: StringData.weekForecast,
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          Routes.weekForecast.toPath(),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
