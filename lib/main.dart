import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'pages/splash_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null); 

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UTS MOBILE PROGRAMING',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false, 
        textTheme: GoogleFonts.poppinsTextTheme(),
        scaffoldBackgroundColor: const Color(0xFFFFE4C8),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFF6A00),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity, // mencegah overflow
      ),
      locale: const Locale('id', 'ID'), // memastikan format tanggal Indonesia
      home: const SplashPage(),
    );
  }
}
