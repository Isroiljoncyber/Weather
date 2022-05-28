import 'package:intl/intl.dart';
import 'package:untitled2/src/Model/WeatherModel.dart';
import 'package:untitled2/src/Repository/WeatherRepo.dart';
import 'dart:io';

main() async {
  WeatherRepo weather;
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
  // check country and city form list and show alternative;
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
            WeatherRepo("uzbekistan", "tashkent", thisYear, thisMonth, thisDay);
        weather.getOneDay().then((value) => {
              if (value != null)
                print(value.toString())
              else
                print("File not exists or wring date was entered")
            });
      }
      break;
    case '2':
      {
        weather = WeatherRepo("uzbekistan", "tashkent", thisYear, thisMonth);
        WeatherModel weatherModel = await weather.getMonthWeather();
        for (var element in weatherModel.weather) {
          print(element.toString());
        }
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
              WeatherRepo("uzbekistan", "tashkent", year, month.toLowerCase());
        } else {
          weather = WeatherRepo(
              "uzbekistan", "tashkent", year, month.toLowerCase(), day);
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
}
