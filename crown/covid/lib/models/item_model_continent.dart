class ItmeModelContinent {
  List<Continent> continents = [];

  ItmeModelContinent.fromJson(List<dynamic> json) {
    print(json.length);
    List<Continent> temp = [];
    for (int i=0; i<json.length; i++) {
      Continent country = Continent(json[i]);
      temp.add(country);
    }
    continents = temp;
  }
}

class Continent {
  int updated;
  String continent;
  int cases;
  int todayCases;
  int deaths;
  int todayDeaths;
  int recovered;
  int active;
  int critical;
  List<dynamic> countries;

  Continent(result) {
    updated = result['updated'];
    continent = result['continent'];
    cases = result['cases'];
    todayCases = result['todayCases'];
    deaths = result['deaths'];
    todayDeaths = result['todayDeaths'];
    recovered = result['recovered'];
    active = result['active'];
    critical = result['critical'];
    countries = result['countries'];
  }
}