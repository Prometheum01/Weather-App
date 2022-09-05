import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/image_paths.dart';
import 'package:weather_app/constants/string_datas.dart';
import 'package:weather_app/extension/context_extension.dart';
import 'package:weather_app/model/forecast_model.dart';
import 'package:weather_app/provider/main_provider.dart';

class WeatherTempView extends StatelessWidget {
  const WeatherTempView({
    super.key,
    this.inDetail = false,
  });

  final bool inDetail;

  @override
  Widget build(BuildContext context) {
    ForecastModel forecastModel = context.watch<MainProvider>().forecastModel;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(forecastModel.iconWithHttps),
            SvgPicture.asset(ImagePaths.tempIconPath),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  forecastModel.currentTemp.toString(),
                  style: inDetail
                      ? Theme.of(context).textTheme.headline1
                      : Theme.of(context).textTheme.headlineLarge,
                ),
                Padding(
                  padding: EdgeInsets.only(top: context.lowPaddingValue()),
                  child: Text(
                    StringData.tempText,
                    style: inDetail
                        ? Theme.of(context)
                            .textTheme
                            .headline3
                            ?.copyWith(fontWeight: FontWeight.bold)
                        : Theme.of(context).textTheme.headline2,
                  ),
                ),
              ],
            ),
          ],
        ),
        Text(
          forecastModel.conditionText.toString(),
          style: Theme.of(context).textTheme.headline3,
        ),
      ],
    );
  }
}
