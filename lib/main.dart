import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const BmiCalculatorApp());
}

class BmiCalculatorApp extends StatelessWidget {
  const BmiCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0E21),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0A0E21),
          elevation: 0,
        ),
      ),
      home: const BmiHomeScreen(),
    );
  }
}

class BmiHomeScreen extends StatefulWidget {
  const BmiHomeScreen({super.key});

  @override
  State<BmiHomeScreen> createState() => _BmiHomeScreenState();
}

class _BmiHomeScreenState extends State<BmiHomeScreen> {
  double _height = 170.0; // ค่าเริ่มต้นส่วนสูง (ซม.)
  double _weight = 65.0;  // ค่าเริ่มต้นน้ำหนัก (กก.)

  double get _bmi {
    double heightInMeters = _height / 100;
    return _weight / pow(heightInMeters, 2);
  }

  String get _bmiResult {
    double bmiVal = _bmi;
    if (bmiVal < 18.5) {
      return 'น้ำหนักน้อยกว่าเกณฑ์ (ผอม)';
    } else if (bmiVal < 23.0) {
      return 'น้ำหนักปกติ / สมส่วน';
    } else if (bmiVal < 25.0) {
      return 'น้ำหนักเกิน (ท้วม)';
    } else if (bmiVal < 30.0) {
      return 'อ้วนระดับ 1';
    } else {
      return 'อ้วนระดับ 2 (อ้วนมาก)';
    }
  }

  Color get _resultColor {
    double bmiVal = _bmi;
    if (bmiVal < 18.5) {
      return Colors.blue;
    } else if (bmiVal < 23.0) {
      return Colors.green;
    } else if (bmiVal < 25.0) {
      return Colors.amber;
    } else if (bmiVal < 30.0) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('คำนวณค่า BMI'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              color: const Color(0xFF1D1E33),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                child: Column(
                  children: [
                    const Text(
                      'ค่า BMI ของคุณ',
                      style: TextStyle(fontSize: 22, color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _bmi.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _bmiResult,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: _resultColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            // แถบเลื่อนปรับส่วนสูง
            Card(
              color: const Color(0xFF1D1E33),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        const Text('ส่วนสูง: ', style: TextStyle(fontSize: 18, color: Colors.grey)),
                        Text(
                          _height.round().toString(),
                          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        const Text(' ซม.', style: TextStyle(fontSize: 18, color: Colors.grey)),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.pinkAccent,
                        inactiveTrackColor: Colors.grey[700],
                        thumbColor: Colors.pink,
                        overlayColor: Colors.pink.withAlpha(0x29),
                        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
                      ),
                      child: Slider(
                        value: _height,
                        min: 100.0,
                        max: 220.0,
                        divisions: 120, // แบ่งเป็น 120 ช่อง เท่ากับขยับทีละ 1 ซม.
                        label: '${_height.round()} ซม.',
                        onChanged: (double newValue) {
                          setState(() {
                            _height = newValue;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // แถบเลื่อนปรับน้ำหนัก
            Card(
              color: const Color(0xFF1D1E33),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        const Text('น้ำหนัก: ', style: TextStyle(fontSize: 18, color: Colors.grey)),
                        Text(
                          _weight.round().toString(),
                          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        const Text(' กก.', style: TextStyle(fontSize: 18, color: Colors.grey)),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.tealAccent,
                        inactiveTrackColor: Colors.grey[700],
                        thumbColor: Colors.teal,
                        overlayColor: Colors.teal.withAlpha(0x29),
                        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
                      ),
                      child: Slider(
                        value: _weight,
                        min: 30.0,
                        max: 150.0,
                        divisions: 120, // แบ่งเป็น 120 ช่อง เท่ากับขยับทีละ 1 กก.
                        label: '${_weight.round()} กก.',
                        onChanged: (double newValue) {
                          setState(() {
                            _weight = newValue;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}