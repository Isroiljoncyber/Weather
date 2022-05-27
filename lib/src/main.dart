import 'package:intl/intl.dart';
import 'package:untitled2/src/Model/DayWeather_Model.dart';
import 'package:untitled2/src/Model/WeatherJson_Model.dart';
import 'package:untitled2/src/Weather.dart';
import 'dart:io';

main() async {
  List<DayWeatherModel> forecastList;
  Weather weather;
  DateTime dateTime = DateTime.now();
  String thisYear = dateTime.year.toString();
  String thisMonth = DateFormat("MMMM").format(dateTime).toLowerCase();
  String thisDay = dateTime.day.toString();

  backHere:
  print("============ Welcome to BeAwareWeather ============");
  // print("Please enter country:  ");
  // String country = stdin.readLineSync().toString();
  // print("Please enter city:  ");
  // String city = stdin.readLineSync().toString();
  print("======================================================\n"
      "Please choose one option:\n"
      "1 =>  Get today's forecasts\n"
      "2 =>  Get this whole month forecasts\n"
      "3 =>  Get by date that I gave\n"
      "==============================================");
  String option = stdin.readLineSync().toString();
  switch (option) {
    case '1':
      {
        weather =
            Weather("uzbekistan", "tashkent", thisYear, thisMonth, thisDay);
      }
      break;
    case '2':
      {
        weather = Weather("uzbekistan", "tashkent", thisYear, thisMonth);
      }
      break;
    case '3':
      {
        print("===== Year =====");
        String year = stdin.readLineSync().toString();
        print("===== Month =====");
        String month = stdin.readLineSync().toString();
        print("Day( If you don't want please click 'Enter'): ");
        String day = stdin.readLineSync().toString();
        if (day.length < 0) {
          weather =
              Weather("uzbekistan", "tashkent", year, month.toLowerCase());
        } else {
          weather =
              Weather("uzbekistan", "tashkent", year, month.toLowerCase(), day);
        }
      }
      break;
    default:
      {
        print("Wrong choosing !!");
        print("Do you want to try again ? y/n ");
        String result = stdin.readLineSync().toString();
        // if (result.contains("y") || result.contains("Y")) {
        //   break backHere;
        // }
      }
  }

  String nowDate = DateFormat("dd-MM-yyyy").format(DateTime.now());
  if (await weather.isDataChanged(nowDate)) {
    await weather
        .getWeatherInfo()
        .then((value) => weather.writeFileAsJson(value, nowDate));
  } else {
    List<WeatherJsonBodyModel> localList = await weather.getFormLocalJson();
    if (localList.isEmpty) {
      print("There is no information about this date in local date");
    } else {
      print(localList.toString());
    }
  }
}
