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

  // Get the available units based on the selected category
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

  // Initialize default units
  @override
  void initState() {
    super.initState();
    fromUnit = getAvailableUnits().first;
    toUnit = getAvailableUnits().last;
  }

  // Perform the conversion
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
              _buildCategorySelection(),

              // From and To Unit Selection
              _buildUnitSelection(availableUnits),

              // Input Value Field
              _buildInputValueField(),

              // Result Display
              const SizedBox(height: 16),
              ConversionResult(result: result),
              // Result Display
              const SizedBox(height: 16),

              // Convert Button
              _buildConvertButton(),
            ],
          ),
        ),
      ),
    );
  }

  // Category Selection Widget
  Widget _buildCategorySelection() {
    return Card(
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
    );
  }

  // From and To Unit Selection Widget
  Widget _buildUnitSelection(List<String> availableUnits) {
    return Row(
      children: [
        Expanded(
          child: _buildUnitDropdown('From Unit', fromUnit, (newUnit) {
            setState(() {
              fromUnit = newUnit!;
            });
          }, availableUnits),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildUnitDropdown('To Unit', toUnit, (newUnit) {
            setState(() {
              toUnit = newUnit!;
            });
          }, availableUnits),
        ),
      ],
    );
  }

  // Unit Dropdown Widget
  Widget _buildUnitDropdown(String label, String value,
      ValueChanged<String?> onChanged, List<String> availableUnits) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            DropdownButton<String>(
              value: value,
              isExpanded: true,
              onChanged: onChanged,
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
    );
  }

  // Input Value Field Widget
  Widget _buildInputValueField() {
    return Card(
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
              style: const TextStyle(color: Color.fromARGB(255, 116, 112, 112)),
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
    );
  }

  // Convert Button Widget
  Widget _buildConvertButton() {
    return ElevatedButton(
      onPressed: convert,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        backgroundColor: Colors.blueAccent,
        textStyle: const TextStyle(fontSize: 16),
      ),
      child: const Text(
        'Convert',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
