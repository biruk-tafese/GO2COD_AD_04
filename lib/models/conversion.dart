class Conversion {
  // Perform conversion based on category
  static double convert(
      String category, String fromUnit, String toUnit, double value) {
    if (category == 'Length') {
      return _convertLength(fromUnit, toUnit, value);
    } else if (category == 'Weight') {
      return _convertWeight(fromUnit, toUnit, value);
    } else if (category == 'Temperature') {
      return _convertTemperature(fromUnit, toUnit, value);
    } else {
      throw Exception('Unsupported category: $category');
    }
  }

  // Length conversion logic
  static double _convertLength(String fromUnit, String toUnit, double value) {
    const lengthConversions = {
      'Meter': 1.0,
      'Kilometer': 0.001,
      'Centimeter': 100.0,
      'Mile': 0.000621371,
    };

    if (!lengthConversions.containsKey(fromUnit) ||
        !lengthConversions.containsKey(toUnit)) {
      throw Exception('Unsupported length units');
    }

    double valueInMeters = value / lengthConversions[fromUnit]!;
    return valueInMeters * lengthConversions[toUnit]!;
  }

  // Weight conversion logic
  static double _convertWeight(String fromUnit, String toUnit, double value) {
    const weightConversions = {
      'Gram': 1.0,
      'Kilogram': 0.001,
      'Pound': 0.00220462,
      'Ounce': 0.035274,
    };

    if (!weightConversions.containsKey(fromUnit) ||
        !weightConversions.containsKey(toUnit)) {
      throw Exception('Unsupported weight units');
    }

    double valueInGrams = value / weightConversions[fromUnit]!;
    return valueInGrams * weightConversions[toUnit]!;
  }

  // Temperature conversion logic
  static double _convertTemperature(
      String fromUnit, String toUnit, double value) {
    if (fromUnit == toUnit) {
      return value;
    }

    if (fromUnit == 'Celsius') {
      if (toUnit == 'Fahrenheit') {
        return (value * 9 / 5) + 32;
      } else if (toUnit == 'Kelvin') {
        return value + 273.15;
      }
    } else if (fromUnit == 'Fahrenheit') {
      if (toUnit == 'Celsius') {
        return (value - 32) * 5 / 9;
      } else if (toUnit == 'Kelvin') {
        return ((value - 32) * 5 / 9) + 273.15;
      }
    } else if (fromUnit == 'Kelvin') {
      if (toUnit == 'Celsius') {
        return value - 273.15;
      } else if (toUnit == 'Fahrenheit') {
        return ((value - 273.15) * 9 / 5) + 32;
      }
    }

    throw Exception('Unsupported temperature conversion');
  }
}
