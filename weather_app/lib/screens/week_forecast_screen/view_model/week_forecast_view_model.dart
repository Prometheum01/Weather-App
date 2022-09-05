import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/extension/context_extension.dart';
import 'package:weather_app/mixins/forecast_fetch_mixin.dart';
import 'package:weather_app/mixins/loading_mixin.dart';
import 'package:weather_app/model/forecast_model.dart';
import 'package:weather_app/provider/main_provider.dart';
import 'package:weather_app/screens/week_forecast_screen/view/week_forecast_view.dart';
import 'package:weather_app/service/shared_service/shared_manager.dart';

abstract class FutureForecastViewModel extends State<FutureForecast>
    with PrepareValueForFetching, LoadingMixin {
  List<ForecastModel?> forecastDetailList = [];
  SharedManager sharedManager = SharedManager();

  @override
  void initState() {
    super.initState();
    init();
  }

  changeLoadingWithSetState() {
    setState(() {
      changeLoading();
    });
  }

  Future<void> getDataForDays(int days) async {
    // ignore: use_build_context_synchronously
    if (await context.read<MainProvider>().getInternetConnectionStatus() ==
        InternetConnectionStatus.connected) {
      for (int i = 1; i <= days; i++) {
        forecastDetailList.add(
          await prepareValues(
              date:
                  '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day + i}',
              isCurrent: false),
        );
      }

      sharedManager.setWeekForecastData(forecastDetailList);
    } else {
      try {
        if (sharedManager.getWeekForecastData() != null) {
          if (sharedManager.getWeekForecastData()!.isNotEmpty) {
            forecastDetailList = sharedManager.getWeekForecastData()!;
          } else {
            showMessage();
          }
        } else {
          showMessage();
        }
      } catch (e) {
        showMessage();
      }
    }

    // ignore: use_build_context_synchronously
    context.read<MainProvider>().setForecastDetailList(forecastDetailList);
  }

  showMessage() {
    showSnackBar(
        title: 'Network Error',
        message:
            "You don't have internet connection. You have to connect internet.",
        type: ContentType.failure);
    Future.delayed(
      context.highDuration() * 4,
      () {
        Navigator.pop(context);
      },
    );
  }

  void showSnackBar(
      {required String title,
      required String message,
      required ContentType type}) {
    var snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: type,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> init() async {
    changeLoadingWithSetState();
    await sharedManager.init();
    await getDataForDays(7);
    changeLoadingWithSetState();
  }
}
