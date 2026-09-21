import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const MyHomePage(title: 'CS 442 MAD Hot Relaod Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _resetCount = 0;
  final int myThreshold = 11;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
      _resetCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Times you Pushed the :'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            if (_counter > myThreshold)
              const Text(
                "You're on a roll!",
                style: TextStyle(color: Colors.green),
              ),
            const SizedBox(height: 12),
            Text('Resets used: $_resetCount'),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _resetCounter,
            tooltip: 'Reset',
            heroTag: 'reset',
            child: const Icon(Icons.refresh),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            heroTag: 'increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
      persistentFooterButtons: const [
        Text('Built by Bibi Rabbia · 04072313042'),
      ],
    );
  }
}
