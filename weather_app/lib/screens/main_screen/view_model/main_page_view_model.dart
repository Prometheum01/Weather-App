import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/mixins/forecast_fetch_mixin.dart';
import 'package:weather_app/model/forecast_model.dart';
import 'package:weather_app/provider/main_provider.dart';
import 'package:weather_app/screens/main_screen/view/main_page.dart';

abstract class MainPageViewModel extends State<MainPage>
    with PrepareValueForFetching {
  late ForecastModel forecastModel;

  final double closedValue = 0.25;
  final double openedValue = 0.8;

  bool isAnimate = false;

  late double expander = closedValue;

  @override
  void initState() {
    context.read<MainProvider>().listenInternetConnection();
    forecastModel = context.read<MainProvider>().forecastModel;
    super.initState();
  }

  refreshData() async {
    changeAnimate();
    context.read<MainProvider>().setForecastModel(
          await prepareValues(),
        );
    changeAnimate();
  }

  changeAnimate() {
    setState(() {
      isAnimate = !isAnimate;
    });
  }

  changeExpander() {
    context.read<MainProvider>().changeOpenStatus();
    if (expander == closedValue) {
      setState(() {
        expander = openedValue;
      });
    } else {
      setState(() {
        expander = closedValue;
      });
    }
  }
}
