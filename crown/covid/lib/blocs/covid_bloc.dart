import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/item_model_country.dart';
import '../models/item_model_continent.dart';
import '../models/item_model_all.dart';

class CovidBloc {
  final _repository = Repository();
  final _countriesFetcher = PublishSubject<ItemModelCountry>();
  final _continentsFetcher = PublishSubject<ItmeModelContinent>();
  final _allFetcher = PublishSubject<ItemModelAll>();

  //These are methods
  Observable<ItemModelCountry> get allCountries => _countriesFetcher.stream;
  Observable<ItmeModelContinent> get allContinents => _continentsFetcher.stream;
  Observable<ItemModelAll> get allInfo => _allFetcher.stream;

  fetchAllCountries() async{
    ItemModelCountry itemModel = await _repository.fetchAllCountries();
    _countriesFetcher.sink.add(itemModel);
  }

  Future<ItmeModelContinent> fetchAllContinents() async{
    ItmeModelContinent itemModel = await _repository.fetchAllContinents();
    //_continentsFetcher.sink.add(itemModel);
    return itemModel;
  }
  
  fetchGeneralInfo() async{
    ItemModelAll itemModel = await _repository.fetchAll();
    _allFetcher.sink.add(itemModel);
  }

  dispose() {
    _countriesFetcher.close();
    _continentsFetcher.close();
    _allFetcher.close();
  }
}

final bloc = CovidBloc();