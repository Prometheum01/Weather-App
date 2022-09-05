import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/model/forecast_model.dart';
import 'package:weather_app/provider/main_provider.dart';

class LocationView extends StatelessWidget {
  const LocationView({
    Key? key,
    required this.textAlign,
  }) : super(key: key);

  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    ForecastModel forecastModel = context.watch<MainProvider>().forecastModel;

    String formattedDate =
        '${DateFormat('E').format(forecastModel.localDate)}, ${DateFormat('d').format(forecastModel.localDate)} ${DateFormat('MMMM').format(forecastModel.localDate)} ${DateFormat('jm').format(forecastModel.localDate)}';

    return RichText(
      textAlign: textAlign,
      text: TextSpan(
          text: '${forecastModel.location}\n',
          style: Theme.of(context).textTheme.headline4,
          children: [
            TextSpan(
              text: formattedDate,
              style: Theme.of(context).textTheme.headline5,
            ),
          ]),
    );
  }
}
