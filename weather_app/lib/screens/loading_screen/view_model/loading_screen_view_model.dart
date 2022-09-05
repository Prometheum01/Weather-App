// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/mixins/forecast_fetch_mixin.dart';
import 'package:weather_app/model/forecast_model.dart';
import 'package:weather_app/navigator/nav_routes.dart';
import 'package:weather_app/provider/main_provider.dart';
import 'package:weather_app/screens/loading_screen/view/loading_screen_view.dart';
import 'package:weather_app/service/shared_service/shared_manager.dart';

abstract class LoadingScreenViewModel extends State<LoadingScreen>
    with PrepareValueForFetching {
  SharedManager sharedManager = SharedManager();

  InternetConnectionStatus internetConnectionStatus =
      InternetConnectionStatus.disconnected;

  bool isListen = true;

  @override
  void initState() {
    super.initState();

    listenInternetConnection();
  }

  @override
  void dispose() {
    super.dispose();
  }

  stopListener() {
    setState(() {
      isListen = false;
    });
  }

  listenInternetConnection() async {
    await sharedManager.init();
    return InternetConnectionChecker().onStatusChange.listen(
      (status) async {
        if (isListen) {
          switch (status) {
            case InternetConnectionStatus.connected:
              setState(() {
                internetConnectionStatus = InternetConnectionStatus.connected;
              });

              ForecastModel forecastModel = await prepareValues();

              await sharedManager.setCurrentForecastData(forecastModel);
              setValues(forecastModel);
              break;
            case InternetConnectionStatus.disconnected:
              setState(() {
                internetConnectionStatus =
                    InternetConnectionStatus.disconnected;
              });

              try {
                if (sharedManager.getCurrentForecastData() != null) {
                  setValues(sharedManager.getCurrentForecastData()!);
                }
              } catch (e) {
                showSnackBar(
                    title: 'Network Error',
                    message:
                        "You don't have internet connection. You have to connect internet to use this app in first time",
                    type: ContentType.failure);
              }

              break;
          }
        }
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

  setValues(ForecastModel forecastModel) {
    stopListener();
    context.read<MainProvider>().setForecastModel(forecastModel);
    context.read<MainProvider>().checkBackground();
    Navigator.of(context).popAndPushNamed(Routes.home.toPath());
  }
}
