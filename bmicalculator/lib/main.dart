import 'package:flutter/material.dart';

void main() {
  runApp(const BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  const BMICalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Center(
        child: MyHomePage(title: 'BMI Calculator'),
      ),
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
  TextEditingController weightValue = TextEditingController();
  TextEditingController heightValue = TextEditingController();
  double? bmi;

  void calculateBMI() {
    final String weightText = weightValue.text.trim();
    final String heightText = heightValue.text.trim();

    if (weightText.isEmpty || heightText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please enter all of your weight and height')),
      );
      setState(() {
        bmi = null;
      });
      return;
    }

    if (weightText == '0' || heightText == '0') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Please enter valid number of your weight and height')),
      );
      setState(() {
        bmi = null;
      });
      return;
    }

    final double weight = double.parse(weightText);
    final double height = double.parse(heightText) / 100;
    if (height > 0) {
      double calculatedBMI = weight / (height * height);
      setState(() {
        bmi = calculatedBMI;
      });
    } else {
      setState(() {
        bmi = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text(widget.title),
      ),
      backgroundColor: Color.fromARGB(255, 246, 221, 204),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Please put your weight and height to calculate your BMI',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Column(
              children: <Widget>[
                SizedBox(
                  width: 240,
                  height: 100,
                  child: TextFormField(
                    controller: weightValue,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: const BorderSide(
                            color:
                                Colors.white), // Set the border color to white
                      ),
                      labelText: 'Weight (kg)',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 240,
                  height: 100,
                  child: TextFormField(
                    controller: heightValue,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      labelText: 'Height (cm)',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: calculateBMI,
                    child: const Text('Calculate BMI'),
                  ),
                ),
                const SizedBox(height: 20),
                bmi != null
                    ? Column(
                        children: [
                          Text('Your BMI: ${bmi!.toStringAsFixed(1)}'),
                          const SizedBox(height: 20),
                          Text(
                            _getBMIInterpretation(bmi!),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

String _getBMIInterpretation(double bmi) {
  if (bmi < 18.5) {
    return 'Skinny';
  } else if (bmi >= 18.5 && bmi <= 22.9) {
    return 'Normal weight';
  } else if (bmi >= 23 && bmi < 24.9) {
    return 'Overweight level 1';
  } else if (bmi >= 25 && bmi < 29.9) {
    return 'Overweight level 2';
  } else {
    return 'Obese';
  }
}
