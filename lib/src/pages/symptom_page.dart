import 'package:flutter/material.dart';

class SymptomPage extends StatefulWidget {
  const SymptomPage({super.key});

  @override
  State<SymptomPage> createState() => _SymptomPageState();
}

class _SymptomPageState extends State<SymptomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text("Symptom Page"),
    ));
  }
}
