import 'package:intl/intl.dart';
import 'package:untitled2/src/Model/Weather_Hourly_Forecast_Model.dart';
import 'package:untitled2/src/Repository/WeatherRepo.dart';
import 'dart:io';
import 'package:untitled2/src/Utils.dart';

main() async {
  WeatherRepo weather;
  DateTime dateTime = DateTime.now();
  String thisYear = dateTime.year.toString();
  String thisMonth = DateFormat("MMMM").format(dateTime).toLowerCase();
  String thisDay = dateTime.day.toString();

  backHere:
  // print("============ Welcome to BeAwareWeather ============");
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
      "4 =>  Get hourly forecast\n"
      "==============================================");
  String option = stdin.readLineSync().toString();
  try {
    switch (option) {
      // case '1':
      //   {
      //     weather = WeatherRepo(country, city, thisYear, thisMonth, thisDay);
      //     weather.getOneDay().then((value) => {
      //           if (value != null)
      //             print(value.toString())
      //           else
      //             print("File not exists or wring date was entered")
      //         });
      //   }
      //   break;
      // case '2':
      //   {
      //     weather = WeatherRepo(country, city, thisYear, thisMonth);
      //     WeatherModel weatherModel = await weather.getMonthWeather();
      //     print(weatherModel.toString());
      //     for (var element in weatherModel.weather) {
      //       print(element.toString());
      //     }
      //   }
      //   break;
      // case '3':
      //   {
      //     print("===== Year =====");
      //     String year = stdin.readLineSync().toString();
      //     print("===== Month =====");
      //     String month = stdin.readLineSync().toString();
      //     print("Day( If you don't want please click 'Enter'): ");
      //     String day = stdin.readLineSync().toString();
      //     if (day.length < 0) {
      //       weather = WeatherRepo(country, city, year, month);
      //       WeatherModel weatherModel = await weather.getMonthWeather();
      //       for (var element in weatherModel.weather) {
      //         print(element.toString());
      //       }
      //     } else {
      //       weather = WeatherRepo(country, city, year, month, day);
      //       weather.getOneDay().then((value) => {
      //         if (value != null)
      //           print(value.toString())
      //         else
      //           print("File not exists or wring date was entered")
      //       });
      //     }
      //   }
      //   break;
      case '4' : {
        weather = WeatherRepo("uzbekistan", "tashkent");
        List<WeatherHourlyForecastModel> hourlyList = await weather.getHourlyForecast();
        for (var element in hourlyList) {
          Utils.printRedBGWhite(element.toString());
          for(var item in element.hourlyForecast){
            Utils.printBlackBGYellow(item.toString());
          }
        }} break;
    }
  } on Exception catch (e) {
    print(e);
    exit(0);
  }
  exit(0);
}
