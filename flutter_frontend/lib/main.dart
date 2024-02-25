import 'package:flutter/material.dart';
import 'package:flutter_frontend/pages/home_page.dart';
import 'package:flutter_frontend/pages/test_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TravelSafe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF478B85)),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      )),
          )
        ),
        sliderTheme: const SliderThemeData(
          valueIndicatorColor: Color(0xFFA8D6AC),
          valueIndicatorTextStyle: TextStyle(color: Color(0xFFFFFFFF)),
          valueIndicatorShape: RectangularSliderValueIndicatorShape(),
          thumbColor: Color(0xFF575757),
          activeTrackColor: Color(0xFFA8D6AC),
          
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
