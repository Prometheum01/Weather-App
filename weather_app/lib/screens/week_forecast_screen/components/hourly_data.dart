import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/constants/colors.dart';
import 'package:weather_app/constants/image_paths.dart';
import 'package:weather_app/constants/string_datas.dart';
import 'package:weather_app/extension/context_extension.dart';
import 'package:weather_app/model/forecast_model.dart';

class HourlyDataForDetail extends StatelessWidget {
  const HourlyDataForDetail({
    Key? key,
    required this.hourlyData,
  }) : super(key: key);

  final HourlyData hourlyData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(hourlyData.iconWithHttps),
        Padding(
          padding: EdgeInsets.all(context.lowPaddingValue()),
          child: Text(
            DateFormat('j').format(hourlyData.localDate),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              ImagePaths.tempIconPath,
              height: 12,
            ),
            Text(
              ' ${hourlyData.temp}${StringData.tempText}',
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(context.lowPaddingValue()),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                ImagePaths.waterdropPath,
                height: 12,
                color: ColorData.iconColor,
              ),
              Text(
                '${hourlyData.humidity}%',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
