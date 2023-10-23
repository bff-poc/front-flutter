import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter BFF Example',
      home: const MyHomePage(title: 'Flutter BFF Example'),
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
  String _dataFromBFF = ''; // Para armazenar os dados do BFF

  Future<void> _fetchDataFromBFF() async {
    final response = await http.get(
      Uri.parse('http://localhost:8080/flutter-request'),
      headers: {'Origin': 'http://localhost:8081'},
    );

    if (response.statusCode == 200) {
      final data = response.body;
      setState(() {
        _dataFromBFF = data;
      });
    } else {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                _fetchDataFromBFF();
              },
              child: Text('Solicitar Dado do BFF'),
            ),
            SizedBox(height: 20),
            Text(
              'Dado do BFF: $_dataFromBFF',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
}
