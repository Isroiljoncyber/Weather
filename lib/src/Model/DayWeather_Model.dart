class DayWeatherModel {
  final String _weatherDisc;
  final String _year;
  final String _month;
  final String _day;
  final String _dayTemperature;
  final String _nightTemperature;

  DayWeatherModel(this._dayTemperature, this._nightTemperature,
      this._weatherDisc, this._year, this._month, this._day);

  @override
  String toString() {
    return'            {\n'
        '                  "title": "$_weatherDisc",\n'
        '                  "data": "$_day-$_month-$_year",\n'
        '                  "tempDay": "$_dayTemperature",\n'
        '                  "tempNight": "$_nightTemperature"\n'
        '            }';
  }
}
