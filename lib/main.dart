import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Hello Word App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 34, 200, 226)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  var history = [];

  void generate() {
    current = WordPair.random();
    notifyListeners();
  }

  void increment() {
    history.add(current);
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var current = appState.current;
    var history = appState.history;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            VarCard(pair: current),
            SizedBox(height: 10),
            Text(
              "History",
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(history.join(',')),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                appState.increment();
                appState.generate();
              },
              child: Text('New word'),
            ),
          ],
        ),
      ),
    );
  }
}

class VarCard extends StatelessWidget {
  const VarCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.labelMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontWeight: FontWeight.w700,
      fontSize: 14,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          pair.asLowerCase, 
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
          ),
      ),
    );
  }
}