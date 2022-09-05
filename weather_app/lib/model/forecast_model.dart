class ForecastModel {
  String? location;

  String? date;

  String? maxTemp;
  String? minTemp;
  String? avgTemp;
  String? currentTemp;

  String? wind;
  String? maxWind;

  String? humidity;
  String? avgHumidity;

  String? uv;

  String? precip;

  String? dailyChanceOfRain;
  String? dailyChanceOfSnow;

  String? conditionText;
  String? conditionIcon;

  String? sunrise;
  String? sunset;
  String? moonPhase;

  List<HourlyData>? hourlyDatas;

  ForecastModel({
    this.location,
    this.date,
    this.conditionText,
    this.conditionIcon,
    this.currentTemp,
    this.maxTemp,
    this.minTemp,
    this.avgTemp,
    this.precip,
    this.wind,
    this.maxWind,
    this.sunrise,
    this.sunset,
    this.moonPhase,
    this.humidity,
    this.avgHumidity,
    this.uv,
    this.dailyChanceOfRain,
    this.dailyChanceOfSnow,
    this.hourlyDatas,
  });

  ForecastModel fromJson(Map<String, dynamic> json) {
    return ForecastModel(
      location: json['location']['region'].toString(),
      date: json['current']['last_updated'].toString(),
      conditionText: json['current']['condition']['text'].toString(),
      conditionIcon: json['current']['condition']['icon'].toString(),
      currentTemp: json['current']['temp_c'].toString(),
      maxTemp:
          json['forecast']['forecastday'][0]['day']['maxtemp_c'].toString(),
      minTemp:
          json['forecast']['forecastday'][0]['day']['mintemp_c'].toString(),
      avgTemp:
          json['forecast']['forecastday'][0]['day']['avgtemp_c'].toString(),
      precip: json['current']['precip_mm'].toString(),
      wind: json['current']['wind_kph'].toString(),
      maxWind:
          json['forecast']['forecastday'][0]['day']['maxwind_kph'].toString(),
      sunrise:
          json['forecast']['forecastday'][0]['astro']['sunrise'].toString(),
      sunset: json['forecast']['forecastday'][0]['astro']['sunset'].toString(),
      moonPhase:
          json['forecast']['forecastday'][0]['astro']['moon_phase'].toString(),
      humidity: json['current']['humidity'].toString(),
      avgHumidity:
          json['forecast']['forecastday'][0]['day']['avghumidity'].toString(),
      uv: json['current']['uv'].toString(),
      dailyChanceOfRain: json['forecast']['forecastday'][0]['day']
              ['daily_chance_of_rain']
          .toString(),
      dailyChanceOfSnow: json['forecast']['forecastday'][0]['day']
              ['daily_chance_of_snow']
          .toString(),
      hourlyDatas: getHourlyData(json),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': {
        'region': location,
      },
      'current': {
        'last_updated': date,
        'condition': {
          'text': conditionText,
          'icon': conditionIcon,
        },
        'temp_c': currentTemp,
        'precip_mm': precip,
        'wind_kph': wind,
        'humidity': humidity,
        'uv': uv,
      },
      'forecast': {
        'forecastday': [
          {
            'day': {
              'maxtemp_c': maxTemp,
              'mintemp_c': minTemp,
              'avgtemp_c': avgTemp,
              'maxwind_kph': maxWind,
              'avghumidity': avgHumidity,
              'daily_chance_of_raind': dailyChanceOfRain,
              'daily_chance_of_snow': dailyChanceOfSnow,
            },
            'astro': {
              'sunrise': sunrise,
              'sunset': sunset,
              'moon_phase': moonPhase,
            },
            'hour': hourlyDatas
                ?.map(
                  (e) => e.toJson(),
                )
                .toList(),
          }
        ]
      },
    };
  }

  DateTime get localDate {
    DateTime dateTime = DateTime.tryParse(date.toString()) ?? DateTime.now();

    return dateTime;
  }

  String get iconWithHttps {
    return 'https:$conditionIcon';
  }

  Duration get formattedSunriseHour {
    String temp = sunrise.toString();

    int newHour = int.parse(
      temp.replaceRange(2, temp.length, ''),
    );

    int newMinute = int.parse(temp.substring(3, temp.length - 2));

    if (temp.substring(temp.length - 2) == 'PM') {
      newHour += 12;
    }

    DateTime formattedDate = DateTime(
      localDate.year,
      localDate.month,
      localDate.day,
      newHour,
      newMinute,
    );

    return localDate.difference(formattedDate);
  }

  Duration get formattedSunsetHour {
    String temp = sunset.toString();

    int newHour = int.parse(
      temp.replaceRange(2, temp.length, ''),
    );

    int newMinute = int.parse(temp.substring(3, temp.length - 2));

    if (temp.substring(temp.length - 2) == 'PM') {
      newHour += 12;
    }

    DateTime formattedDate = DateTime(
      localDate.year,
      localDate.month,
      localDate.day,
      newHour,
      newMinute,
    );

    return localDate.difference(formattedDate);
  }

  List<HourlyData>? getHourlyData(Map<String, dynamic> json) {
    List newJson = json['forecast']['forecastday'][0]['hour'];

    List<HourlyData>? list = [];

    for (int i = 0; i < newJson.length; i++) {
      list.add(HourlyData.fromJson(newJson[i]));
    }

    return list;
  }
}

