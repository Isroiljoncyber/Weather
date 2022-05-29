import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart'; // Contains a client for making API calls
import 'package:html/parser.dart'; // Contains HTML parsers to generate a Document object
import 'package:intl/intl.dart';
import 'package:untitled2/src/Model/Weather_Hourly_Forecast_Model.dart';
import 'dart:io';

import 'package:untitled2/src/Model/Weather_Model.dart';
import 'package:untitled2/src/Service/ApiService.dart';

class WeatherRepo implements ApiService {
  final BASE_URI = "https://world-weather.ru/pogoda/";

  final String _coutryName;
  final String _cityName;
  final String _year;
  final String _month;
  final String _day;

  WeatherRepo(this._coutryName, this._cityName,
      [this._year, this._month, this._day = ""]);

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
    } else {
      throw Exception("We cannot find any info ☹\n"
          "Status code: ${response.statusCode}\n");
    }
    return model;
  }

  @override
  Future<List<WeatherHourlyForecastModel>> getHourlyForecast() async {
    var client = Client();
    List<WeatherHourlyForecastModel> model = [];
    Response response = await client
        .get(Uri.parse("$BASE_URI$_coutryName/$_cityName/24hours/"));
    if (response.statusCode == 200) {
      var htmlString = parse(response.body);
      var content = htmlString.querySelectorAll("div")[9];
      int id = 1;
      content.querySelectorAll("div.dates").forEach((element) {
        String day = element.text.replaceAll(",", "");
        List<HourlyForecast> hourlyList = [];
        content
            .querySelectorAll("table.weather-today")[id]
            .querySelectorAll("tr,tr")
            .forEach((element) {
          var row = element.querySelectorAll("td,td");
          String time = row[0].text;
          String title =
              row[1].querySelectorAll("div").first.attributes["title"];
          String temp = row[2].text;
          String probab = row[3].text;
          String pressure = row[4].text;
          String windDir = row[5]
              .querySelectorAll("span")
              .first
              .attributes['class']
              .replaceAll("tooltip wwi ", "");
          String windSpeed =
              row[5].querySelectorAll("span").last.attributes['title'];
          String humid = row[6].text;
          hourlyList.add(HourlyForecast(
              time: time,
              temperature: "$title $temp",
              rainProbability: probab,
              pressure: pressure,
              windDirection: windDir,
              windSpeed: windSpeed,
              humidity: humid));
        });

        model.add(WeatherHourlyForecastModel(
            dayTitle: day, hourlyForecast: hourlyList));
        id++;
        print("");
      });
    } else {
      throw Exception("We cannot find any info ☹\n"
          "Status code: ${response.statusCode}\n");
    }
    return model;
  }

  @override
  Future<WeatherModel> getFormLocalJson() async {
    var jsonFile = File('../$_coutryName$_cityName$_year$_month.json');
    final String response = jsonFile.readAsStringSync();
    WeatherModel weatherJsonModel;
    var fileString = await json.decode(response);
    weatherJsonModel = WeatherModel.fromJson(fileString);
    if (weatherJsonModel.update.contains(getUpdateDate())) {
      return weatherJsonModel;
    } else {
      await getWeatherInfo().then((value) => {writeFileAsJson(value)});
      return getFormLocalJson();
    }
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
  writeFileAsJson(List<WeatherBodyModel> list) {
    var jsonFile = File('../$_coutryName$_cityName$_year$_month.json');
    if (jsonFile.existsSync()) jsonFile.delete();
    var weatherJson = WeatherModel(
        update: getUpdateDate(),
        country: _coutryName,
        city: _cityName,
        month: _month,
        weather: list);
    var jsonString = weatherJson.toJson();
    jsonFile.writeAsStringSync(jsonEncode(jsonString));
  }

  String getUpdateDate() {
    String day = DateFormat("dd").format(DateTime.now());
    return "$day-$_month-$_year";
  }

  @override
  bool isFileExisted(String fileName) {
    var existedFile = File('../$fileName.json');
    if (existedFile.existsSync()) {
      return true;
    }
    return false;
  }
}
