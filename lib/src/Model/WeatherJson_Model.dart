class WeatherJsonModel {
  final String _update;
  final List<WeatherJsonBodyModel> _weather;

  WeatherJsonModel(this._update, this._weather);
}

class WeatherJsonBodyModel {
  final String _title;
  final String _data;

  String get tempDay => _tempDay;

  final String _tempDay;
  final String _tempNight;

  WeatherJsonBodyModel(this._title, this._data, this._tempDay, this._tempNight);

  @override
  String toString() {
    return 'Date is: $_data \nWeather is: $_title \nTemperature during the day: $_tempDay \nTemperature during the day: $_tempNight \n';
  }
}