class HourlyData {
  String? time;
  String? humidity;
  String? temp;
  String? icon;

  HourlyData({this.time, this.humidity, this.temp, this.icon});

  get iconWithHttps {
    return 'https:$icon';
  }

  DateTime get localDate {
    DateTime dateTime = DateTime.tryParse(time.toString()) ?? DateTime.now();

    return dateTime;
  }

  factory HourlyData.fromJson(Map<String, dynamic> json) {
    return HourlyData(
      time: json['time'].toString(),
      humidity: json['humidity'].toString(),
      temp: json['temp_c'].toString(),
      icon: json['condition']['icon'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'humidity': humidity,
      'temp_c': temp,
      'condition': {
        'icon': icon,
      }
    };
  }
}

/*
class ForecastDetailModel {
  String? maxTemp;
  String? minTemp;
  String? avgTemp;

  String? maxWind;
  String? avgHumidity;

  String? dailyChanceOfRain;
  String? dailyChanceOfSnow;

  String? uv;

  String? conditionText;
  String? conditionIcon;

  String? sunriseTime;
  String? sunsetTime;
  String? moonPhase;

  List<HourlyData>? hourlyDatas;

  ForecastDetailModel({
    this.maxTemp,
    this.minTemp,
    this.avgTemp,
    this.maxWind,
    this.avgHumidity,
    this.dailyChanceOfRain,
    this.dailyChanceOfSnow,
    this.uv,
    this.conditionText,
    this.conditionIcon,
    this.sunriseTime,
    this.sunsetTime,
    this.moonPhase,
    this.hourlyDatas,
  });

  ForecastDetailModel fromJson(Map<String, dynamic> json) {
    return ForecastDetailModel(
      maxTemp:
          json['forecast']['forecastday'][0]['day']['maxtemp_c'].toString(),
      minTemp:
          json['forecast']['forecastday'][0]['day']['mintemp_c'].toString(),
      avgTemp:
          json['forecast']['forecastday'][0]['day']['avgtemp_c'].toString(),
      maxWind:
          json['forecast']['forecastday'][0]['day']['maxwind_kph'].toString(),
      avgHumidity:
          json['forecast']['forecastday'][0]['day']['avghumidity'].toString(),
      dailyChanceOfRain: json['forecast']['forecastday'][0]['day']
              ['daily_chance_of_rain']
          .toString(),
      dailyChanceOfSnow: json['forecast']['forecastday'][0]['day']
              ['daily_chance_of_snow']
          .toString(),
      uv: json['forecast']['forecastday'][0]['day']['uv'].toString(),
      conditionText: json['forecast']['forecastday'][0]['day']['condition']
              ['text']
          .toString(),
      conditionIcon: json['forecast']['forecastday'][0]['day']['condition']
              ['icon']
          .toString(),
      sunriseTime:
          json['forecast']['forecastday'][0]['astro']['sunrise'].toString(),
      sunsetTime:
          json['forecast']['forecastday'][0]['astro']['sunset'].toString(),
      moonPhase:
          json['forecast']['forecastday'][0]['astro']['moon_phase'].toString(),
      hourlyDatas: getHourlyData(json),
    );
  }

  List<HourlyData>? getHourlyData(Map<String, dynamic> json) {
    List newJson = json['forecast']['forecastday'][0]['hour'];

    List<HourlyData>? list = [];

    for (int i = 0; i < newJson.length; i++) {
      list.add(HourlyData.fromJsonForDetail(newJson[i]));
    }

    return list;
  }
}
*/
