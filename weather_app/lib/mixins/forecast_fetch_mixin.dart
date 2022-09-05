import 'package:dio/dio.dart';
import 'package:weather_app/constants/string_datas.dart';
import 'package:weather_app/model/forecast_model.dart';
import 'package:weather_app/service/constants.dart';
import 'package:weather_app/service/forecast_service/forecast_weather_service.dart';
import 'package:weather_app/service/location_service/location_service.dart';

enum ServiceParams {
  q,
  days,
  dt,
}

mixin PrepareValueForFetching {
  Future<ForecastModel> prepareValues(
      {String date = '', bool isCurrent = true}) async {
    WeatherService weatherService;
    if (isCurrent) {
      String currentDate =
          '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
      weatherService = WeatherService(
        await _prepareDioForForecast(currentDate),
      );
    } else {
      weatherService = WeatherService(
        await _prepareDioForForecast(date),
      );
    }

    ForecastModel forecastModel =
        await weatherService.fetchForecast() ?? ForecastModel();
    return forecastModel;
  }

  Future<Dio> _prepareDioForForecast(String date) async {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: ServiceConst.basePath,
        queryParameters: {
          ServiceParams.q.name: await _getLocation(),
          ServiceParams.days.name: 0,
          ServiceParams.dt.name: date,
        },
        headers: {
          ServiceConst.rapidKey: ServiceConst.rapidKeyValue,
          ServiceConst.rapidHost: ServiceConst.rapidHostValue,
        },
      ),
    );
    return dio;
  }

  Future<String> _getLocation() async {
    String location =
        StringData.defaultLocation; //This is default value for Paris.
    if (await LocationService().getGeoLocationPosition() != null) {
      final position = await LocationService().getGeoLocationPosition();

      location = '${position!.latitude},${position.longitude}';
    }
    return location;
  }
}
