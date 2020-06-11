import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/item_model_lista_criptovalute.dart';
import '../models/item_model_storico_criptovaluta.dart';
import '../models/item_model_criptovaluta.dart';


class ApiProvider {
  Client client = Client();
  const ultimiDati = 0;
  final int criptoValuta;
  
  ApiProvider(this.criptoValuta);

  Future<ItemModelListaCriptovalute> fetchCriptoValuteList() async {
    final response = await client.get("https://www.mysite.it/api/criptovalute/");
    if (response.statusCode == 200) 
      return ItemModelListaCriptovalute.fromJson(json.decode(response.body));
    else 
      throw Exception('Failed to load post');
  }

  Future<ItmeModelCriptovaluta> fetchCriptoValuta() async {
    final response = await client.get("https://www.mysite.it/api/criptovalute/$criptoValuta/$ultimiDati");
    if (response.statusCode == 200)
      return ItmeModelCriptovaluta.fromJson(json.decode(response.body));
    else
      throw Exception('Failed to load post');
  }
}
