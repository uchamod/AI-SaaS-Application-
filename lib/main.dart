import 'package:ai_saas_application/constant/colors.dart';
import 'package:ai_saas_application/firebase_options.dart';
import 'package:ai_saas_application/main_screen.dart';
import 'package:ai_saas_application/provider/premium_user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  Stripe.publishableKey = dotenv.env["STRIPE_PUBLISHABLE_KEY"] ?? "";
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PremiumUser()),
      ],

      //initialize Hive
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "AI text extractor SaaS application",
      debugShowCheckedModeBanner: false,
      //stying data
      theme: ThemeData(
        scaffoldBackgroundColor: secondaryColor,
        fontFamily: GoogleFonts.notoSans().fontFamily,
        appBarTheme: const AppBarTheme(backgroundColor: primaryColor),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: primaryColor,
          elevation: 1,
          selectedItemColor: secondaryColor,
          unselectedItemColor: terneryColor,
        ),
        cardColor: primaryColor,
        //evaluated button theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: horizontalPadding,
            ),
            alignment: Alignment.center,
            fixedSize: const Size.fromWidth(230),
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
            backgroundColor: primaryColor,
          ),
        ),
      ),
      home: MainScreen(),
    );
  }
}
