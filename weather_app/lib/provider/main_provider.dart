import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:weather_app/constants/image_paths.dart';
import 'package:weather_app/model/forecast_model.dart';

class MainProvider extends ChangeNotifier {
  late ForecastModel forecastModel;

  List<ForecastModel?> forecastDetailList = [];

  bool isOpen = false;

  String backgrounPath = ImagePaths.afterSunriseBackgroundPath;

  String backgroundSunOrMoon = ImagePaths.sunBackground;

  int selectedIndexForDetailButtons = -1;

  late InternetConnectionStatus internetConnectionStatus;

  ForecastModel? getSelectedForecastDetail() {
    if (selectedIndexForDetailButtons != -1) {
      return forecastDetailList[selectedIndexForDetailButtons];
    } else {
      return ForecastModel();
    }
  }

  checkBackground() {
    if (forecastModel.sunrise != null && forecastModel.sunset != null) {
      if (forecastModel.formattedSunriseHour.inMinutes <= 60 &&
          forecastModel.formattedSunriseHour.inMinutes >= 0) {
        backgrounPath = ImagePaths.sunriseBackgroundPath;
        backgroundSunOrMoon = ImagePaths.sunBackground;
      } else if (forecastModel.formattedSunriseHour.inMinutes > 1 &&
          forecastModel.formattedSunsetHour.inMinutes < 0) {
        backgrounPath = ImagePaths.afterSunriseBackgroundPath;
        backgroundSunOrMoon = ImagePaths.sunBackground;
      } else if (forecastModel.formattedSunsetHour.inMinutes < 6 * 60 &&
          forecastModel.formattedSunsetHour.inMinutes >= 0) {
        backgrounPath = ImagePaths.afterSunsetBackgroundPath;
        backgroundSunOrMoon = ImagePaths.moonBackground;
      } else {
        backgrounPath = ImagePaths.beforeSunriseBackgroundPath;
        backgroundSunOrMoon = ImagePaths.moonBackground;
      }
    }
    notifyListeners();
  }

  getInternetConnectionStatus() async {
    internetConnectionStatus =
        await InternetConnectionChecker().connectionStatus;
    return internetConnectionStatus;
  }

  listenInternetConnection() {
    InternetConnectionChecker().onStatusChange.listen(
      (status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            internetConnectionStatus = InternetConnectionStatus.connected;
            notifyListeners();
            break;
          case InternetConnectionStatus.disconnected:
            internetConnectionStatus = InternetConnectionStatus.disconnected;
            notifyListeners();
            break;
        }
      },
    );
  }

  setForecastModel(ForecastModel forecastModel) {
    this.forecastModel = forecastModel;
    notifyListeners();
  }

  setForecastDetailList(List<ForecastModel?> list) {
    forecastDetailList = list;
    notifyListeners();
  }

  changeSelectedIndexForDetail(int index) {
    selectedIndexForDetailButtons = index;
    notifyListeners();
  }

  changeOpenStatus() {
    isOpen = !isOpen;
    notifyListeners();
  }
}
