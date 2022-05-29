import 'dart:convert';

/// dayTitle : "29-may-2022"
/// hourlyForecast : [{"time":"20:00","temperature":"+19","rainProbability":"12%","pressure":"+714","windSpeed":"1.0","windDirection":"s","humidity":"35"},{"time":"20:00","temperature":"+19","rainProbability":"12%","pressure":"+714","windSpeed":"1.0","windDirection":"s","humidity":"35"}]

WeatherHourlyForecastModel weatherHourlyForecastModelFromJson(String str) =>
    WeatherHourlyForecastModel.fromJson(json.decode(str));

String weatherHourlyForecastModelToJson(WeatherHourlyForecastModel data) =>
    json.encode(data.toJson());

class WeatherHourlyForecastModel {
  WeatherHourlyForecastModel({
    String dayTitle,
    List<HourlyForecast> hourlyForecast,
  }) {
    _dayTitle = dayTitle;
    _hourlyForecast = hourlyForecast;
  }

  WeatherHourlyForecastModel.fromJson(dynamic json) {
    _dayTitle = json['dayTitle'];
    if (json['hourlyForecast'] != null) {
      _hourlyForecast = [];
      json['hourlyForecast'].forEach((v) {
        _hourlyForecast.add(HourlyForecast.fromJson(v));
      });
    }
  }

  String _dayTitle;
  List<HourlyForecast> _hourlyForecast;

  WeatherHourlyForecastModel copyWith({
    String dayTitle,
    List<HourlyForecast> hourlyForecast,
  }) =>
      WeatherHourlyForecastModel(
        dayTitle: dayTitle ?? _dayTitle,
        hourlyForecast: hourlyForecast ?? _hourlyForecast,
      );

  String get dayTitle => _dayTitle;

  List<HourlyForecast> get hourlyForecast => _hourlyForecast;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dayTitle'] = _dayTitle;
    if (_hourlyForecast != null) {
      map['hourlyForecast'] = _hourlyForecast.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  String toString() {
    return "\n=//=//=//=//=//=//=//=//=//=//= Hourly forecast : $_dayTitle =//=//=//=//=//=//=//=//=//=//=\n ";
  }
}

/// time : "20:00"
/// temperature : "+19"
/// rainProbability : "12%"
/// pressure : "+714"
/// windSpeed : "1.0"
/// windDirection : "s"
/// humidity : "35"

HourlyForecast hourlyForecastFromJson(String str) =>
    HourlyForecast.fromJson(json.decode(str));

String hourlyForecastToJson(HourlyForecast data) => json.encode(data.toJson());

class HourlyForecast {
  HourlyForecast({
    String time,
    String temperature,
    String rainProbability,
    String pressure,
    String windSpeed,
    String windDirection,
    String humidity,
  }) {
    _time = time;
    _temperature = temperature;
    _rainProbability = rainProbability;
    _pressure = pressure;
    _windSpeed = windSpeed;
    _windDirection = windDirection;
    _humidity = humidity;
  }

  HourlyForecast.fromJson(dynamic json) {
    _time = json['time'];
    _temperature = json['temperature'];
    _rainProbability = json['rainProbability'];
    _pressure = json['pressure'];
    _windSpeed = json['windSpeed'];
    _windDirection = json['windDirection'];
    _humidity = json['humidity'];
  }

  String _time;
  String _temperature;
  String _rainProbability;
  String _pressure;
  String _windSpeed;
  String _windDirection;
  String _humidity;

  HourlyForecast copyWith({
    String time,
    String temperature,
    String rainProbability,
    String pressure,
    String windSpeed,
    String windDirection,
    String humidity,
  }) =>
      HourlyForecast(
        time: time ?? _time,
        temperature: temperature ?? _temperature,
        rainProbability: rainProbability ?? _rainProbability,
        pressure: pressure ?? _pressure,
        windSpeed: windSpeed ?? _windSpeed,
        windDirection: windDirection ?? _windDirection,
        humidity: humidity ?? _humidity,
      );

  String get time => _time;

  String get temperature => _temperature;

  String get rainProbability => _rainProbability;

  String get pressure => _pressure;

  String get windSpeed => _windSpeed;

  String get windDirection => _windDirection;

  String get humidity => _humidity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['time'] = _time;
    map['temperature'] = _temperature;
    map['rainProbability'] = _rainProbability;
    map['pressure'] = _pressure;
    map['windSpeed'] = _windSpeed;
    map['windDirection'] = _windDirection;
    map['humidity'] = _humidity;
    return map;
  }

  @override
  String toString() {
    return 'Time: $time  || Temperature: $temperature  || Rain probability: $rainProbability  || Pressure: $pressure  || Wind speed: $windSpeed to $windDirection ||  Humidity: $humidity \n';
  }

}
