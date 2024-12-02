import 'package:flutter/material.dart';
import '../utils/constants.dart';

class UnitDropdown extends StatelessWidget {
  final String category;
  final ValueChanged<String?> onChanged;

  const UnitDropdown(
      {super.key, required this.category, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    // Get the list of units for the selected category
    List<String> units = Constants.units[category] ?? [];

    return DropdownButton<String>(
      value: units.isNotEmpty ? units[0] : '',
      onChanged: onChanged,
      items: units
          .map((unit) => DropdownMenuItem(
                value: unit,
                child: Text(unit),
              ))
          .toList(),
    );
  }
}
