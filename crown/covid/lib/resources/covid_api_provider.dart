import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/item_model_country.dart';
import '../models/item_model_continent.dart';
import '../models/item_model_all.dart';

class CovidApiProvider {
  Client client = Client();

  Future<ItemModelCountry> fetchCountryList() async {
    final response = await client.get("https://corona.lmao.ninja/v2/countries/");
    if (response.statusCode == 200) 
      return ItemModelCountry.fromJson(json.decode(response.body));
    else 
      throw Exception('Failed to load post');
  }

  Future<ItmeModelContinent> fetchContinentList() async {
    final response = await client.get("https://corona.lmao.ninja/v2/continents/");
    if (response.statusCode == 200)
      return ItmeModelContinent.fromJson(json.decode(response.body));
    else
      throw Exception('Failed to load post');
  }

  Future<ItemModelAll> fetchAllInfo() async {
    final response = await client.get("https://corona.lmao.ninja/v2/all/");
    if (response.statusCode == 200) 
      return ItemModelAll.fromJson(json.decode(response.body));
    else 
      throw Exception('Failed to load post');
  }
}