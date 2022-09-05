import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/colors.dart';
import 'package:weather_app/constants/image_paths.dart';
import 'package:weather_app/constants/string_datas.dart';
import 'package:weather_app/extension/context_extension.dart';
import 'package:weather_app/model/forecast_model.dart';
import 'package:weather_app/provider/main_provider.dart';
import 'package:weather_app/screens/components/background.dart';
import 'package:weather_app/screens/main_screen/components/custom_divider_view.dart';
import 'package:weather_app/screens/week_forecast_screen/components/future_forecast_detail_button.dart';
import 'package:weather_app/screens/week_forecast_screen/components/hourly_data.dart';
import 'package:weather_app/screens/week_forecast_screen/view_model/week_forecast_view_model.dart';

class FutureForecast extends StatefulWidget {
  const FutureForecast({Key? key}) : super(key: key);

  @override
  State<FutureForecast> createState() => _FutureForecastState();
}

class _FutureForecastState extends FutureForecastViewModel {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Background(),
        const SunOrMoonBackground(),
        const DetailBackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: _myAppBar(),
          body: Padding(
            padding: EdgeInsets.all(context.lowPaddingValue()),
            child: isLoading
                ? Center(
                    child: Lottie.asset(ImagePaths.loadingLottiePath),
                  )
                : Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(context.lowPaddingValue()),
                        child: SizedBox(
                          height: context.getDynamicHeight(0.25),
                          child: Center(
                            child: ListView.separated(
                              itemCount: context
                                  .watch<MainProvider>()
                                  .forecastDetailList
                                  .length,
                              separatorBuilder: (context, index) => Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: context.lowPaddingValue(),
                                ),
                              ),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => Center(
                                child: FutureForecastDetailButton(index: index),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                        child: ForecastDetailView(),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  AppBar _myAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        StringData.weekForecast,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }
}

class ForecastDetailView extends StatelessWidget {
  const ForecastDetailView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ForecastModel forecastModel =
        context.watch<MainProvider>().getSelectedForecastDetail() ??
            ForecastModel();
    return AnimatedOpacity(
      duration: context.lowDuration(),
      opacity: context.watch<MainProvider>().selectedIndexForDetailButtons == -1
          ? 0
          : 1,
      child: Container(
        decoration: BoxDecoration(
          color: ColorData.bottomNavigationBackgroundColor,
          borderRadius: context.mediumBorderRadius(),
        ),
        child: Padding(
          padding: EdgeInsets.all(context.lowPaddingValue()),
          child: Column(
            children: [
              const _DetailTitle(title: StringData.temperature),
              _DynamicTextRow(
                firstText:
                    '${StringData.low}: ${forecastModel.minTemp}${StringData.tempText}',
                secondText:
                    '${StringData.avg}: ${forecastModel.avgTemp}${StringData.tempText}',
                haveThird: true,
                thirdText:
                    '${StringData.high}: ${forecastModel.maxTemp}${StringData.tempText}',
              ),
              const CustomDivider(),
              const _DetailTitle(title: StringData.otherDetails),
              _DynamicTextRow(
                firstText:
                    '${StringData.wind}: ${forecastModel.maxWind} ${StringData.windUnit}',
                secondText:
                    '${StringData.humidity}: ${forecastModel.avgHumidity}%',
                haveThird: true,
                thirdText: '${StringData.uvIndex}: ${forecastModel.uv}',
              ),
              const CustomDivider(),
              const _DetailTitle(title: StringData.chanceOfRainAndSnow),
              _DynamicTextRow(
                firstText:
                    '${StringData.chanceOfRain}: ${forecastModel.dailyChanceOfRain}%',
                secondText:
                    '${StringData.chanceOfSnow}: ${forecastModel.dailyChanceOfSnow}%',
              ),
              const CustomDivider(),
              const _DetailTitle(title: StringData.allHours),
              const Expanded(
                child: HourlyDataListView(isCurrent: false),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HourlyDataListView extends StatelessWidget {
  const HourlyDataListView({
    Key? key,
    required this.isCurrent,
  }) : super(key: key);

  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    ForecastModel forecastModel = ForecastModel();

    if (isCurrent) {
      forecastModel = context.watch<MainProvider>().forecastModel;
    } else {
      forecastModel =
          context.watch<MainProvider>().getSelectedForecastDetail() ??
              ForecastModel();
    }
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: forecastModel.hourlyDatas?.length ?? 0,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => HourlyDataForDetail(
        hourlyData: forecastModel.hourlyDatas?[index] ?? HourlyData(),
      ),
    );
  }
}

class _DynamicTextRow extends StatelessWidget {
  const _DynamicTextRow({
    Key? key,
    required this.firstText,
    required this.secondText,
    this.haveThird = false,
    this.thirdText = '',
  }) : super(key: key);

  final String firstText;
  final String secondText;
  final bool haveThird;
  final String thirdText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: context.lowPaddingValue(),
      ),
      child: haveThird
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  firstText,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  secondText,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  thirdText,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  firstText,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  secondText,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
    );
  }
}

class _DetailTitle extends StatelessWidget {
  const _DetailTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .headline4
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}
