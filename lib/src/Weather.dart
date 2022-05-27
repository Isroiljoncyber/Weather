import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:intl/intl.dart';
import 'package:untitled2/src/Model/DayWeather_Model.dart';
import 'package:http/http.dart'; // Contains a client for making API calls
import 'package:html/parser.dart'; // Contains HTML parsers to generate a Document object
import 'dart:io';

import 'package:untitled2/src/Model/WeatherJson_Model.dart';

class Weather {
  //"https://world-weather.ru/pogoda/$country/$city/month-$year/"
  final BASE_URI = "https://world-weather.ru/pogoda/";
  final BASE_FILE_URL = '../weather.json';

  final String _coutryName;
  final String _cityName;
  final String _year;
  final String _month;
  final String _day;

  Weather(this._coutryName, this._cityName, this._year, this._month,
      [this._day = ""]);

  Future<List<DayWeatherModel>> getWeatherInfo() async {
    var client = Client();
    List<DayWeatherModel> model = [];
    Response response = await client
        .get(Uri.parse("$BASE_URI$_coutryName/$_cityName/$_month-$_year/"));
    if (response.statusCode == 200) {
      var rows = parse(response.body)
          .querySelectorAll("ul.ww-month")
          .first
          .querySelectorAll("li,li");
      for (var row in rows) {
        // check is there any information in its body
        if (row.attributes.isNotEmpty) {
          String day = row.querySelectorAll("div").first.text;
          String disc = row.querySelectorAll("i").first.attributes["title"];
          String dayTemp = row.querySelectorAll("span").first.text;
          String nightTemp = row.querySelectorAll("p").first.text;
          if (_day.length > 0) {
            if (_day == day) {
              model.add(DayWeatherModel(
                  dayTemp, nightTemp, disc, _year, _month, day));
              return model;
            }
          } else {
            model.add(
                DayWeatherModel(dayTemp, nightTemp, disc, _year, _month, day));
          }
        }
      }
    }
    return model;
  }

  void writeFileAsJson(List<DayWeatherModel> list, String date) async {
    var jsonFile = File(BASE_FILE_URL);
    if (jsonFile.existsSync()) jsonFile.delete();
    jsonFile.writeAsStringSync(
        '{\n'
        '      "update": "$date", \n'
        '      "weather": [\n',
        mode: FileMode.append);
    for (var element in list) {
      if (element != list.last) {
        jsonFile.writeAsStringSync("$element,\n", mode: FileMode.append);
      } else {
        jsonFile.writeAsStringSync("$element\n", mode: FileMode.append);
      }
    }
    jsonFile.writeAsStringSync('      ]\n}', mode: FileMode.append);
  }

  Future<List<WeatherJsonBodyModel>> getFormLocalJson() async {
    var jsonFile = File(BASE_FILE_URL);
    final String response = jsonFile.readAsStringSync();
    List<WeatherJsonBodyModel> weatherJsonList = [];
    Map<dynamic, dynamic> responseList = await json.decode(response);
    List<dynamic> items = responseList.entries.last.value;
    for (var item in items) {
      var values = item as LinkedHashMap<dynamic, dynamic>;
      var row = values.values
          .toString()
          .replaceAll("(", "")
          .replaceAll(")", "")
          .split(",");
      if (_day.length > 0) {
        if (row[1].replaceAll(" ", "") == "$_day-$_month-$_year") {
          weatherJsonList
              .add(WeatherJsonBodyModel(row[0], row[1], row[2], row[3]));
          weatherJsonList;
        }
      } else {
        weatherJsonList
            .add(WeatherJsonBodyModel(row[0], row[1], row[2], row[3]));
      }
    }
    return weatherJsonList;
  }

  bool checkIsNumber(String stringNumber) {
    try {
      double.parse(stringNumber.replaceAll(" ", ""));
      return true;
    } on Exception {
      return false;
    }
  }

  Future<bool> isDataChanged(String nowDate) async {
    var existedFile = File(BASE_FILE_URL);
    if (existedFile.existsSync()) {
      String allData = existedFile.readAsStringSync();
      if (allData.contains(nowDate)) {
        return false;
      }
    }
    return true;
  }
}
