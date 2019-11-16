# Client (Server-Echo)

### -Funzionamento:

Questa applicazione flutter **è composta da due screen diversi**. Il primo screen serve a connettere un client con il nostro server, mentre il secondo screen svolge le funzioni di *invio* e *ricevi* dei dati.

- **PrimoScreen**:

	E' composto da due bottoni e  un TextField Widget.

	Funzione dei due bottoni:

	- **_Connect_**: Il suo scopo è quello di permettere una connessione tra server e il nostro client. Nel caso non ci fosse un server a cui collegarsi, viene catturato un errore e gestito in modo tale che l'applicazione non si blocchi.
	- **_Disconnect_**: Il suo scopo è unicamente quello di distruggere la connessione che vi era tra client e server e portare tutto allo stato iniziale (svuotando così anche il contenuto del *TextField*).

- **SecondoScreen**:

	E' composto da un unico bottone, un TextField Widget e da un Container nel quale verrà salvato il messaggio ricevuto dal server.

	- **_Send_**: Questo bottone permette di inviare al server dei dati e mettere il nostro client in ascolto in modo che vengano visualizzati più tardi i dati ricevuti dal server.

I due TextField sopra citati invece servono a:

- **_Primo TextField_**: Inserire l'indirizzo IP della macchina in cui viene avviato il server.
- **_Secondo Text Widget_**: Inserire i dati da inviare al server.

### -Idea base:

Per scrivere il codice in maniera più chiara possibile sono state utilizzate **tre classi** nello stesso progetto.

- **main.dart**, verrà utilizzato per scrivere il codice relativo alla schermata che si presenterà all'apertura dell'App, ovvero *PrimoScreen*.
- **secondoScreen.dart**, verrà utilizzato invece per scrivere il codice che rappresenterà *SecondoScreen*(sopra citato).
- **globals.dart**, quest'ultima viene considerata come **libreria**, infatti il suo unico scopo è quello di permettere alle due classi precedenti di avere accesso alla stessa variabile Socket.

### -Metodi:

- **`void Connect()`** : [*_metodo usato per PrimoScreen_*] Connete il nostro Client al Server, in caso di errore viene gestito quest'ultimo (l'errore) e il programma può continuare da dove vi era rimasto.
-  **`void Disconnect()`** : [*_metodo usato per PrimoScreen_*] Chiude il nostro Client, chiudendo così la connessione con il Server, viene inoltre svuotato il TextField, riportando tutto alla situazione di partenza.
-  **`void Send()`** : [*_metodo usato per SecondoScreen_*] Invia i dati contenuti nel secondo TextField al Server e utilizza il `_client.listen()` per ricevere a sua volta i dati dal Server.

### - Grafica:

**[PrimoScreen] -->** Viene fatta uso del widget principale Scaffold contente:

- Come appBar il widget AppBar.
- Come body il widget Column (con dentro il Widget TextField, e il Widget Riga(contenente a sua volta due raisedButton)).

**[SecondoScreen] -->** Viene fatta uso del widget principale Scaffold contenente:

- Come appBar il widget AppBar.
- Come body il widget Column (con dentro il Widget TextField, un widget raisedButton, e il widget Container con dentro un Text() ).