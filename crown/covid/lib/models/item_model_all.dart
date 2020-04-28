class ItemModelAll {
  int updated;
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
  int affectedCountries;

  ItemModelAll.fromJson(Map<String, dynamic> json){
    updated = json['updated'];
    cases = json['cases'];
    todayCases = json['todayCases'];
    deaths = json['deaths'];
    todayDeaths = json['todayDeaths'];
    recovered = json['recovered'];
    active = json['active'];
    critical = json['critical'];
    casesPerOneMillion = json['casesPerOneMillion'];
    deathsPerOneMillion = json['deathsPerOneMillion'];
    tests = json['tests'];
    testsPerOneMillion = json['testsPerOneMillion'];
    affectedCountries = json['affectedCountries'];
  }
}