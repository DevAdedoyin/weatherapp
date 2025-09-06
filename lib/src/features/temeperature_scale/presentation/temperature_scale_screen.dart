import 'package:flutter/material.dart';
import '../data/temperature_data.dart'; // contains TemperatureConverter + TempUnit

class TemperatureScaleScreen extends StatefulWidget {
  const TemperatureScaleScreen({super.key});

  @override
  State<StatefulWidget> createState() => _TemperatureScaleScreenState();
}

class _TemperatureScaleScreenState extends State<TemperatureScaleScreen> {
  TempUnit _selectedUnit = TempUnit.celsius;

  @override
  void initState() {
    super.initState();
    _loadUnit();
  }

  Future<void> _loadUnit() async {
    final unit = await TemperatureConverter.loadUnit();
    setState(() => _selectedUnit = unit);
  }

  Widget _buildUnitCard(String label, TempUnit unit) {
    final isSelected = _selectedUnit == unit;

    return Card(
      color: isSelected ? Colors.red : Colors.white54,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        // side: BorderSide(
        //   color: isSelected ? Colors.red : Colors.grey.shade300,
        //   width: 2,
        // ),
      ),
      child: RadioListTile<TempUnit>(
        title: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
          ),
        ),
        value: unit,
        groupValue: _selectedUnit,
        activeColor: Colors.white,
        onChanged: (value) async {
          setState(() => _selectedUnit = value!);
          await TemperatureConverter.saveUnit(value!);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Temperature Unit",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: isDarkMode ? Colors.red : Colors.blue,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(isDarkMode
                  ? "assets/images/darkmode.jpg"
                  : "assets/images/sky.jpg"),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              _buildUnitCard("Celsius (°C)", TempUnit.celsius),
              _buildUnitCard("Fahrenheit (°F)", TempUnit.fahrenheit),
              _buildUnitCard("Kelvin (K)", TempUnit.kelvin),
            ],
          ),
        ),
      ),
    );
  }
}
