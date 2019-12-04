# Client (Server-Echo)

### -Funzionamento:

Quest'applicazione è basata su due classi principali(situate in file diversi per rendere il codice più ordinato), collegate tra di loro da una **libreria globals** la quale contiene delle variabili in comune.

Ciascuna classe rappresenta uno screen mostrato a schermo:

- **Client** = nella quale verranno inserite le "credenziali", ovvero nome utente e indirizzo IP del server.
- **Client2** = che rappresenta l'effettiva ChatRoom.

### -Idea Base:

Principalmente per la costruzione di questo Client è stato preso spunto dal vecchio Client Echo, le uniche novità sono l'apparizione dei messaggi in colonna tramite una lista scorrevole, **ListView**, e l'inserimento dei nomi a cui vengono associati i messaggi presenti nella chatRoom.

La libreria Globals contiene 3 variabili a noi utili per riconoscere un messaggio presente nella chatRoom:

-  **`List<String> messaggi = [];`** = in esso vengono inserite i messaggi trasmessi nella chatRoom.
-  **`List<String> userNames = [];`** = in esso vengono inserite i nomi dei Client che inviano i messaggi nella ChatRoom.
-  **`List<bool> mioMessaggio = [];`** = in esso vengono inserite dei *true* o *false* e diranno al Client se il messaggio da visualizzare nella chatRoom sarà suo o di un altro Client esterno.

### -Metodi:

- **`void Connect()`** : [*_metodo usato nella classe Client_*] Vienne effettuato una prima verifica per controllare che lo UserName inserito sia composto da massimo 10 caratteri, dopodichè si cerca di connettere il nostro client socket al server, e nel caso di avvenuta connessione viene inviato al server lo UserName in modo che quest ultimo lo registri, dopodichè ci si sposta nella seconda schermata.
-  **`void Disconnect()`** : [*_metodo usato nella classe Client_*] Chiude il nostro Client, chiudendo così la connessione con il Server, vengono inoltre svuotati i due TextField e riinizializzate le variabili globali(della libreria), riportando tutto alla situazione di partenza.
-  **`void Send()`** : [*_metodo usato nella classe Client2_*] Invia i messaggi contenuti nel TextField al Server e poi vengono salvate nelle tre liste diverse le informazioni sul nostro Client.
-  **`void initState()`** : [*_metodo usato nella classe Client2_*] In questo metodo(appartenente alla StateFulWidget) il nostro Client viene posto in ascolto e i dati che riceverà si dividono in due categorie:
	- **Dati ricevuti per "primi"** (o meglio dire, quando la variabile "isUserName" è uguale a true)  = che rappresentano i UserName del Client esterno che ha inviato il messaggio.
	- **Dati ricevuti per "secondi"** (o meglio dire, quando la variabile "isUserName" è uguale a false)  = che rappresentano i messaggi del Client esterno che lo ha inviato.

### - Grafica:

**[Client] -->** Viene fatta uso del widget principale Scaffold contente:

- Come appBar il widget AppBar.
- Come body il widget Column (con dentro due Widget TextField e una Row(che contiene due Witget RaisedButton).

**[Client2] -->** Viene fatta uso del widget principale Scaffold contenente:

- Come appBar il widget AppBar.
- Come body il widget Column (con dentro un widget ListView.builder(la quale produce dei Container con i nostri messaggi) e un TextField Widget con a fianco un floatingActionButton).
