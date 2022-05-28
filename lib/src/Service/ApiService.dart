//
import 'dart:io';

import '../Model/WeatherModel.dart';

class ApiService{

  // get all info from uri
  Future<List<WeatherBodyModel>> getWeatherInfo() {}
  writeFileAsJson(List<WeatherBodyModel> list) {}
  Future<WeatherModel> getFormLocalJson() {}
  Future<WeatherModel> getMonthWeather() {}
  Future<WeatherBodyModel> getOneDay() {}

  bool isFileExisted(String fileName) {
    var existedFile = File('../$fileName.json');
    if (existedFile.existsSync()) {
      return true;
    }
    return false;
  }


}