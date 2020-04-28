class ItemModelCountry {
  List<Country> countries = [];

  ItemModelCountry.fromJson(List<dynamic> json) {
    List<Country> temp = [];
    for (int i=0; i<json.length; i++) {
      Country country = Country(json[i]);
      temp.add(country);
    }
    countries = temp;
  }
}

class Country {
  int updated;
  String country;
  Info countryInfo;
  int cases;
  int todayCases;
  int deaths;
  int todayDeaths;
  int recovered;
  int active;
  int critical;
  num casesPerOneMillion;
  num deathsPerOneMillion;
  int tests;
  num testsPerOneMillion;
  String continent;

  Country(result) {
    updated = result['updated'];
    country = result['country'];
    countryInfo = Info(result['countryInfo']);
    cases = result['cases'];
    todayCases = result['todayCases'];
    deaths = result['deaths'];
    todayDeaths = result['todayDeaths'];
    recovered = result['recovered'];
    active = result['active'];
    critical = result['critical'];
    casesPerOneMillion = result['casesPerOneMillion'];
    deathsPerOneMillion = result['deathsPerOneMillion'];
    tests = result['tests'];
    testsPerOneMillion = result['testsPerOneMillion'];
    continent = result['continent'];
  }
}

class Info {
  int id;
  String iso2;
  String iso3;
  num lat;
  num long;
  String flag;

  Info(result) {
    id = result['_id'];
    iso2 = result['iso2'];
    iso3 = result['iso3'];
    lat = result['lat'];
    long = result['long'];
    flag = result['flag'];
  }
}