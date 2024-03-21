import 'package:flutter/material.dart';
import 'package:flutter_frontend/pages/country_page.dart';
import 'package:flutter_frontend/pages/home_page.dart';
import 'package:flutter_frontend/pages/last_info_page.dart';
import 'package:flutter_frontend/pages/profile_page.dart';
//import 'package:flutter_frontend/pages/test_page.dart';
import 'package:flutter_frontend/providers/user_provider.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final log = Logger("Logger");

void main() async {
  initializeDateFormatting('fr_FR', null);
  await dotenv.load(fileName: ".env");

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
      child: MaterialApp(
          title: 'TravelSafe',
          theme: ThemeData(
            dialogTheme: const DialogTheme(surfaceTintColor: Colors.white),
            textTheme: const TextTheme(
              headlineLarge: TextStyle(
                  fontFamily: "Oswald",
                  color: Color(0xFF07020D),
                  fontSize: 64,
                  fontWeight: FontWeight.w400),
              headlineMedium: TextStyle(
                  fontFamily: "Oswald",
                  color: Color(0xFF07020D),
                  fontSize: 32,
                  fontWeight: FontWeight.w400),
              titleLarge: TextStyle(
                  fontFamily: "Poppins",
                  color: Color(0xFF07020D),
                  fontSize: 32,
                  fontWeight: FontWeight.w400),
              titleMedium: TextStyle(
                  fontFamily: "Poppins",
                  color: Color(0xFF07020D),
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
              titleSmall: TextStyle(
                  fontFamily: "Poppins",
                  color: Color(0xFF07020D),
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
              bodyLarge: TextStyle(
                  fontFamily: "Montserrat",
                  color: Color(0xFF07020D),
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
              bodyMedium: TextStyle(
                  fontFamily: "Montserrat",
                  color: Color(0xFF07020D),
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
              bodySmall: TextStyle(
                  fontFamily: "Montserrat",
                  color: Color(0xFF07020D),
                  fontSize: 10,
                  fontWeight: FontWeight.w600),
            ),
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF478B85),
                error: const Color(0xffB3261E)),
            outlinedButtonTheme: OutlinedButtonThemeData(
                style: ButtonStyle(
              shape: MaterialStateProperty.all(const RoundedRectangleBorder(
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
