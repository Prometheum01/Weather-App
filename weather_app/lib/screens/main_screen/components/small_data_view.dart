import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/string_datas.dart';
import 'package:weather_app/model/forecast_model.dart';
import 'package:weather_app/provider/main_provider.dart';

class SmallDatas extends StatelessWidget {
  const SmallDatas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ForecastModel forecastModel = context.watch<MainProvider>().forecastModel;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SmallDataColumn(
          title: StringData.sunrise,
          data: forecastModel.sunrise.toString(),
        ),
        SmallDataColumn(
          title: StringData.wind,
          data: '${forecastModel.wind} ${StringData.windUnit}',
        ),
        SmallDataColumn(
          title: StringData.sunset,
          data: forecastModel.sunset.toString(),
        ),
      ],
    );
  }
}

class SmallDataColumn extends StatelessWidget {
  const SmallDataColumn({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);

  final String title, data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline5,
        ),
        Text(
          data,
          style: Theme.of(context).textTheme.headline6,
        )
      ],
    );
  }
}
