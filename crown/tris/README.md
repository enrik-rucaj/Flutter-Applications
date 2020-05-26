# Tris (Tic Tac Toe)

L'app è abbastanza semplice. Per potter giocare a Tris servono 2 giocatori che interagiranno con lo schermo uno alla volta.
A ciascuna vittoria di uno dei due giocatori, il punteggio del giocatore che ha vinto la partita aumenterà di uno.
Nel caso si volesse resettare il tutto, vi è poi anche un tasto reset che azzererà il tutto.

## HomePage.dart

In questo file ci sarà tutto il corpo del programma. Appena avviato esso farà partire il metodo **resetGame()** che azzererà lo stato di ciascuno dei 9 riquadri della griglia.
E quando ciascuno dei due giocatori interagisce con lo schermo, viene eseguito il metodo **playGame()** che cambierà lo stato del riquadro selezionato. E poi in base allo stato verrà mostrato la croce o il cerchio.
Subito dopo aver cambiato lo stato viene fatto anche un "check" che controlla se ci possono essere possibili vittorie.

Per riazzerare i stati del gioco attraverso il FLoatingActionButton viene richiamato il metodo **resetGame()**