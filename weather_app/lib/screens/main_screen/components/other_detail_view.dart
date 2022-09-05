import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/string_datas.dart';
import 'package:weather_app/extension/context_extension.dart';
import 'package:weather_app/model/forecast_model.dart';
import 'package:weather_app/provider/main_provider.dart';

class OtherDetails extends StatelessWidget {
  const OtherDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ForecastModel forecastModel = context.watch<MainProvider>().forecastModel;
    return Column(
      children: [
        Text(
          StringData.details,
          style: Theme.of(context).textTheme.headline4,
        ),
        SizedBox(
          width: context.getDynamicWidth(0.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(StringData.humidity,
                  style: Theme.of(context).textTheme.headline5),
              Text('${forecastModel.humidity}%',
                  style: Theme.of(context).textTheme.headline5)
            ],
          ),
        ),
        SizedBox(
          width: context.getDynamicWidth(0.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(StringData.uvIndex,
                  style: Theme.of(context).textTheme.headline5),
              Text('${forecastModel.uv}',
                  style: Theme.of(context).textTheme.headline5)
            ],
          ),
        ),
      ],
    );
  }
}
