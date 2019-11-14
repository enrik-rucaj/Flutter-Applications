# Client-Server Echo

### -Funzionamento:

Quest'applicazione è composta principalmente da tre bottoni, due text field e un widget Text normale.

Funzione dei tre bottoni:

- **_Connect_**: Il suo scopo è quello di permettere una connessione tra server e client, nel caso non ci fosse un server a cui collegarsi, viene catturato un errore e gestito in modo che l'applicazione non si blocchi.
- **_Disconnect_**: Il suo scopo è unicamente quello di distruggere la connessione che vi era tra client e server e portare tutto allo stato iniziale (svuotando così anche il contenuto dei *TextField*).
- **_Send_**: Il suo scopo è quello di inviare al server dei dati e mettere il nostro client in ascolto in modo che vengano visualizzati più tardi i dati ricevuti dal server.

I TextField Widget invece servono a:

- **_Primo TextField_**: Inserire l'indirizzo IP della macchina in cui viene avviato il server.
- **_Secondo Text Widget_**: Inserire i dati da inviare al server.

### -Metodi:

- **`void Connect()`** : Connete il nostro Client al Server, in caso di errore viene gestito quest'ultimo (l'errore) e il programma può continuare da dove vi era rimasto.
-  **`void Disconnect()`** : Chiude il nostro Client, chiudendo così la connessione con il Server, vengono inoltre svuotati i TextField e Text Widget riportando tutto alla situazione di partenza.
-  **`void Send()`** : Invia i dati contenuti nel secondo TextField al Server e utilizza il `_client.listen()` per ricevere a sua volta i dati dal Server.

### - Grafica:

Viene fatta uso del widget principale Scaffold contente:

- Come appBar una Row (contenente a sua volta il titolo e un **_ButtonIcon_** per fare lo switch alla *DarkMode*).
- Come body il widget principale Column (con dentro i Widget TextField, RaisedButton e BoxDecoration).
