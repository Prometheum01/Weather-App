import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/model/forecast_model.dart';

enum SharedKeys {
  currentForecast,
  weekForecast,
  lastLocation,
  themeOption,
  windType,
  tempType,
}

class SharedManager {
  SharedPreferences? prefs;

  SharedManager();

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  void _checkPreferences() {
    if (prefs == null) throw SharedNotInitiazleException();
  }

  Future<void> setCurrentForecastData(ForecastModel forecastModel) async {
    _checkPreferences();
    await prefs?.setString(
      SharedKeys.currentForecast.name,
      jsonEncode(
        forecastModel.toJson(),
      ),
    );
  }

  ForecastModel? getCurrentForecastData() {
    _checkPreferences();
    return ForecastModel().fromJson(
      jsonDecode(
        prefs?.getString(SharedKeys.currentForecast.name) ?? '',
      ),
    );
  }

  Future<void> setWeekForecastData(
      List<ForecastModel?> forecastModelList) async {
    _checkPreferences();
    await prefs?.setStringList(
        SharedKeys.weekForecast.name,
        forecastModelList.map((e) {
          return jsonEncode(
            e?.toJson(),
          );
        }).toList());
  }

  List<ForecastModel>? getWeekForecastData() {
    _checkPreferences();
    return prefs
        ?.getStringList(SharedKeys.weekForecast.name)
        ?.map((e) => ForecastModel().fromJson(jsonDecode(e)))
        .toList();
  }
}

class SharedNotInitiazleException implements Exception {
  @override
  String toString() {
    return 'Your prefences has not initiazled right now';
  }
}
