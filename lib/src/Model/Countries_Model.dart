class CountriesModel {
  final String _countryNameRu;
  final String _countryNameEng;

  CountriesModel(this._countryNameRu, this._countryNameEng);

  @override
  String toString() {
    return "Country name in Russian: $_countryNameRu, English: $_countryNameEng";
  }
}
