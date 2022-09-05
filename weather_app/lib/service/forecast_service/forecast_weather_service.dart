import 'dart:io';

import 'package:dio/dio.dart';
import 'package:weather_app/model/forecast_model.dart';

enum ServicePath {
  forecast,
}

class WeatherService {
  final Dio dio;

  WeatherService(this.dio);

  Future<ForecastModel?> fetchForecast() async {
    final response = await dio.get('${ServicePath.forecast.name}.json');

    if (response.statusCode == HttpStatus.ok) {
      if (response.data != null) {
        return ForecastModel().fromJson(response.data);
      }
    }
    return null;
  }

  Future<ForecastModel?> fetchFutureForecast() async {
    final response = await dio.get(
      '${ServicePath.forecast.name}.json',
    );

    if (response.statusCode == HttpStatus.ok) {
      if (response.data != null) {
        return ForecastModel().fromJson(response.data);
      }
    }
    return null;
  }
}
