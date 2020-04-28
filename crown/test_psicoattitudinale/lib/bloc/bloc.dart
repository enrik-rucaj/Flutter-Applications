import 'package:rxdart/rxdart.dart';

class TestBloc {
  final _screenFetcher = PublishSubject<bool>();

  //These are methods
  Observable<bool> get streamScreen => _screenFetcher.stream;

  fetchFirstScreen() {
    _screenFetcher.sink.add(true);
  }

  fetchSecondScreen() async{
    _screenFetcher.sink.add(false);
  }

  dispose() {
    _screenFetcher.close();
  }
}

final bloc = TestBloc();