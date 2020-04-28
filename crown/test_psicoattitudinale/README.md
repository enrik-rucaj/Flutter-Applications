# Test Psicoattitudinale

L'app è abbastanza semplice. Si fanno uso dei widget Draggable e DragTarget per potere spostare delle immagini.
Ci sono in totale due livelli e una volta finito uno si passa all'altro livello.

## first_screen.dart

In questo file ci sarà tutto il codice inerente al primo livello. Esso consiste nel trascinare delle immagini verso i loro corrispettivi colori

## second_screen.dart

Mentre in questo ci sarà il codice inerente al secondo livello, che consiste nel trascinare delle immagini nei corrispettivi target a grandezza diversa.


In entrambi i file si fa uso di un timer che conta il tempo passato attraverso uno **Stream.periodic()**.
In questi file c'è poi una variabile score, rappresentante il punteggio, che aumenta di 10 se il draggable è corretto e diminuisce di 5 se non è corretto invece.

Per fare in modo che alla fine di uno screen si passi all'altro, si fa uso di uno StreamBuilder al quale arriverà un evento boolean.
Lo StreamBuilder si trova nel **main.dart**.


