import 'package:flutter/material.dart';

class ConversionResult extends StatelessWidget {
  final String result;

  const ConversionResult({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        result.isNotEmpty ? result : 'Result will be displayed here.',
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
