# Server (Server-Echo)

### -Funzionamento:

Nel seguente codice in Dart dopo aver associato il Server all'indirizzo ip della macchina in cui si avvia e ad una certa porta, si pone in ascolto aspettando che i Client facciano la richiesta di connessione.

Quando un Cliente si connette, il Server svolge una serie di funzioni sottoscritte nel metodo **handleConnection**.

### -Metodo handleConnection():

Questo metodo quando viene eseguito fa un iniziale controllo per vedere che il client che dev'essere inserito alla chatRoom non sia già presente (situazione che si potrebbe verificare nel caso in cui nel **progetto Client** un utente prema più volte il bottone "connect").

Nel caso fosse presente viene semplicemente disattivato/tolto quello vecchio e inserito il Client nuovo. Dopodichè con il nuovo Client viene creato un oggetto ChatClient che verrà poi inserito in una lista chiamata **"clients"**.

La lista **`List<ChatClient> clients = [];`** rappresenta tutti quei Client connessi al server e che parteciperanno alla chatRoom.

### -Classe ChatClient:

E' costituita da 3 campi:

- **`Socket _socket;`** = client connesso alla chatRoom
-  **`String _user;`** = UserName associato al client connesso alla chatRoom
-  **`bool _isUserName = true;`** = indica se il dato ricevuto dall'ascoltatore costituisce il suo UserName o un messaggio.

Quando un oggetto riferito a questa classe si crea, immediatamente il socket viene posto in ascolto e il primo dato che riceverà rappresenterò il suo UserName mentre i seguenti dati rappresenteranno i messaggi inviati dal Client.

Quando un messaggio viene ricevuto nel server il metodo **`void distributeMessage(ChatClient client, String message)`** invia quel messaggio a tutti i Client connessi alla chatRoom a eccezione del client d'origine.
