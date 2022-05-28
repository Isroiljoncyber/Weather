import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart'; // Contains a client for making API calls
import 'package:html/parser.dart'; // Contains HTML parsers to generate a Document object
import 'package:intl/intl.dart';
import 'dart:io';

import 'package:untitled2/src/Model/WeatherModel.dart';
import 'package:untitled2/src/Service/ApiService.dart';

class WeatherRepo extends ApiService {
  final BASE_URI = "https://world-weather.ru/pogoda/";

  final String _coutryName;
  final String _cityName;
  final String _year;
  final String _month;
  final String _day;

  WeatherRepo(this._coutryName, this._cityName, this._year, this._month,
      [this._day = ""]);

  @override
  Future<WeatherModel> getFormLocalJson() async {
    var jsonFile = File('../$_coutryName$_cityName$_year$_month.json');
    final String response = jsonFile.readAsStringSync();
    WeatherModel weatherJsonModel;
    var fileString = await json.decode(response);
    weatherJsonModel = WeatherModel.fromJson(fileString);
    return weatherJsonModel;
  }

  @override
  Future<WeatherModel> getMonthWeather() async {
    if (!isFileExisted("$_coutryName$_cityName$_year$_month")) {
      await getWeatherInfo().then((value) => writeFileAsJson(value));
    }
    return await getFormLocalJson();
  }

  @override
  Future<WeatherBodyModel> getOneDay() async {
    if (!isFileExisted("$_coutryName$_cityName$_year$_month")) {
      await getWeatherInfo().then((value) => writeFileAsJson(value));
    }
    WeatherModel result = await getFormLocalJson();
    for (var element in result.weather) {
      if (element.data == _day) {
        return element;
      }
    }
  }

  @override
  Future<List<WeatherBodyModel>> getWeatherInfo() async {
    var client = Client();
    List<WeatherBodyModel> model = [];
    Response response = await client
        .get(Uri.parse("$BASE_URI$_coutryName/$_cityName/$_month-$_year/"));
    if (response.statusCode == 200) {
      var rows = parse(response.body)
          .querySelectorAll("ul.ww-month")
          .first
          .querySelectorAll("li,li");
      for (var row in rows) {
        if (row.attributes.isNotEmpty) {
          String day = row.querySelectorAll("div").first.text;
          String disc = row.querySelectorAll("i").first.attributes["title"];
          String dayTemp = row.querySelectorAll("span").first.text;
          String nightTemp = row.querySelectorAll("p").first.text;
          model.add(WeatherBodyModel(
              title: disc, date: day, tempDay: dayTemp, tempNight: nightTemp));
        }
      }
    }
    return model;
  }

  @override
  writeFileAsJson(List<WeatherBodyModel> list) {
    var jsonFile = File('../$_coutryName$_cityName$_year$_month.json');
    String update = DateFormat("dd-MM-yyyy").format(DateTime.now());
    if (jsonFile.existsSync()) jsonFile.delete();
    var weatherJson = WeatherModel(
        update: update,
        country: _coutryName,
        city: _cityName,
        month: _month,
        weather: list);
    var jsonString = weatherJson.toJson();
    jsonFile.writeAsStringSync(jsonEncode(jsonString));
  }
}
