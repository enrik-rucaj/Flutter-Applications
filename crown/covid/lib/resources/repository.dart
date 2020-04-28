import 'dart:async';
import 'covid_api_provider.dart';
import '../models/item_model_country.dart';
import '../models/item_model_continent.dart';
import '../models/item_model_all.dart';

class Repository {
  final covidApiProvider = CovidApiProvider();

  Future<ItemModelCountry> fetchAllCountries() => covidApiProvider.fetchCountryList();
  Future<ItmeModelContinent> fetchAllContinents() => covidApiProvider.fetchContinentList();
  Future<ItemModelAll> fetchAll() => covidApiProvider.fetchAllInfo();
}