# **COVID**

L'applicazione ottiene dei dati JSON da internet per alla fine mostrarli a schermo.

Dato che è stato implementato il bloc pattern è utile distinguere i file appartenenti al backend(componente logia) e forend(interfaccia).

## Forend

I file utili per costruire l'interfaccia dell'App sono:
*  main.dart
*  app.dart
*  **ui/appBar_widget.dart**
*  **ui/body_widget.dart**
*  **ui/drawer_widget.dart**
*  ui/country_list.dart

Le app importanti a cui dobbiamo concentrarci sono le prime 3 della cartella ui/ elencata di sopra. Esse infatti andranno a costruire ciascun componente
dell'intero Scaffold Widget.

## Backend

I file utili per poter ottenere e usare i dati JSON sono:
*  repository/covid_apiProvider.dart
*  tutti i file presenti nella cartella **models/...**

I dati così ottenuti verranno immagazzinati nella cartella **repository/repository.dart** e poi verranno utilizzati dal bloc.

## Link esterni

Per potter usare i dati in formato Json si fa uso di tre *url* diversi:
*  https://corona.lmao.ninja/v2/countries/ *per ottenere le informazioni sulle varie nazioni*
*  https://corona.lmao.ninja/v2/continents/ *per ottenere le informazioni sui vari continenti*
*  https://corona.lmao.ninja/v2/all/ *per ottenere le informazioni a livello globale*

Nel file **ui/country_list.dart** poi è presente un FloatingActionButton() widget che se premuto apre un link esterno sul browser: 'https://www.google.com/search?q=coronavirus&oq=coronavirus&aqs=chrome..69i57j35i39j0j69i60l2.2117j0j4&client=ms-android-xiaomi-rev1&sourceid=chrome-mobile&ie=UTF-8'

