# Cronometro

### -Funzionamento:

Quest'applicazione è composta principalmente da tre bottoni e due caselle di testo (*una visibile e una inizialmente invisibile*).

Ciascuno dei bottoni contiene delle funzioni di controllo del cronometro:

- **_Primo bottone_**: Può sia far partire il tempo che fermarlo.
- **_Secondo bottone_**: Inizialmente è disattivo, quando il cronometro viene fatto partire la prima volta il bottone si attiva. Il suo scopo è di segnare a schermo il tempo del cronometro nel momento in cui si clicca il bottone.
- **_Terzo bottone_**: Serve a eliminare tutti i dati presenti nel cronometro e farlo ripartire da 0.

I text widget invece servono a:

- **_Primo Text Widget_**: E' quello principale e serve principalmente a mostrare a schermo il tempo che è passato dall'avvio del cronometro.
- **_Secondo Text Widget_**: Inizialmente è invisibile, verrà mostrato a schermo una volta che si preme il *Secondo Bottone*.

### -Idea Base:

L'idea base per il funzionamento del cronometro consisteva nell'usare il metodo: `Stream.periodic(Duration(seconds: 1), transfolorm);` per incrementare il cronometro di 1 ogni secondo.

E usare in futuro la classe StreamSubscription ( `StreamSubscription _subscription = incrementa().listen((value)` ) in modo da usare i suoi tre metodi `.pause()`, `.resume()` e `.cancel()` per controllare il flusso degli eventi nello Stream.

### -Metodi:

- **`Stream<int> incrementa()`** : 
	- con `_cronometroAttivo = true;` viene fatto in modo che se lo stesso bottone che chiama questo metodo viene ripremuto, allora possono essere chiamati solo i metodi *pausaCronometro()* o *riprendiCronometro()*, **ma il cronometro non può ripartire dall'inizio richiamando _incrementa( )_**.
	- viene cambiato il colore del bottone centrale indicando che può essere premuto.
	- e infine il metodo restituisce uno stream contenente una serie di eventi prodotti ogni secondo.
- **`void cambiaIcona()`** : viene cambiato l'icona del primo bottone, l'unica istruzione presente in questo metodo inizialmente venne tolta dal metodo *incrementa()* dopo che si è accorti che l'icona veniva cambiata con un ritardo di un secondo dopo essere premuta e non immediatamente.
- **`void pausaCronometro()`** : 
	- Lo stream a cui è collegato il metodo _incrementa()_ mette in pausa i suoi eventi.
	- viene cambiata l'icona del primo bottone.
	- con `_inPausa = true;` viene fatto in modo che se il primo bottone viene ricliccato allora viene chiamato il metodo _riprendiCronometro()_.
- **`void riprendiCronometro()`** : 
	- Lo stream a cui è collegato il metodo _incrementa()_ riprende a produrre i suoi eventi.
	- viene cambiata l'icona del primo bottone.
	- con `_inPausa = false;` viene fatto in modo che se il primo bottone viene ricliccato allora viene chiamato il metodo _pausaCronometro()_.
- **`void reset()`** : lo stream smette di acquisire gli eventi e tutte le variabili ritornano al loro stato iniziale.
- **`void segnalibro()`** : viene mostrata un'icona e un testo a schermo che rappresentano quello che accade quando viene premuto il **_Secondo bottone_**.

### - Rappresentazione tempo: 

Il tempo in minuti e secondi viene rappresnetato da due variabili "locali": minuti e secondi.

*value* : è il valore che rappresenta l'evento nello stream, più precisamente esso rappresenta il totale dei secondi del tempo trascorso.

*minuti* : comprende la parte intera del quoziente ottenuto.

*secondi* : comprende il resto ottenuto.

Attraverso una serie di if (i quali si trovano nel onPressed del primo bottone) viene deciso se la stringa *_writeSecondi* deve stampare a schermo un minuto/secondo senza lo '0' davanti oppure con lo '0'.

### - Grafica:

Viene fatta uso del widget principale Scaffold contente:

- Come appBar il widget AppBar.
- Come body il widget principale Column (con dentro un CircleAvatar e una Row)
- Come floatingActionButton un widget Row (contenente tre widget FloatinActionButton).