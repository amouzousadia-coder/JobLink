import 'package:flutter/material.dart';
import 'candidatures/candidatures.dart'; // Importation de la page de candidature

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      debugShowCheckedModeBanner: false,
      home: const Candidatures(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Accueil"),
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: Text("Hello World"),
      ),
      bottomNavigationBar: BottomAppBar(),
    );
  }
}
