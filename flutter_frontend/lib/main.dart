import 'package:flutter/material.dart';
import 'package:flutter_frontend/models/user.dart';
import 'package:flutter_frontend/pages/country_page.dart';
import 'package:flutter_frontend/pages/home_page.dart';
import 'package:flutter_frontend/pages/criteria_form_page.dart';
import 'package:flutter_frontend/pages/last_info_page.dart';
import 'package:flutter_frontend/pages/profile_page.dart';
import 'package:flutter_frontend/pages/test_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => User(null, null, null, null, null, null, null, null,
          null, null, null, null),
      child: MaterialApp(
          title: 'TravelSafe',
          theme: ThemeData(
            textTheme: TextTheme(
              headlineLarge: GoogleFonts.oswald(
                  color: Color(0xFF07020D),
                  fontSize: 64,
                  fontWeight: FontWeight.w400),
              headlineMedium: GoogleFonts.oswald(
                  color: Color(0xFF07020D),
                  fontSize: 32,
                  fontWeight: FontWeight.w400),
              titleLarge: GoogleFonts.poppins(
                  color: Color(0xFF07020D),
                  fontSize: 32,
                  fontWeight: FontWeight.w400),
              titleMedium: GoogleFonts.poppins(
                  color: Color(0xFF07020D),
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
              titleSmall: GoogleFonts.poppins(
                  color: Color(0xFF07020D),
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
              bodyLarge: GoogleFonts.montserrat(
                  color: Color(0xFF07020D),
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
              bodyMedium: GoogleFonts.montserrat(
                  color: Color(0xFF07020D),
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
              bodySmall: GoogleFonts.montserrat(
                  color: Color(0xFF07020D),
                  fontSize: 10,
                  fontWeight: FontWeight.w400),
            ),
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color(0xFF478B85)),
            outlinedButtonTheme: OutlinedButtonThemeData(
                style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              )),
            )),
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
          initialRoute: "/",
          routes: {
            "/": (context) => const HomePage(),
            "/country": (context) => const CountryPage(
                  countryIndex: 1,
                ),
            "/profile": (context) => const ProfilePage(),
            "/news": (context) => const LastInfoPage()
          }),
    );
  }
}
