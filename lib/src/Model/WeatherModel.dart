import 'dart:convert';

/// update : "27-05-2022"
/// country : "Uzbekistan"
/// city : "tashkent"
/// month : "may"
/// weather : [{"title":"Преимущественно облачно","data":"1","tempDay":"+32°","tempNight":"+21°"},{"title":"Преимущественно облачно","data":"1","tempDay":"+32°","tempNight":"+21°"}]

WeatherModel weatherModelFromJson(String str) =>
    WeatherModel.fromJson(json.decode(str));

String weatherModelToJson(WeatherModel data) => json.encode(data.toJson());

class WeatherModel {
  WeatherModel({
    String update,
    String country,
    String city,
    String month,
    List<WeatherBodyModel> weather,
  }) {
    _update = update;
    _country = country;
    _city = city;
    _month = month;
    _weather = weather;
  }

  WeatherModel.fromJson(dynamic json) {
    _update = json['update'];
    _country = json['country'];
    _city = json['city'];
    _month = json['month'];
    if (json['weather'] != null) {
      _weather = [];
      json['weather'].forEach((v) {
        _weather.add(WeatherBodyModel.fromJson(v));
      });
    }
  }

  String _update;
  String _country;
  String _city;
  String _month;
  List<WeatherBodyModel> _weather;

  WeatherModel copyWith({
    String update,
    String country,
    String city,
    String month,
    List<WeatherBodyModel> weather,
  }) =>
      WeatherModel(
        update: update ?? _update,
        country: country ?? _country,
        city: city ?? _city,
        month: month ?? _month,
        weather: weather ?? _weather,
      );

  String get update => _update;

  String get country => _country;

  String get city => _city;

  String get month => _month;

  List<WeatherBodyModel> get weather => _weather;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['update'] = _update;
    map['country'] = _country;
    map['city'] = _city;
    map['month'] = _month;
    if (_weather != null) {
      map['weather'] = _weather.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  String toString() {
    return 'Information has been changed on : $_update\n'
        'Forecast information of $_country, $_city for $_month:';
  }
}

/// title : "Преимущественно облачно"
/// data : "1"
/// tempDay : "+32°"
/// tempNight : "+21°"

WeatherBodyModel weatherFromJson(String str) =>
    WeatherBodyModel.fromJson(json.decode(str));

String weatherToJson(WeatherBodyModel data) => json.encode(data.toJson());

class WeatherBodyModel {
  WeatherBodyModel({
    String title,
    String date,
    String tempDay,
    String tempNight,
  }) {
    _title = title;
    _data = date;
    _tempDay = tempDay;
    _tempNight = tempNight;
  }

  WeatherBodyModel.fromJson(dynamic json) {
    _title = json['title'];
    _data = json['data'];
    _tempDay = json['tempDay'];
    _tempNight = json['tempNight'];
  }

  String _title;
  String _data;
  String _tempDay;
  String _tempNight;

  WeatherBodyModel copyWith({
    String title,
    String data,
    String tempDay,
    String tempNight,
  }) =>
      WeatherBodyModel(
        title: title ?? _title,
        date: data ?? _data,
        tempDay: tempDay ?? _tempDay,
        tempNight: tempNight ?? _tempNight,
      );

  String get title => _title;

  String get data => _data;

  String get tempDay => _tempDay;

  String get tempNight => _tempNight;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['data'] = _data;
    map['tempDay'] = _tempDay;
    map['tempNight'] = _tempNight;
    return map;
  }

  @override
  String toString() {
    return 'Date: $_data \n'
        'Weather is: $_title\n'
        'Temperature is during the day: $_tempDay\n'
        'Temperature is during the nigh: $_tempNight\n';
  }
}
