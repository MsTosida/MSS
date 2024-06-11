import 'dart:typed_data';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'HashService.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  String _Data = "";
  bool _isButtonDisabled = false;

  Future<void> _generateKey() async {
    int maxRetries = 3;
    int retries = 0;
    setState(() {
      _isButtonDisabled = true;
    });

    while (retries < maxRetries) {
      try {
        Uint8List accelerometerData = await HashFunctionService.getData();
        String s = String.fromCharCodes(accelerometerData);
        Codec<String, String> stringToBase64 = utf8.fuse(base64);
        setState(() {
          _Data = stringToBase64.encode(s);
          _isButtonDisabled = false;
        });
        return;
      } catch (e) {
        print("Ошибка при получении данных акселерометра: $e");
        if (retries == maxRetries - 1) {
          setState(() {
            _isButtonDisabled = false;
          });
          return;
        }
        await Future.delayed(const Duration(seconds: 2));
        retries++;
      }
    }
  }

  Future<void> _getString() async {
    try {
      String res = await AccelerometerService.getString();

      setState(() {
        _accelerometerData = res;
        _isButtonDisabled = false;
      });
    } catch (e) {
      print("Ошибка при получении данных акселерометра: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: _isButtonDisabled ? null : _generateKey,
                child: const Text('Генерация ключа'),
              ),
              const SizedBox(height: 20),
              Text('Accelerometer Data: $_accelerometerData'),
              ElevatedButton(
                onPressed: _isButtonDisabled ? null : _getString,
                child: const Text('Test'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
