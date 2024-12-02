import 'package:flutter/material.dart';
import '../widgets/conversion_result.dart';
import '../models/conversion.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'Length'; // Default category
  String fromUnit = 'Meter'; // Default 'From' unit
  String toUnit = 'Kilometer'; // Default 'To' unit
  double value = 1; // Default input value
  String result = ''; // Conversion result

  List<String> getAvailableUnits() {
    switch (selectedCategory) {
      case 'Length':
        return ['Meter', 'Kilometer', 'Centimeter', 'Mile'];
      case 'Weight':
        return ['Gram', 'Kilogram', 'Pound', 'Ounce'];
      case 'Temperature':
        return ['Celsius', 'Fahrenheit', 'Kelvin'];
      default:
        return [];
    }
  }

  @override
  void initState() {
    super.initState();
    fromUnit = getAvailableUnits().first;
    toUnit = getAvailableUnits().last;
  }

  void convert() {
    try {
      double convertedValue =
          Conversion.convert(selectedCategory, fromUnit, toUnit, value);
      setState(() {
        result = '$value $fromUnit = $convertedValue $toUnit';
      });
    } catch (e) {
      setState(() {
        result = 'Error: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableUnits = getAvailableUnits();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Modern Unit Converter'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Category Selection
              Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Select a Category',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DropdownButton<String>(
                        value: selectedCategory,
                        isExpanded: true,
                        onChanged: (newCategory) {
                          setState(() {
                            selectedCategory = newCategory!;
                            fromUnit = getAvailableUnits().first;
                            toUnit = getAvailableUnits().last;
                          });
                        },
                        items: ['Length', 'Weight', 'Temperature']
                            .map((category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),

              // From Unit Selection
              Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'From Unit',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DropdownButton<String>(
                        value: fromUnit,
                        isExpanded: true,
                        onChanged: (newUnit) {
                          setState(() {
                            fromUnit = newUnit!;
                          });
                        },
                        items: availableUnits
                            .map((unit) => DropdownMenuItem(
                                  value: unit,
                                  child: Text(unit),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),

              // To Unit Selection
              Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'To Unit',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DropdownButton<String>(
                        value: toUnit,
                        isExpanded: true,
                        onChanged: (newUnit) {
                          setState(() {
                            toUnit = newUnit!;
                          });
                        },
                        items: availableUnits
                            .map((unit) => DropdownMenuItem(
                                  value: unit,
                                  child: Text(unit),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),

              // Input Value Field
              Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Enter Value',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'Enter the value to convert',
                        ),
                        onChanged: (input) {
                          setState(() {
                            value = double.tryParse(input) ?? 0.0;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Convert Button
              ElevatedButton(
                onPressed: convert,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  backgroundColor: Colors.blueAccent,
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text('Convert'),
              ),

              // Result Display
              const SizedBox(height: 16),
              ConversionResult(result: result),
            ],
          ),
        ),
      ),
    );
  }
}
