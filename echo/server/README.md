# Server (Server-Echo)

### -Funzionamento:

Il seguente codice in Dart dopo aver associato il Server all'indirizzo ip della macchina in cui si avvia e ad una certa porta, si ponte in ascolto aspettando che i Client facciano la richiesta di connessione.

Quando un Cliente si connette, il Server svolge una serie di funzioni sottoscritte nel metodo **handleConnection**.

### -Metodo handleConnection():

Questo metodo quando riceve dei dati (in questo caso si tratta di stringhe) da un Client, si può trovare davanti a tre opzioni:

- **opzione1**: se la stringa inizia con il carattere '=' ed ha una lunghezza di 4 caratteri, allora si suppone che si tratti di un espressione di livello base(**_operando_ *operatore* _operando_**) e il Server restituisce il risultato di tale espressione. 

- **opzione2**: se la stringa inviata è uguale a quelle gestite nello `switch (str) {...}` allora il Server invierà al Client una determinata risposta.

- **opzione3**: se la stringa non viene gestita in nessun modo dal Server, allora viene semplicemente reinviata al Client.

### -Regole da seguire:

Le regole da seguire per permettere un funzionamento ottimale del Server sono:

-*Non si deve inviare al Server nessuna stringa che inizi con il carattere '=' a meno che non si tratti di una espressione basica.*

-*Nel caso si volesse aggiungere nella zona `switch (str) {...}` un'altro tipo di stringa da poter gestire, questa deve terminare con il carattere '!' o '?'.*