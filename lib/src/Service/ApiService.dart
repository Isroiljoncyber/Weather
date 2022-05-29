//
import 'dart:io';

import 'package:untitled2/src/Model/Weather_Hourly_Forecast_Model.dart';

import '../Model/Weather_Model.dart';

class ApiService{

  // get all info from uri
  Future<List<WeatherBodyModel>> getWeatherInfo() {}
  writeFileAsJson(List<WeatherBodyModel> list) {}
  Future<WeatherModel> getFormLocalJson() {}
  Future<WeatherModel> getMonthWeather() {}
  Future<WeatherBodyModel> getOneDay() {}
  Future<List<WeatherHourlyForecastModel>> getHourlyForecast() {}
  bool isFileExisted(String fileName) {}


}