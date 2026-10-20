import 'package:flutter/material.dart';
import 'affordable_pubs_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // Definisce i colori principali dell'applicazione.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      // Imposta la pagina iniziale dell'applicazione.
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // Configura la pagina iniziale e riceve il titolo da visualizzare.
  // Essendo uno StatefulWidget, può aggiornare la propria interfaccia
  // quando cambiano i dati gestiti dal suo stato.

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Memorizza il numero di volte in cui viene premuto il pulsante.
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // setState() comunica a Flutter che lo stato è cambiato
      // e che è necessario aggiornare l'interfaccia.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Costruisce l'interfaccia della pagina.
    // Questo metodo viene eseguito nuovamente quando lo stato cambia,
    // ad esempio dopo una chiamata a setState().

    return Scaffold(
      // Barra superiore dell'applicazione.
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Visualizza il titolo ricevuto dal widget MyHomePage.
        title: Text(widget.title),
      ),

      // Corpo principale della pagina.
      body: Center(
        // Dispone gli elementi in una colonna centrata.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),

            // Mostra il valore aggiornato del contatore.
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            // Aggiunge uno spazio verticale tra gli elementi.
            const SizedBox(height: 30),

            // Pulsante per aprire la pagina dedicata ai pub economici.
            ElevatedButton(
              onPressed: () {
                // Navigator.push() permette di passare a una nuova pagina.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    // Crea la pagina dei pub economici.
                    builder: (context) => const AffordablePubsPage(),
                  ),
                );
              },
              child: const Text('Pub economici'),
            ),
          ],
        ),
      ),

      // Pulsante flottante posizionato in basso a destra.
      floatingActionButton: FloatingActionButton(
        // Incrementa il contatore quando viene premuto.
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}