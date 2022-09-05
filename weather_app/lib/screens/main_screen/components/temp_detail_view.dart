import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/string_datas.dart';
import 'package:weather_app/model/forecast_model.dart';
import 'package:weather_app/provider/main_provider.dart';

class TempDetails extends StatelessWidget {
  const TempDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ForecastModel forecastModel = context.watch<MainProvider>().forecastModel;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          '${StringData.high}:${forecastModel.maxTemp}°C',
          style: Theme.of(context).textTheme.headline5,
        ),
        Text(
          '${StringData.low}:${forecastModel.minTemp}°C',
          style: Theme.of(context).textTheme.headline5,
        ),
        Text(
          '${StringData.precip}:${forecastModel.precip}%',
          style: Theme.of(context).textTheme.headline5,
        ),
      ],
    );
  }
}
