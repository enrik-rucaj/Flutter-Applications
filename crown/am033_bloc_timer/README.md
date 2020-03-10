# am033_bloc_timer

L'applicazione esprime in modo ben articolato il bloc pattern!

## bloc

Qui il *bloc* risulta più articolato! Inizializzato con un `StreamSubscription`, il metodo `onTransation()` viene chiamato al momento in cui una *transation* accade
>  A transition occurs when a new event is added and mapEventToState executed. Poi, per rendere facile la lettura abbiamo uno schema del tipo
``` dart
@override
Stream<State> mapEventToState(Event event) async* {
    if (event is EventOne) {
      yield* _mapEventOneToState(event);
    } else if (event is EventTwo) {
      yield* _mapEventTwoToState(event);
    } else if (event is Resume) {
    ...
}

Stream<State> _mapEventOneToState(EventOne eventOne) async* {
    ....
    yield Running(start.duration);
    ...
}

Stream<State> _mapEventTwoToState(EventTwo eventTwo) async* {
    ....
    yield Running(start.duration);
    ...
}
...
```
`yeld*` è il `yeld` ricorsivo. Infine
``` adrt
@override
Future<void> close() { ... }
```
chiamato quando il *bloc* non è più utile: qui eliminiamo la *subscription* al `Ticker`.


